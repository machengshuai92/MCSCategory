//
//  UIButton+XYButton.h
//  MiAiApp
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /// 图片在左，文字在右
    ImagePositionStyleDefault,
    /// 图片在右，文字在左
    ImagePositionStyleRight,
    /// 图片在上，文字在下
    ImagePositionStyleTop,
    /// 图片在下，文字在上
    ImagePositionStyleBottom,
} ImagePositionStyle;

typedef void(^CountdownCompletionBlock)(void);

@interface UIButton (XYButton)

@property(nonatomic ,copy)void(^block)(UIButton*);


/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)imagePositionStyle:(ImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;

/**
 *  设置图片与文字样式（推荐使用）
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 *  @param imagePositionBlock     在此 Block 中设置按钮的图片、文字以及 contentHorizontalAlignment 属性
 */
- (void)imagePositionStyle:(ImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *button))imagePositionBlock;


/** 倒计时，s倒计 */
- (void)countdownWithSec:(NSInteger)time;
/** 倒计时，秒字倒计 */
- (void)countdownWithSecond:(NSInteger)second;
/** 倒计时，s倒计,带有回调 */
- (void)countdownWithSec:(NSInteger)sec completion:(CountdownCompletionBlock)block;
/** 倒计时,秒字倒计，带有回调 */
- (void)countdownWithSecond:(NSInteger)second completion:(CountdownCompletionBlock)block;

/**
 *  点赞动画
 */
- (void)startZanAnimation;

/** UIButton 点击block */
-(void)addTapBlock:(void(^)(UIButton*btn))block;

@end
