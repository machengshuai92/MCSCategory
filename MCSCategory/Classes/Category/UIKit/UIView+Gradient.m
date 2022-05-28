//
//  UIView+Gradient.m
//  MCSCategory
//
//  Created by mcs on 2022/5/25.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)

- (void)addGradientColors:(NSArray *)colors andGradientPosition:(GradientPosition)position insertAtIndex:(unsigned int)index{
    
    [self layoutIfNeeded];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    switch (position) {
        case PositonHorizontal:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 0);
            break;
        case PositonVertical:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
        case PositionUpLeft:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            break;
        case PositionUpRight:
            gradientLayer.startPoint = CGPointMake(1.0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
        default:
            break;
    }
    
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:index];
    
}

- (void)addGradientColors:(NSArray *)colors andGradientPosition:(GradientPosition)position insertAtIndex:(unsigned int)index andRadius:(CGFloat)radius{
    
    [self layoutIfNeeded];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    switch (position) {
        case PositonHorizontal:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 0);
            break;
        case PositonVertical:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
        case PositionUpLeft:
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 1.0);
            break;
        case PositionUpRight:
            gradientLayer.startPoint = CGPointMake(1.0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1.0);
            break;
        default:
            break;
    }
    
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:index];
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    
}

@end
