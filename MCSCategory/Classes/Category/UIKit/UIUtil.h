//
//  MyUtil.h
//  UU
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtil : NSObject

+(UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;

+(UIButton *)createBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont norImageName:(NSString *)norImageName selImageName:(NSString *)selImageName  bgImageName:(NSString *)bgImageName bgColor:(UIColor *)bgColor  action:(void(^)(UIButton *sender))action;   //创建UIButton

+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

@end
