//
//  UserInfo.m
//  WooChat
//
//  Created by qiubo on 2016/11/21.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize mobile = _mobile;
@synthesize passWord = _passWord;
@synthesize imId = _imId;
@synthesize imToken = _imToken;
@synthesize nickName = _nickName;
+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)clear{
    self.mobile = @"";
    self.passWord = @"";
    self.icon = @"";
    self.imId = @"";
    self.nickName = @"";
    self.uid = @"";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.dataBasePath error:nil];
}

- (NSString *)dataBasePath{
    //建立数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"UserInfoDatabase.db"];
    return dbPath;
}

- (void)setMobile:(NSString *)mobile{
    if (_mobile != mobile) {
        _mobile = mobile;
        [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:@"mobile"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setNickName:(NSString *)nickName{
    if (_nickName != nickName) {
        _nickName = nickName;
        [[NSUserDefaults standardUserDefaults] setObject:_nickName forKey:@"nickName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setPassWord:(NSString *)passWord{
    if (_passWord != passWord) {
        _passWord = passWord;
        [[NSUserDefaults standardUserDefaults] setObject:passWord forKey:@"passWord"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setImId:(NSString *)imId{
    if (_imId != imId) {
        _imId = imId;
        [[NSUserDefaults standardUserDefaults] setObject:imId forKey:@"imId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setImToken:(NSString *)imToken{
    if (_imToken != imToken) {
        _imToken = imToken;
        [[NSUserDefaults standardUserDefaults] setObject:imToken forKey:@"imToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)nickName{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"] length] > 0) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    }else{
        return _nickName;
    }
}

- (NSString *)imId{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"imId"] length] > 0) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"imId"];
    }else{
        return _mobile;
    }
}

- (NSString *)imToken{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"imToken"] length] > 0) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"imToken"];
    }else{
        return _mobile;
    }
}

- (NSString *)mobile{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"] length] > 0) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
    }else{
        return _mobile;
    }
}

- (NSString *)passWord{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"] length] > 0) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    }else{
        return _passWord;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
