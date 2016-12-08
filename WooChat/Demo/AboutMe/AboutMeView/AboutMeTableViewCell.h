//
//  EditMeTableViewCell.h
//  WooChat
//
//  Created by yuling on 16/11/11.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descripLabel;

+ (NSString *)cellIdentifier;
@end
