//
//  AdvertisementModel.h
//  WooChat
//
//  Created by yuling on 16/11/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementModel : NSObject
@property (nonatomic, strong) NSString *adicon;//广告代表图url
@property (nonatomic, strong) NSString *adid;//广告id
@property (nonatomic, strong) NSString *adsubject;//广告标题
@property (nonatomic, strong) NSString *adtype;//广告类型（1：HTML，2：视频）
@property (nonatomic, strong) NSString *score;//广告积分
@end
