//
//  YDBlockImagePicker.m
//  YD
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import "YDBlockImagePicker.h"

@interface YDBlockImagePicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation YDBlockImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (YDBlockImagePicker *)imagePickerDidFinishPickImage:(finishBlock)finishBlock didCancelPickImage:(cancelBlock)cancelBlock{
    
    YDBlockImagePicker *imagePicker= [[YDBlockImagePicker alloc]init];
    imagePicker.delegate = imagePicker;
    imagePicker.cancel = cancelBlock;
    imagePicker.finish = finishBlock;
    return imagePicker;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.cancel(picker);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.finish(info,image);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
@end
