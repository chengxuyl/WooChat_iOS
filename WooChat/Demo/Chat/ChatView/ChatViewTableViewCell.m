//
//  ChatViewTableViewCell.m
//  WooChat
//
//  Created by qiubo on 2016/11/21.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ChatViewTableViewCell.h"

@interface ChatViewTableViewCell ()

@end
@implementation ChatViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.conLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.noLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(20, 10, self.contentView.height - 20, self.contentView.height - 20);
    self.iconImageView.layer.cornerRadius = self.iconImageView.height /2;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.nameLabel.frame = CGRectMake(self.iconImageView.right + 10, self.contentView.height / 2 - 20 , self.contentView.width / 2, 20);
    
    self.conLabel.frame = CGRectMake(self.nameLabel.x, self.nameLabel.bottom, self.nameLabel.width, self.nameLabel.height);
    self.conLabel.textColor = MYCOLOR_GRAY;
    self.conLabel.font = [UIFont systemFontOfSize:15];
    
    self.timeLabel.frame = CGRectMake(self.contentView.width - self.contentView.width / 2 - 20, self.nameLabel.y, self.contentView.width / 2, self.nameLabel.height);
    self.timeLabel.textColor = MYCOLOR_GRAY;
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    
    self.noLabel.frame = CGRectMake(self.iconImageView.right-self.iconImageView.width/3, self.iconImageView.y, self.iconImageView.width/3, self.iconImageView.width/3);
    self.noLabel.layer.cornerRadius = self.iconImageView.width/6;
    self.noLabel.layer.masksToBounds = YES;
    self.noLabel.backgroundColor = [UIColor redColor];
    self.noLabel.textColor = [UIColor whiteColor];
    self.noLabel.font = [UIFont systemFontOfSize:12];
    self.noLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - setters and getters

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}

- (UILabel *)conLabel{
    if (!_conLabel) {
        _conLabel = [UILabel new];
    }
    return _conLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
    }
    return _timeLabel;
}

- (UILabel *)noLabel{
    if (!_noLabel) {
        _noLabel = [UILabel new];
    }
    return _noLabel;
}

+ (NSString *)cellIdentifier{
    return @"ChatViewTableViewCell";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
