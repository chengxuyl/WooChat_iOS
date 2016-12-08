//
//  MyMessageViewCell.h
//  WooChat
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DialogueModel;
@interface MyMessageViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *butterfly;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fly;
@property (weak, nonatomic) IBOutlet UILabel *read;
@property (strong, nonatomic) IBOutlet UIImageView *MessageLabelBKImage;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) DialogueModel *model;
- (void)removeTime;
- (void)addTime;
@end
