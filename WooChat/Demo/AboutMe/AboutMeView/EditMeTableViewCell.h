//
//  EditMeTableViewCell.h
//  WooChat
//
//  Created by yuling on 16/11/14.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditMeTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descripLabel;

@property (nonatomic, strong) NSString *cellType;

+ (NSString *)cellIdentifier;

@end
