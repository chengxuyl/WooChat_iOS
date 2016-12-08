//
//  DialogueViewController.h
//  WooChat
//
//  Created by apple on 16/8/29.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMSDK.h"
@class FriendsInfoModel;
@interface DialogueViewController : UIViewController
@property (nonatomic, strong) NIMRecentSession *recent;
@property (nonatomic, strong) NIMSession *session;
@property (nonatomic, assign) BOOL friendIn;
@property (nonatomic, strong) void(^AudioDone)();
@property NSMutableArray *sendPicArr;
@property FriendsInfoModel *mod;
- (void)ImageSend:(UIImage *)sendImage;



@end

@interface CustomdBtn : UIButton

@end
