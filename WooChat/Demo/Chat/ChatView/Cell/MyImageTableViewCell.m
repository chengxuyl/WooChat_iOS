//
//  MyImageTableViewCell.m
//  WooChat
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "MyImageTableViewCell.h"
#import "DialogueModel.h"

@implementation MyImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.read.hidden = YES;
    self.fly.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"butterfly_fly_03"], [UIImage imageNamed:@"butterfly_fly_02"], [UIImage imageNamed:@"butterfly_fly_01"],nil];
    [self.fly setAnimationDuration:0.3f];
}

- (void)removeTime{
    [_timeLabel removeFromSuperview];
    
    [_MessageImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(17);
    }];
}
- (void)setModel:(DialogueModel *)model{
    if (_model != model) {
        _model = model;
    }
}
@end
