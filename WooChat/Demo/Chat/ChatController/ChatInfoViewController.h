//
//  ChatInfoViewController.h
//  WooChat
//
//  Created by qiubo on 2016/11/30.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMSDK.h"
@interface ChatInfoViewController : UIViewController
/**
 *  当前会话
 */
@property (nonatomic, strong)   NIMSession  *session;


@end
