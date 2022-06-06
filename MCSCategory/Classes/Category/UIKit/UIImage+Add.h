//
//  UIImage+UU.h
//  UU
//
//  Created by Chine on 2015/1/12.
//  Copyright (c) 2015年 UU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Add)

/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

- (UIImage*)originImageScaleToSize:(CGSize)size;  //压缩图片尺寸的大小，重新生成图片的尺寸,缩的形式

+ (NSData *)imageCompressToData:(UIImage *)image;


/**
 * 压缩图片到指定文件大小
 * @method compressOriginalImage
 * @param image 目标图片
 * @param size 目标大小（最大值）
 *
 * @return 返回的图片文件
 */
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

/**
 * 计算图片大小
 */
- (void)calulateImageFileSize:(UIImage *)image;

-(UIImage *)fixWithOrientation:(UIImageOrientation)orientation;//修正图片转向

/**
 Create and return a 1x1 point size image with the given color.
 
 @param color  The color.
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color;

/**
 Create and return a pure color image with the given color and size.
 
 @param color  The color.
 @param size   New image's type.
 */
+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 获取网络视频第一帧
/// @param urlString 地址
- (nullable UIImage *)getVideoPreviewImage:(NSString *_Nonnull)urlString;

@end

