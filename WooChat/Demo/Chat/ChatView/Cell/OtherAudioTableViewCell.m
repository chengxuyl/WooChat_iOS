//
//  OtherAudioTableViewCell.m
//  WooChat
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "OtherAudioTableViewCell.h"
#import "DialogueModel.h"
@implementation OtherAudioTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *image = [UIImage imageNamed:@"common_friend_message_bg_ios"];
    UIEdgeInsets insets = UIEdgeInsetsMake(33, 15, 6, 6);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [_messageBKImage setImage:image];
    self.soundImage.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"voicechat_listerner_01"], [UIImage imageNamed:@"voicechat_listerner_02"], [UIImage imageNamed:@"voicechat_listerner_03"],nil];
    [self.soundImage setAnimationDuration:1.0f];
//    CGRect temp = _messageBKImage.frame;
//    temp.size.width = temp.size.width + _duration * 5;
//    _messageBKImage.frame = temp;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSound:)];
    [self.messageBKImage addGestureRecognizer:tap];
    self.messageBKImage.userInteractionEnabled = YES;
}

- (void)tapSound:(UITapGestureRecognizer *)tap{
    [self.delegate otherAudioTableViewCellTapWithCell:self];
}
- (void)removeTime{
    [_timeLabel removeFromSuperview];
    
    [_messageBKImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(17);
    }];
}
- (void)setMod:(DialogueModel *)mod{
    if (_mod != mod) {
        _mod = mod;
    }
}
@end
