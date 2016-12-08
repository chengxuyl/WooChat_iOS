//
//  ServerAPI.m
//  WooChat
//
//  Created by apple on 16/9/3.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ServerAPI.h"
#import <CommonCrypto/CommonDigest.h>
#import <AFNetworking.h>
#define URLSTR @"http://192.168.1.247:8080/member/%@"

@interface NSString (NIMSHA1)
@end
@implementation NSString(NIMSHA1)
#pragma mark - 加密
- (NSString *)nim_sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end


@interface ServerAPI ()
@property (nonatomic,copy)  NSString    *appKey;
@property (nonatomic,copy)  NSString    *appSecret;
@end

@implementation ServerAPI
+ (instancetype)sharedAPI
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
#pragma mark - 鉴权版本
- (instancetype)init
{
    if (self = [super init])
    {
        _appKey = @"20160803";      //VERSION_ID
        _appSecret = @"125sd35weqfr6";   //SECRET_CODE
    }
    return self;
}
#pragma mark - ServerAPI
//AppVersion    -  客户端的版本号,固化在客户端程序,随 App 版本更新
//Nonce         -  随机数(32 个字符)
//CheckSum      -  SHA1(AppSecret + Nonce ), 两个参数拼接的字符串, 进行 SHA1 哈希计算,转化成 16 进制字符(String,小写)

/**
 *  会员服务器接口
 *        name:请求资源名
 *         dic:参数
 *  block返回值:http响应json
 */
- (void)serverPostWithName:(NSString *)name WithDic:(NSMutableDictionary *)dic
                completion:(ServerBlock)block{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:_appKey forHTTPHeaderField:@"AppVersion"];
    
    NSString *nonce = [NSString stringWithFormat:@"%zd",arc4random()];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    
    NSString *checkSum = [[NSString stringWithFormat:@"%@%@",_appSecret,nonce] nim_sha1];
    [manager.requestSerializer setValue:checkSum forHTTPHeaderField:@"CheckSum"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charest=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *str = [NSString stringWithFormat:URLSTR,name];
    [manager POST:str parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];
}

- (void)upLoadImageWithName:(NSString *)name WithDic:(NSMutableDictionary *)dic key:(NSString *)key completion:(ServerBlock)block{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:_appKey forHTTPHeaderField:@"AppVersion"];
    
    NSString *nonce = [NSString stringWithFormat:@"%zd",arc4random()];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    
    NSString *checkSum = [[NSString stringWithFormat:@"%@%@",_appSecret,nonce] nim_sha1];
    [manager.requestSerializer setValue:checkSum forHTTPHeaderField:@"CheckSum"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charest=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *str = [NSString stringWithFormat:URLSTR,name];
    
    
    [manager POST:str parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        UIImage *image = [dic objectForKey:key];
        NSLog(@"%@---", image);
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1);
        } else {
            data = UIImagePNGRepresentation(image);
        }
        [[NSFileManager defaultManager] createFileAtPath:[NSTemporaryDirectory() stringByAppendingString:@"image.jpg"] contents:data attributes:nil];   //将图片保存为JPEG格式
        
        UIImage *newImage = [UIImage imageWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingString:@"image.jpg"]];
        
        data = UIImageJPEGRepresentation(newImage, 0.000000000001);
        
        NSLog(@"%lu", data.length);

        //这个就是参数
//        [formData appendPartWithFormData:data name:@"image.jpg"];
        [formData appendPartWithFileData :data name:@"1" fileName:@"1.jpg"mimeType:@"image/jpeg"];
    }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

- (void)upLoadFileWithName:(NSString *)name WithDic:(NSMutableDictionary *)dic key:(NSString *)key success:(void(^)(NSDictionary *resultDict))success failure:(void(^)())failure{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:_appKey forHTTPHeaderField:@"AppVersion"];
    
    NSString *nonce = [NSString stringWithFormat:@"%zd",arc4random()];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    
    NSString *checkSum = [[NSString stringWithFormat:@"%@%@",_appSecret,nonce] nim_sha1];
    [manager.requestSerializer setValue:checkSum forHTTPHeaderField:@"CheckSum"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charest=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString *str = [NSString stringWithFormat:URLSTR,name];
    
    
    [manager POST:str parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfFile:[dic objectForKey:key]];
        
        NSLog(@"%lu", data.length);
        
        //这个就是参数
        //        [formData appendPartWithFormData:data name:@"image.jpg"];
        [formData appendPartWithFileData :data name:@"tel" fileName:@"tel.txt"mimeType:@"txt"];
    }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"请求成功");
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        NSLog(@"请求失败：%@",error);
        failure();
    }];
}


- (NSMutableArray *)countryList {
    
    if (!_countryList) {
        
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countryList" ofType:@"txt"]];
        NSError *error = nil;
        
        NSArray * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (!error) {
            
            _countryList = [result copy];
        } 
    }
    
    return _countryList;
}

@end
