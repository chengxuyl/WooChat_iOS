//
//  DialogueModel.h
//  WooChat
//
//  Created by apple on 16/8/30.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIMSDK.h"
@interface DialogueModel : NSObject
@property NIMMessageType messageType;
@property NIMMessage *message;
@property NSString *text;
@property NSString *time;
@property NSString *myOrOther;
@property NSString *audioPath;
@property NSInteger duration;
@property BOOL isRead;
@property BOOL isPlay;
/**
 *  图片本地路径
 */
@property  NSString *imagePath;
/**
 *  缩略图本地路径
 */
@property  NSString *imageThumbPath;

@property UIImage *imagePic;
@end
