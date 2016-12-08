//
//  OtherAudioTableViewCell.h
//  WooChat
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DialogueModel;
@class OtherAudioTableViewCell;
@protocol OtherAudioTableViewCellDelegate <NSObject>

- (void)otherAudioTableViewCellTapWithCell:(OtherAudioTableViewCell *)tableViewCell;

@end
@interface OtherAudioTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *messageBKImage;
@property (weak, nonatomic) IBOutlet UILabel *second;
@property (weak, nonatomic) IBOutlet UIImageView *soundImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UILabel *isPlay;
@property (nonatomic, assign) id<OtherAudioTableViewCellDelegate> delegate;
@property (nonatomic, strong) DialogueModel *mod;



//@property (strong, nonatomic) IBOutlet UIImageView *headImage;
//
//@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
//
//@property (strong, nonatomic) IBOutlet UIImageView *messageBKImage;
//
//@property (strong, nonatomic) IBOutlet UILabel *second;
//
//@property (strong, nonatomic) IBOutlet UIImageView *soundImage;
@property NSString *audioPath;
@property NSInteger duration;
- (void)removeTime;
@end
