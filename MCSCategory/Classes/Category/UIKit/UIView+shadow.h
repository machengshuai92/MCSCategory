//
//  UIView+shadow.h
//  UU
//
//  Created by Frank on 2018/7/25.
//  Copyright © 2018年 UU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (shadow)
@property (nonatomic,assign) BOOL openShadow;

+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
           CornerRadius:(CGFloat)cornerRadius
           ShadowOffset:(CGSize)shadowOffset
                  Color:(UIColor *)color;


- (void)addShadow:(UIView *)view Color:(UIColor *)color;


/*
 此方法用于给无图片的控件设置阴影和圆角
 @params offSet 阴影的偏移量
 @params shadowColor 阴影的颜色
 @params shadowRadius 阴影的圆角半径
 @params shadowOpacity 阴影的透明度
 @params radius 需要的圆角半径
 */
- (void)setShadowWithShadowOffset:(CGSize)offSet shadowColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius;



/*
 此方法用于给有图片的控件设置阴影和圆角  需要传入图片名称 且不要自己手动设置图片 (会出现问题，不知道什么原因导致)
 @params offSet 阴影的偏移量
 @params shadowColor 阴影的颜色
 @params shadowRadius 阴影的圆角半径
 @params shadowOpacity 阴影的透明度
 @params radius 需要的圆角半径
 @params image 给控件设置的图片
 */
- (void)setShadowWithShadowOffset:(CGSize )offSet shadowColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius image:(UIImage *)image;
@end
