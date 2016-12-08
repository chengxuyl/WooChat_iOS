//
//  ServerAPI.h
//  WooChat
//
//  Created by apple on 16/9/3.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ServerBlock)(NSDictionary *resultDict);
@interface ServerAPI : NSObject

@property (nonatomic, strong) NSMutableArray *countryList;
+ (instancetype)sharedAPI;

- (void)serverPostWithName:(NSString *)name WithDic:(NSMutableDictionary *)dic
              completion:(ServerBlock)block;

- (void)upLoadImageWithName:(NSString *)name WithDic:(NSMutableDictionary *)dic key:(NSString *)key
                completion:(ServerBlock)block;

- (void)upLoadFileWithName:(NSString *)name WithDic:(NSMutableDictionary *)dic key:(NSString *)key
                 success:(void(^)(NSDictionary *resultDict))success failure:(void(^)())failure;



@end

