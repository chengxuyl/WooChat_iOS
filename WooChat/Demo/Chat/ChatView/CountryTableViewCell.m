//
//  CountryTableViewCell.m
//  WooChat
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "CountryTableViewCell.h"

@implementation CountryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.countryNameLabel];
        [self.contentView addSubview:self.countryImageView];
        [self.contentView addSubview:self.voiceImage];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.countryImageView.frame = CGRectMake(20, 5, 40, 40);
    self.voiceImage.frame = CGRectMake(self.contentView.width - 30, self.countryImageView.y +10, 20, 20);
    self.countryNameLabel.frame = CGRectMake(self.countryImageView.right +10, self.countryImageView.y, self.voiceImage.x - self.countryImageView.right, self.countryImageView.height);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UIImageView *)countryImageView{
    if (!_countryImageView) {
        _countryImageView = [UIImageView new];
    }
    return _countryImageView;
}

- (UILabel *)countryNameLabel{
    if (!_countryNameLabel) {
        _countryNameLabel = [UILabel new];
    }
    return _countryNameLabel;
}

- (UIImageView *)voiceImage{
    if (!_voiceImage) {
        _voiceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"translate_listener_normal"]];
    }
    return _voiceImage;
}


+ (NSString *)cellIdentifier{
    return @"CountryTableViewCell";
}
@end
