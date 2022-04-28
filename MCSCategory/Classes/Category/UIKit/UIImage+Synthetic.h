//
//  UIImage+Synthetic.h
//  YYIMageLearn
//
//  Created by Frank on 2019/3/15.
//  Copyright © 2019年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GenerateImageBlock)(UIImage *image);

@interface UIImage (Synthetic)

//生成二维码
+(CIImage *)QRFromUrl:(NSString *)urlStr;
//把二维码变成UIImage
+ (UIImage *)generateUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;
//根据url直接生成图片
+ (UIImage *)generateImage:(NSString *)imageUrl;
//合成图片和文字
//+ (UIImage *)imageAddImage:(UIImage *)imageUrl AvatarImage:(UIImage*)avatarImage QRImage:(UIImage *)qrImage Text:(NSString *)text;
//
//+ (UIImage *)goodsiImageAddImage:(UIImage *)image AvatarImage:(UIImage*)avatarImage QRImage:(UIImage *)qrImage Text:(NSString *)text;
//+(UIImage*)goodDetailImageAddImage:(NSDictionary*)showImageDic WithAddText:(NSDictionary*)textDic;


@end

NS_ASSUME_NONNULL_END
