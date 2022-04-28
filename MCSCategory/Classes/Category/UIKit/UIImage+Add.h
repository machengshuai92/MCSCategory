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

/**
 Applies a blur, tint color, and saturation adjustment to this image,
 optionally within the area specified by @a maskImage.
 
 @param blurRadius     The radius of the blur in points, 0 means no blur effect.
 
 @param tintColor      An optional UIColor object that is uniformly blended with
 the result of the blur and saturation operations. The
 alpha channel of this color determines how strong the
 tint is. nil means no tint.
 
 @param tintBlendMode  The @a tintColor blend mode. Default is kCGBlendModeNormal (0).
 
 @param saturation     A value of 1.0 produces no change in the resulting image.
 Values less than 1.0 will desaturation the resulting image
 while values greater than 1.0 will have the opposite effect.
 0 means gray scale.
 
 @param maskImage      If specified, @a inputImage is only modified in the area(s)
 defined by this mask.  This must be an image mask or it
 must meet the requirements of the mask parameter of
 CGContextClipToMask.
 
 @return               image with effect, or nil if an error occurs (e.g. no
 enough memory).
 */
- (nullable UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;


/**
 渲染图片的颜色

 @param color 把图片渲染成哪种颜色
 @return 渲染后的图片
 */
- (UIImage *)renderImageWithColor:(UIColor *)color;
@end
