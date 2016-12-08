//
//  MyMessageViewCell.m
//  WooChat
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "MyMessageViewCell.h"
#import "DialogueModel.h"
@implementation MyMessageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *image = [UIImage imageNamed:@"common_message_bg_ios"];
    UIEdgeInsets insets = UIEdgeInsetsMake(33, 6, 6, 15);
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    [_MessageLabelBKImage setImage:image];
    
    [_read mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_MessageLabelBKImage.mas_left).with.offset(-5);
    }];
    self.read.hidden = YES;
    
    self.fly.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"butterfly_fly_03"], [UIImage imageNamed:@"butterfly_fly_02"], [UIImage imageNamed:@"butterfly_fly_01"],nil];
    [self.fly setAnimationDuration:0.3f];
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)removeTime{
    [_timeLabel removeFromSuperview];
        
    [_MessageLabelBKImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(17);
    }];
}

- (void)addTime{
    [_timeLabel addSubview:self.contentView];
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
