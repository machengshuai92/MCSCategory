//
//  YDBlockImagePicker.h
//  YD
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^cancelBlock)(UIImagePickerController *picker);

typedef void(^finishBlock)(NSDictionary *dict,UIImage *image);

@interface YDBlockImagePicker : UIImagePickerController

@property(nonatomic,copy)cancelBlock cancel;

@property(nonatomic,copy)finishBlock finish;


+ (YDBlockImagePicker *)imagePickerDidFinishPickImage:(finishBlock)finishBlock didCancelPickImage:(cancelBlock)cancelBlock;

@end

NS_ASSUME_NONNULL_END
