//
//  OtherImageTableViewCell.m
//  WooChat
//
//  Created by apple on 16/9/9.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "OtherImageTableViewCell.h"
#import "DialogueModel.h"
@implementation OtherImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_MessageImage addGestureRecognizer:tap];
    _MessageImage.userInteractionEnabled = YES;
}

- (void)tap{
    [self.delegate otherImageTapWithCell:self];
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
