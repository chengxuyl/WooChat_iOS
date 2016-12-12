//
//  UserInfo.h
//  WooChat
//
//  Created by qiubo on 2016/11/21.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *imId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *passWord;
@property (nonatomic, strong) NSString *dataBasePath;
@property (nonatomic, strong) NSString *imToken;
@property (nonatomic, strong) NSString *lang;
@property (nonatomic, strong) NSString *voice;
- (void)clear;
@end
