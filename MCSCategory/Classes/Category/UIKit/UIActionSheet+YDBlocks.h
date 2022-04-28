//
//  UIActionSheet+YDBlocks.h
//  UU
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (YDBlocks)<UIActionSheetDelegate>

+(UIActionSheet *)presentOnView: (UIView *)view
                      withTitle: (NSString *)title
                   cancelButton: (NSString *)cancelString
              destructiveButton: (NSString *)destructiveString
                   otherButtons: (NSArray *)otherStrings
                       onCancel: (void (^)(UIActionSheet *))cancelBlock
                  onDestructive: (void (^)(UIActionSheet *))destroyBlock
                onClickedButton: (void (^)(UIActionSheet *, NSUInteger))clickBlock;
@end
