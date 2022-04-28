//
//  MyUtil.m
//  UU
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import "UIUtil.h"
#import "UIButton+XYButton.h"

@implementation UIUtil


+(UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines
{
    UILabel *label = [UILabel new];
    label.text = text;
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    
    label.numberOfLines = numberOfLines;
    label.font=font;
    return label;
}
+(UIButton *)createBtnWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont norImageName:(NSString *)norImageName selImageName:(NSString *)selImageName  bgImageName:(NSString *)bgImageName bgColor:(UIColor *)bgColor  action:(void(^)())action

{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    if (titleFont)
    {
        btn.titleLabel.font = titleFont;
    }
    if (norImageName)
    {
        [btn setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    }
    if (selImageName)
    {
        [btn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    }
    if (bgImageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (bgColor)
    {
        [btn setBackgroundColor:bgColor];
    }
    if (action)
    {
        [btn addTapBlock:^(UIButton *btn) {
            action(btn);
        }];
        
    }
    return btn;
}

+(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (imageName)
    {
        imageView.image = [UIImage imageNamed:imageName];
    }
    return imageView;
}

@end
