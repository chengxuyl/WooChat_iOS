//
//  MyAudioTableViewCell.h
//  WooChat
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DialogueModel;
@class MyAudioTableViewCell;
@protocol MyAudioTableViewCellDelegate <NSObject>

- (void)myAudioTableViewCellTapWithCell:(MyAudioTableViewCell *)tableViewCell;

@end
@interface MyAudioTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *butterfly;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *messageBKImage;
@property (strong, nonatomic) IBOutlet UILabel *second;
@property (strong, nonatomic) IBOutlet UIImageView *soundImage;
@property (weak, nonatomic) IBOutlet UILabel *read;
@property (weak, nonatomic) IBOutlet UIImageView *fly;
@property (nonatomic, assign) id<MyAudioTableViewCellDelegate> delegate;
@property (nonatomic, strong) DialogueModel *mod;
@property NSString *audioPath;
@property NSInteger duration;
- (void)removeTime;

@end
