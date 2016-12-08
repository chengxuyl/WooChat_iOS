//
//  AboutMeTableViewCell.m
//  WooChat
//
//  Created by yuling on 16/11/11.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AboutMeHeadTableViewCell.h"
@implementation AboutMeHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(30, self.contentView.height*1/6, self.contentView.height*2/3, self.contentView.height*2/3);
    self.nameLabel.frame = CGRectMake(self.iconImageView.right+20, 0, 150, 30);
    self.nameLabel.centerY = self.contentView.centerY;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.height - 0.5, self.contentView.width, 0.5)];
    line.backgroundColor = MYCOLOR_Line;
    [self.contentView addSubview:line];
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

+ (NSString *)cellIdentifier{
    return @"AboutMeHeadTableViewCell";
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
