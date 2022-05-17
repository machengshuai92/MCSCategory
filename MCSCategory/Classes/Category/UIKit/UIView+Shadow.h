//
//  UIView+shadow.h
//  UU
//
//  Created by Frank on 2018/7/25.
//  Copyright © 2018年 UU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)
@property (nonatomic,assign) BOOL openShadow;

+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
           CornerRadius:(CGFloat)cornerRadius
           ShadowOffset:(CGSize)shadowOffset
                  Color:(UIColor *)color;


/// 通过贝塞尔曲线的方法加载背景圆角
/// @param view 需要加圆角的视图
/// @param color 阴影颜色
/// @param offSet 阴影偏移 (0,-3)
/// @param opacity 阴影透明度
/// @param radius 阴影半径
- (void)addShadowByBezierPathToView:(UIView *)view
                     withShdowColor:(UIColor *)color
                         withOffset:(CGSize)offSet
                        withOpacity:(float)opacity
                         withRadius:(float)radius;


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
