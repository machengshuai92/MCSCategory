//
//  UIViewController+AlertViewAndActionSheet.h
//  MiAiApp
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NO_USE -1000
typedef void(^click)(NSInteger index);
typedef void(^configuration)(UITextField *field, NSInteger index);
typedef void(^clickHaveField)(NSArray<UITextField *> *fields, NSInteger index);

@interface UIViewController (AlertViewAndActionSheet)
#ifdef kiOS8Later

#else
<
UIAlertViewDelegate,
UIActionSheetDelegate
>
#endif

/*!
 *  use alert
 *
 *  @param title    title
 *  @param message  message
 *  @param others   other button title
 *  @param animated animated
 *  @param click    button action
 */
- (void)alertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
                animated:(BOOL)animated
                  action:(click)click;

/*!
 *  use action sheet
 *
 *  @param title             title
 *  @param message           message just system verson max or equal 8.0.
 *  @param destructive       button title is red color
 *  @param destructiveAction destructive action
 *  @param others            other button
 *  @param animated          animated
 *  @param click             other button action
 */
- (void)actionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                   destructive:(NSString *)destructive
             destructiveAction:(click )destructiveAction
                     andOthers:(NSArray <NSString *> *)others
                      animated:(BOOL )animated
                        action:(click )click;

/*!
 *  use alert include textField
 *
 *  @param title         title
 *  @param message       message
 *  @param buttons       buttons
 *  @param number        number of textField
 *  @param configuration configuration textField property
 *  @param animated      animated
 *  @param click         button action
 */
- (void)alertWithTitleIncludeTextField:(NSString *)title
                 message:(NSString *)message
                 buttons:(NSArray<NSString *> *)buttons
         textFieldNumber:(NSInteger )number
           configuration:(configuration )configuration
                animated:(BOOL )animated
                  action:(clickHaveField )click;

@end
