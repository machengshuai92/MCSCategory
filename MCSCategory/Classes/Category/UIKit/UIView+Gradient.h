//
//  UIView+Gradient.h
//  MCSCategory
//
//  Created by mcs on 2022/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GradientPosition){
    ///横向
    PositionHorizontal,
    ///竖向
    PositionVertical,
    ///左上->右下
    PositionUpLeft,
    ///右上->左下
    PositionUpRight
};

@interface UIView (Gradient)

/// 设置渐变色
/// @param colors 颜色数组 (__bridge id)UIColor.redColor.CGColor
/// @param position 渐变方向
/// @param index 插入位置
- (void)addGradientColors:(NSArray *)colors andGradientPosition:(GradientPosition)position insertAtIndex:(unsigned)index;

/// 设置渐变色并且切圆角
/// @param colors 颜色数组 (__bridge id)UIColor.redColor.CGColor
/// @param position 渐变方向
/// @param index 插入位置
/// @param radius 圆角
- (void)addGradientColors:(NSArray *)colors andGradientPosition:(GradientPosition)position insertAtIndex:(unsigned)index andRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
