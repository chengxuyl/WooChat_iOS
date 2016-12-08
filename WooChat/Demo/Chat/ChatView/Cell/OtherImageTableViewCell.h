//
//  OtherImageTableViewCell.h
//  WooChat
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DialogueModel;
@interface OtherImageTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImage;

@property (strong, nonatomic) IBOutlet UIImageView *MessageImage;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) DialogueModel *model;

@property NSString *path;
@property NSString *thumbPath;
- (void)removeTime;
@end
