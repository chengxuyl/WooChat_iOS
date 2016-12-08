//
//  ViewFactory.m
//  CampusOA
//
//  Created by lothario on 15/8/19.
//  Copyright (c) 2015年 OkMelon Inc. @author 赵相庆. All rights reserved.
//

#import "ViewFactory.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@implementation ViewFactory

+ (UIBarButtonItem *)getABarButtonItemWithImage:(NSString *)imageName
                                imageEdgeInsets:(UIEdgeInsets)edeInsets
                                         target:(id)target
                                      selection:(SEL)selectAction {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (target && selectAction) {
        [button addTarget:target action:selectAction forControlEvents:UIControlEventTouchUpInside];
        
    }
    button.imageEdgeInsets = edeInsets;
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}





+ (UIButton *)getAButtonWithTitel:(NSString *)title target:(id)target selection:(SEL)selectAction titleColor:(UIColor *)color {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button addTarget:target action:selectAction forControlEvents:(UIControlEventTouchUpInside)];
    [button setTitleColor:color forState:(UIControlStateNormal)];
    
    return button;
}
+ (void)alertViewShowWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}



@end
