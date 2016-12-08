//
//  OthersMessageViewCell.m
//  WooChat
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "OthersMessageViewCell.h"
#import "DialogueModel.h"

@implementation OthersMessageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *image = [UIImage imageNamed:@"common_friend_message_bg_ios"];
    UIEdgeInsets insets = UIEdgeInsetsMake(33, 15, 6, 6);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [_MessageLabelBKImage setImage:image];
    

}
- (void)removeTime{
    [_timeLabel removeFromSuperview];
    
    [_MessageLabelBKImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(17);
    }];
}

- (void)setModel:(DialogueModel *)model{
    if (_model != model) {
        _model = model;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
