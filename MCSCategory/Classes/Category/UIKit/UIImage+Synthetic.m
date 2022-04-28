//
//  UIImage+synthetic.m
//  YYIMageLearn
//
//  Created by Frank on 2019/3/15.
//  Copyright © 2019年 Frank. All rights reserved.
//

#import "UIImage+Synthetic.h"

#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

static CGFloat const QRImageWH = 60;
static CGFloat const AvatarImageWH = 45;
static CGFloat const Margin = 10;
static CGFloat const TextHeight = 15;
static CGFloat const TextPadding = 5;
static CGFloat const ImageToBundle = 64;


@implementation UIImage (Synthetic)

//生成二维码
+(CIImage *)QRFromUrl:(NSString *)urlStr{
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 2、设置数据
    NSString *info = urlStr;
    // 将字符串转换成
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    return outputImage;
}

//把二维码变成UIImage
+ (UIImage *)generateUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)generateImage:(NSString *)imageUrl{
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return  [UIImage imageWithData:data];
}

//+ (UIImage *)imageAddImage:(UIImage *)image AvatarImage:(UIImage*)avatarImage QRImage:(UIImage *)qrImage Text:(NSString *)text{
//
//    NSString *name = UserShared.userInfo.nickName;
//    NSString *tip = @"邀您一起加入芬香";
//    //合作
//    NSString *dowm;
//
//    if([UserShared.userInfo.roleId intValue] == 20){
//        dowm = @"京东社交电商战略合作伙";
//    } else {
//        dowm = @"邀请您享受京东购物内购优惠";
//    }
//
//    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"]};
//    NSDictionary *attr1 = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]};
//    NSDictionary *attr2 = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#999999"]};
//    
//    CGFloat imageW = kScreenWidth - 100;
//    CGFloat imageH = (imageW * image.size.height) / image.size.width;
//    CGFloat textWidth = imageW-QRImageWH-AvatarImageWH-Margin*2;
//    CGFloat textX = Margin + AvatarImageWH + TextPadding;
//    CGFloat textTop = imageH - ImageToBundle + TextPadding;
//    CGSize contextSize = CGSizeMake(imageW, imageH);
//    UIGraphicsBeginImageContextWithOptions(contextSize ,NO, 0.0);
//   
//    [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
//
//    NSURL *url = [NSURL URLWithString:UserShared.userInfo.avatarUrl];
//    NSData * data = [NSData dataWithContentsOfURL:url];
//    UIImage* logoImage =  [UIImage imageWithData:data];
//
//    UIGraphicsBeginImageContextWithOptions(logoImage.size, NO, 0.0);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGRect rect = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
//    CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:logoImage.size.width/2].CGPath);
//    CGContextClip(ctx);
//    [logoImage drawInRect:rect];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [newImage drawInRect:CGRectMake(Margin,textTop+3,AvatarImageWH,AvatarImageWH)];
//    [name drawInRect:CGRectMake(textX,textTop,textWidth,TextHeight) withAttributes:attr];
//    [tip  drawInRect:CGRectMake(textX, textTop+TextHeight+3, textWidth ,TextHeight) withAttributes:attr1];
//    
//    [dowm drawInRect:CGRectMake(textX,textTop+TextHeight*2+5, textWidth,25) withAttributes:attr2];
//    [qrImage drawInRect:CGRectMake(imageW-QRImageWH-Margin, textTop-Margin*2, QRImageWH, QRImageWH)];
//   
//    NSString *longPressStr = @"长按识别";
//    NSMutableParagraphStyle * longPressStyle1 = [[NSMutableParagraphStyle alloc] init];
//    longPressStyle1.alignment=NSTextAlignmentCenter;
//    
//    NSDictionary *longPressStrAttr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:8], NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#999999"], NSParagraphStyleAttributeName:longPressStyle1,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
//    [longPressStr drawInRect:CGRectMake(imageW-QRImageWH-Margin, imageH-15, QRImageWH, 10) withAttributes:longPressStrAttr];
//    
//    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return fullImage;
//}
//
//+(UIImage*)goodDetailImageAddImage:(NSDictionary*)showImageDic WithAddText:(NSDictionary*)textDic{
//
//
//    //主图
//    UIImage* mainImg = [showImageDic valueForKey:@"mainShowImg"];
//    CGFloat imageW = kScreenWidth - 100;
//    CGFloat imageH = imageW+120;
//    CGSize contextSize = CGSizeMake(imageW, imageW+120);
//    UIGraphicsBeginImageContextWithOptions(contextSize ,NO, 0.0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGContextFillRect(context, CGRectMake(0, 0, imageW, imageW+120));
//
//    //画图片
//    [mainImg drawInRect:CGRectMake(0, 0, imageW, imageW)];
//
//    //二维码
//    UIImage* QRImage = [showImageDic valueForKey:@"qrImage"];
//    [QRImage drawInRect:CGRectMake(imageW-60, imageH-60, QRImageWH, QRImageWH)];
//    
//    //长按
//    NSString *longPressStr = @"长按识别";
//    NSMutableParagraphStyle * longPressStyle1 = [[NSMutableParagraphStyle alloc] init];
//    longPressStyle1.alignment=NSTextAlignmentCenter;
//    
//    NSDictionary *longPressStrAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:8], NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#999999"], NSParagraphStyleAttributeName:longPressStyle1,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
//    [longPressStr drawInRect:CGRectMake(imageW-60, imageH-10, QRImageWH, 10) withAttributes:longPressStrAttr];
//
//    //标题
//    NSMutableAttributedString *titleAttrStr = [[NSMutableAttributedString alloc]init];
//
//    NSDictionary *titleDic = @{NSFontAttributeName: [UIFont systemFontOfSize:10],NSBackgroundColorAttributeName:kGeneralColor,NSForegroundColorAttributeName:[UIColor whiteColor]};
//    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc]initWithString:@" 京东 " attributes:titleDic];
//
//    NSDictionary *textAttributed = @{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kHex3Color};
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:[textDic objectForKey:@"title"] attributes:textAttributed];
//    [titleAttrStr appendAttributedString:titleStr];
//    [titleAttrStr appendAttributedString:text];
//    [titleAttrStr drawInRect:CGRectMake(10,imageW+5, imageW-20,30)];
//
//    //券后价
//    NSMutableAttributedString *specialPriceAttrStr = [[NSMutableAttributedString alloc]init];
//
//    NSDictionary *specialPriceDic = @{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor redColor]};
//
//    NSMutableAttributedString *specialPriceStr = [[NSMutableAttributedString alloc]initWithString:@"券后价¥ " attributes:specialPriceDic];
//
//
//    NSDictionary *specialPriceAttrJEStr = @{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
//
//    NSMutableAttributedString *specialPriceJEStr = [[NSMutableAttributedString alloc]initWithString:[textDic objectForKey:@"couponPrice"] attributes:specialPriceAttrJEStr];
//
//    [specialPriceAttrStr appendAttributedString:specialPriceStr];
//    [specialPriceAttrStr appendAttributedString:specialPriceJEStr];
//    [specialPriceAttrStr drawInRect:CGRectMake(10,imageW+40, imageW/3,30)];
//
//    //评论数和好评率
//    NSString *commentNunStr = [textDic objectForKey:@"commentNunStr"];
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle1.alignment=NSTextAlignmentRight;
//
//    NSDictionary *commentNunStrAttr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:8], NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#999999"], NSParagraphStyleAttributeName:paragraphStyle1,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]};
//    [commentNunStr drawInRect:CGRectMake(imageW/3+10,imageW+45, imageW/3*2-20,20) withAttributes:commentNunStrAttr];
//
//    //京东价
//
//    NSMutableAttributedString *jingdongAttrStr = [[NSMutableAttributedString alloc]init];
//
//    NSDictionary *jingdongDic = @{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kRGBAColor(102, 102, 102, 1)};
//
//    NSMutableAttributedString *jingdongStr = [[NSMutableAttributedString alloc]initWithString:@"京东价¥" attributes:jingdongDic];
//
//    NSDictionary *jingdongAttrJEStr = @{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kRGBAColor(102, 102, 102, 1)};
//
//    NSMutableAttributedString *jingdongJEStr = [[NSMutableAttributedString alloc]initWithString:[textDic objectForKey:@"jdPriceStr"] attributes:jingdongAttrJEStr];
//
//    [jingdongJEStr addAttribute:NSStrikethroughStyleAttributeName
//                           value:@(NSUnderlineStyleSingle)
//                           range:[jingdongJEStr.string rangeOfString:[textDic objectForKey:@"jdPriceStr"]]];
//    [jingdongJEStr addAttribute:NSUnderlineColorAttributeName
//                           value:kRGBAColor(102, 102, 102, 1)
//                           range:[jingdongJEStr.string rangeOfString:[textDic objectForKey:@"jdPriceStr"]]];
//
//    [jingdongAttrStr appendAttributedString:jingdongStr];
//    [jingdongAttrStr appendAttributedString:jingdongJEStr];
//    [jingdongAttrStr drawInRect:CGRectMake(10,imageW+65, imageW/3,20)];
//
//    //优惠券
//    NSString *couponStr  = [NSString stringWithFormat:@"优惠券¥%@",[textDic objectForKey:@"couponDiscountStr"]];
//    NSDictionary *couponStrAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor redColor]};
//    [couponStr drawInRect:CGRectMake(imageW/3,imageW+65, imageW/3,20) withAttributes:couponStrAttr];
//
//    //好友
//
//    NSString *friendJingdongStr = [NSString stringWithFormat:@"好友 %@",UserShared.userInfo.nickName];
//    NSDictionary *friendJingdongStrAttr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:10], NSForegroundColorAttributeName : [UIColor blackColor]};
//    [friendJingdongStr drawInRect:CGRectMake(45,imageW+85, imageW/3,15) withAttributes:friendJingdongStrAttr];
//
//    //合作
//    NSString *hezuoStr;
//
//    if([UserShared.userInfo.roleId intValue] == 20){
//         hezuoStr = @"京东社交电商战略合作伙";
//    } else {
//        hezuoStr = @"邀请您享受京东购物内购优惠";
//    }
//
//    NSDictionary *hezuoStrAttr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:8], NSForegroundColorAttributeName : kRGBAColor(102, 102, 102, 1)};
//    [hezuoStr drawInRect:CGRectMake(45,imageW+100, imageW/3,10) withAttributes:hezuoStrAttr];
//
//    //logo
//    NSURL *url = [NSURL URLWithString:UserShared.userInfo.avatarUrl];
//    NSData * data = [NSData dataWithContentsOfURL:url];
//    UIImage* logoImage =  [UIImage imageWithData:data];
//    
//    UIGraphicsBeginImageContextWithOptions(logoImage.size, NO, 0.0);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGRect rect = CGRectMake(0, 0, logoImage.size.width, logoImage.size.height);
//    CGContextAddPath(ctx, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:logoImage.size.width/2].CGPath);
//    CGContextClip(ctx);
//    [logoImage drawInRect:rect];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [newImage drawInRect:CGRectMake(10,imageH-35,30,30)];
//    
//    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return fullImage;
//}

@end
