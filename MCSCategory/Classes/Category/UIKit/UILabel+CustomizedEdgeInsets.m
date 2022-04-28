//
//  UILabel+CustomizedEdgeInsets.m
//  YD
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import "UILabel+CustomizedEdgeInsets.h"
#import <objc/runtime.h>

@implementation UILabel (CustomizedEdgeInsets)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(textRectForBounds:limitedToNumberOfLines:)),
                                   class_getInstanceMethod(self.class, @selector(swizzled_textRectForBounds:swizzled_limitedToNumberOfLines:)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(drawTextInRect:)),
                                   class_getInstanceMethod(self.class, @selector(swizzled_drawTextInRect:)));
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    //id  不让放struct 类型
    NSArray * arr = @[@(edgeInsets.top),@(edgeInsets.left),@(edgeInsets.bottom),@(edgeInsets.right)];
    objc_setAssociatedObject(self, @selector(edgeInsets), arr, OBJC_ASSOCIATION_RETAIN);
}
- (UIEdgeInsets)edgeInsets{
    NSArray * arr = objc_getAssociatedObject(self, @selector(edgeInsets));
    return UIEdgeInsetsMake([arr[0] floatValue], [arr[1] floatValue], [arr[2] floatValue], [arr[3] floatValue]);
}
#pragma mark -
// 修改绘制文字的区域，edgeInsets增加bounds
-(CGRect)swizzled_textRectForBounds:(CGRect)bounds swizzled_limitedToNumberOfLines:(NSInteger)numberOfLines{
    /*
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     CGRect rect = [super textRectForBounds: limitedToNumberOfLines:numberOfLines];
     类别中不能使用 super   用黑魔法替换方法
     */
    CGRect rect = [self swizzled_textRectForBounds:UIEdgeInsetsInsetRect(bounds,self.edgeInsets) swizzled_limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}
//绘制文字
- (void)swizzled_drawTextInRect:(CGRect)rect{
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [self swizzled_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}


-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}
@end
