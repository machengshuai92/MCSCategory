//
//  UIView+shadow.m
//  UU
//
//  Created by Frank on 2018/7/25.
//  Copyright © 2018年 UU. All rights reserved.
//

#import "UIView+Shadow.h"
#import <objc/runtime.h>

static NSString *OPENSHADOW = @"OPENSHADOW";
@implementation UIView (Shadow)

- (void)setOpenShadow:(BOOL)openShadow
{
    objc_setAssociatedObject(self, &OPENSHADOW, @(openShadow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setShadowStyleWithOpenShadow:openShadow];
}

+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
           CornerRadius:(CGFloat)cornerRadius
           ShadowOffset:(CGSize)shadowOffset
                  Color:(UIColor *)color
{
    //////// shadow /////////
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.frame = view.layer.frame;
    
    shadowLayer.shadowColor = color.CGColor;//shadowColor阴影颜色
    shadowLayer.shadowOffset = shadowOffset;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    shadowLayer.shadowOpacity = shadowOpacity;//0.8;//阴影透明度，默认0
    shadowLayer.shadowRadius = shadowRadius;//8;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = shadowLayer.bounds.size.width;
    float height = shadowLayer.bounds.size.height;
    float x = shadowLayer.bounds.origin.x;
    float y = shadowLayer.bounds.origin.y;
    
    CGPoint topLeft      = shadowLayer.bounds.origin;
    CGPoint topRight     = CGPointMake(x + width, y);
    CGPoint bottomRight  = CGPointMake(x + width, y + height);
    CGPoint bottomLeft   = CGPointMake(x, y + height);
    
    CGFloat offset = -1.f;
    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    [path addArcWithCenter:CGPointMake(topLeft.x + cornerRadius, topLeft.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    [path addLineToPoint:CGPointMake(topRight.x - cornerRadius, topRight.y - offset)];
    [path addArcWithCenter:CGPointMake(topRight.x - cornerRadius, topRight.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y - cornerRadius)];
    [path addArcWithCenter:CGPointMake(bottomRight.x - cornerRadius, bottomRight.y - cornerRadius) radius:(cornerRadius + offset) startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y + offset)];
    [path addArcWithCenter:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y - cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
//    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    
    //设置阴影路径
    shadowLayer.shadowPath = path.CGPath;
    
    //////// cornerRadius /////////
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [view.superview.layer insertSublayer:shadowLayer below:view.layer];
    
//    [view.superview.layer insertSublayer:shadowLayer below:view.layer];
}

- (void)addShadowByBezierPathToView:(UIView *)view withShdowColor:(UIColor *)color withOffset:(CGSize)offSet withOpacity:(float)opacity withRadius:(float)radius{
    
    [view layoutIfNeeded];
    
    view.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = offSet;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = opacity;//0.8;//阴影透明度，默认0
    view.layer.shadowRadius = radius;//8;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = view.bounds.size.width;
    float height = view.bounds.size.height;
    float x = view.bounds.origin.x;
    float y = view.bounds.origin.y;
    
    CGPoint topLeft      = view.bounds.origin;
    CGPoint topRight     = CGPointMake(x + width, y);
    CGPoint bottomRight  = CGPointMake(x + width, y + height);
    CGPoint bottomLeft   = CGPointMake(x, y + height);
    
    CGFloat offset = 0.f;
    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y - offset)];
    [path addLineToPoint:CGPointMake(topRight.x + offset, topRight.y - offset)];
    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y + offset)];
    [path addLineToPoint:CGPointMake(bottomLeft.x - offset, bottomLeft.y + offset)];
    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y - offset)];
    
    //设置阴影路径
    view.layer.shadowPath = path.CGPath;
}

- (void)setShadowWithShadowOffset:(CGSize )offSet shadowColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius{
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offSet;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (void)setShadowWithShadowOffset:(CGSize )offSet shadowColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius image:(UIImage *)image{
    
    CALayer *sublayer = [CALayer layer];
    sublayer.shadowOffset = offSet;
    sublayer.shadowRadius = shadowRadius;
    sublayer.shadowColor = shadowColor.CGColor;
    sublayer.shadowOpacity = shadowOpacity;
    sublayer.frame = self.bounds;
    sublayer.cornerRadius = cornerRadius;
    [self.layer addSublayer:sublayer];
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = sublayer.bounds;
    imageLayer.cornerRadius = cornerRadius;
    imageLayer.contents = (id)image.CGImage;
    imageLayer.masksToBounds = YES;
    [sublayer addSublayer:imageLayer];
//    [sublayer addSublayer:imageLayer];
}



- (void)setShadowStyleWithOpenShadow:(BOOL)openShadow{
    if (openShadow == YES)
    {
        // 开启阴影
        self.layer.shadowRadius = 4.f;
        self.layer.shadowOpacity = 0.8f;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(4, 4);
        
    }
}
@end
