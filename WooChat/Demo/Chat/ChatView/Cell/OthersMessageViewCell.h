//
//  OthersMessageViewCell.h
//  WooChat
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DialogueModel;
@interface OthersMessageViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *MessageLabelBKImage;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *voiceImage;


@property (nonatomic, strong) DialogueModel *model;
- (void)removeTime;
@end
