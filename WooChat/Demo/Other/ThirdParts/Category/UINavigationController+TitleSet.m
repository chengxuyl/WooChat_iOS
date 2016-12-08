//
//  UINavigationController+TitleSet.m
//  采购师_iOS
//
//  Created by Selfmaking on 16/5/12.
//  Copyright © 2016年 cgs. All rights reserved.
//

#import "UINavigationController+TitleSet.h"

@implementation UINavigationController (TitleSet)
- (void)setTitle:(NSString *)title color:(UIColor *)color {
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    titleView.text = title;
    titleView.textColor = color;
    self.navigationItem.titleView = titleView;
}
@end
