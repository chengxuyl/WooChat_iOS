//
//  ChatViewTableViewCell.h
//  WooChat
//
//  Created by qiubo on 2016/11/21.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *conLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *noLabel;
+ (NSString *)cellIdentifier;
@end
