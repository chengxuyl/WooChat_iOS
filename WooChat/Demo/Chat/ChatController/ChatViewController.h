//
//  ChatViewController.h
//  Moatong
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
/**
 *  最近会话集合
 */
@property (nonatomic,readonly) NSMutableArray * recentSessions;

/**
 *  删除会话时是不是也同时删除服务器会话 (防止漫游)
 */
@property (nonatomic,assign)   BOOL autoRemoveRemoteSession;
@end
