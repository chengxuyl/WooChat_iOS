//
//  FriendsDetailedViewController.h
//  WooChat
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendsInfoModel;
@interface FriendsDetailedViewController : UIViewController
//名字
@property (nonatomic ,copy)NSString* friendsName;

@property (nonatomic, strong) FriendsInfoModel *mod;
@end
