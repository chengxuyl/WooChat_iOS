//
//  MyImageTableViewCell.h
//  WooChat
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DialogueModel;
@class MyImageTableViewCell;
@protocol MyImageTableViewCellDelegate <NSObject>

- (void)myImageTapWithCell:(MyImageTableViewCell *)tableViewCell;

@end
@interface MyImageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIImageView *MessageImage;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *read;
@property (weak, nonatomic) IBOutlet UIImageView *fly;
@property NSString *path;
@property NSString *thumbPath;
@property (nonatomic, strong) DialogueModel *model;

@property (nonatomic, assign) id<MyImageTableViewCellDelegate> delegate;
- (void)removeTime;
@end
