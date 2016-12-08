//
//  AdVertiseTableViewCell.h
//  WooChat
//
//  Created by yuling on 16/11/11.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertisementModel;
@interface AdVertiseTableViewCell : UITableViewCell
@property (nonatomic, strong) AdvertisementModel *model;
+ (NSString *)cellIdenttifier;
@end
