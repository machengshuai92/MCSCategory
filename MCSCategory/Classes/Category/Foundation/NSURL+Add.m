//
//  NSURL+UU.m
//  UU
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import "NSURL+Add.h"
#import <AVFoundation/AVFoundation.h>
@implementation NSURL (Add)

- (UIImage *)getScreenShotImageFromVideoPath
{
    UIImage *shotImage;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
    
}
@end
