//
//  ContactsModel.h
//  WooChat
//
//  Created by qiubo on 2016/11/23.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsModel : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *friendId;
@property (nonatomic, strong) NSString *isFriend;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *oidUserId;
@end
