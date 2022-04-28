//
//  UITextView+ResignTool.m
//  UU
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import "UITextView+ResignTool.h"

@implementation UITextView (ResignTool)

-(void)addYDAccessoryView
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width, 40)];
    toolBar.backgroundColor=[UIColor whiteColor];
    UIButton *done_Button=[UIButton buttonWithType:UIButtonTypeCustom];
    [done_Button setFrame:CGRectMake(5,0, 50, 40)];
    [done_Button setTitle:@"完成" forState:UIControlStateNormal];
    [done_Button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [done_Button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [done_Button addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done=[[UIBarButtonItem alloc] initWithCustomView:done_Button];
    toolBar.items = @[space, done];
    self.inputAccessoryView=toolBar;
}
-(void)textFieldDone
{
    [self resignFirstResponder];
}
@end
