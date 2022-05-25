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
    PositonHorizontal,
    ///竖向
    PositonVertical,
    ///左上->右下
    PositionUpLeft,
    ///右上->左下
    PositionUpRight
};

@interface UIView (Gradient)

/// 设置渐变色
/// @param colors 颜色数组 (__bridge id)UIColor.redColor.CGColor
/// @param position 渐变方向
- (void)addGradientColors:(NSArray *)colors andGradientPosition:(GradientPosition)position;

@end

NS_ASSUME_NONNULL_END
