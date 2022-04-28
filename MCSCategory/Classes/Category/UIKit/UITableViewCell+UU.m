//
//  UITableViewCell+UU.m
//  UU
//
//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

#import "UITableViewCell+UU.h"

@implementation UITableViewCell (UU)

-(UITableView *)superTableView
{
    id view = [self superview];
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = [view superview];
    }
    UITableView *tableView = (UITableView *)view;
    return tableView;
}
@end
