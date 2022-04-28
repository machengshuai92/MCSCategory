//
//  UIColor+Tools.h
//
//  Created by iMac on 2015-01-15.
//  Copyright (c) 2015年 赖真运. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIColor (Tools)

+ (UIColor *)randomColor;

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexString: (NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (UIImage*)createImageWithColor:(UIColor *)color withRect:(CGRect)rect;
@end
