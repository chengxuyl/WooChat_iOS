//
//  MyAudioTableViewCell.m
//  WooChat
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "MyAudioTableViewCell.h"
#import "DialogueModel.h"
@implementation MyAudioTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [_second mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_messageBKImage).with.offset(13);
//        make.left.equalTo(_messageBKImage).with.offset(10);
//        make.bottom.equalTo(_messageBKImage).with.offset(13);
//    }];
    
    self.soundImage.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"voicechat_speaker_01"], [UIImage imageNamed:@"voicechat_speaker_02"], [UIImage imageNamed:@"voicechat_speaker_03"],nil];
    [self.soundImage setAnimationDuration:1.0f];
//    [self.soundImage startAnimating];
    
    UIImage *image = [UIImage imageNamed:@"common_message_bg_ios"];
    UIEdgeInsets insets = UIEdgeInsetsMake(33, 6, 6, 15);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [_messageBKImage setImage:image];
    
    self.read.hidden = YES;
    self.fly.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"butterfly_fly_03"], [UIImage imageNamed:@"butterfly_fly_02"], [UIImage imageNamed:@"butterfly_fly_01"],nil];
    [self.fly setAnimationDuration:0.3f];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSound:)];
    [self.messageBKImage addGestureRecognizer:tap];
    self.messageBKImage.userInteractionEnabled = YES;
}

- (void)tapSound:(UITapGestureRecognizer *)tap{
    [self.delegate myAudioTableViewCellTapWithCell:self];
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
