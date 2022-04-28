//
//  UIView+MotionEffect.m
//  LDJY_Student
//
//  Created by 王冰 on 2022/4/19.
//

#import "UIView+MotionEffect.h"

@implementation UIView (MotionEffect)

- (void)startMotionEffectWith:(CGFloat)offset{
    
    UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];;
    
    xAxis.maximumRelativeValue = @(offset);
    xAxis.minimumRelativeValue = @(-offset);
    
    yAxis.maximumRelativeValue = @(offset);
    yAxis.minimumRelativeValue = @(-offset);
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[xAxis,yAxis];
    
    [self addMotionEffect:group];
    
}

@end
