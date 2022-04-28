//
//  UIButton+Rayli.m
//  JIANYIYUN
//
//  Created by 黄鹏华 on 2021/5/27.
//

#import "UIButton+TagString.h"
#import <objc/runtime.h>
static void * keyStr;
@implementation UIButton (TagString)
-(void)setTagString:(NSString *)tagString
{
    objc_setAssociatedObject(self, &keyStr, tagString, OBJC_ASSOCIATION_COPY);
}
-(NSString *)tagString
{
    return objc_getAssociatedObject(self, &keyStr);
}

@end
