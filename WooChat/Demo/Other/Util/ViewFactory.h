//
//  ViewFactory.h
//  CampusOA
//
//  Created by lothario on 15/8/19.
//  Copyright (c) 2015年 OkMelon Inc. @author 赵相庆. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ViewFactory : NSObject

/**
 *  获取一个 BarButton
 *
 *  @param imageName    图片名
 *  @param edeInsets    内部偏移
 *  @param target       target
 *  @param selectAction selectAction
 *
 *  @return BarButton 对象
 */
+ (UIBarButtonItem *)getABarButtonItemWithImage:(NSString *)imageName
                                imageEdgeInsets:(UIEdgeInsets)edeInsets
                                         target:(id)target
                                      selection:(SEL)selectAction;

/**
 *  快速获取 button
 *
 *  @param title        title description
 *  @param target       target description
 *  @param selectAction selectAction description
 *  @param color        color description
 *
 *  @return button
 */
+ (UIButton *)getAButtonWithTitel:(NSString *)title target:(id)target selection:(SEL)selectAction titleColor:(UIColor *)color;

/**
 *  获取一个提示 alertview
 *
 *  @param title   title description
 *  @param message message description
 */
+ (void)alertViewShowWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  获取一条线
 */


/*
 *被他人顶掉提示框
 */



@end
