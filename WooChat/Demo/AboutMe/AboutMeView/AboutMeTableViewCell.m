//
//  EditMeTableViewCell.m
//  WooChat
//
//  Created by yuling on 16/11/11.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AboutMeTableViewCell.h"

@interface AboutMeTableViewCell ()

@property (nonatomic, strong) UIImageView *codeImageView;
@end
@implementation AboutMeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descripLabel];
        [self.contentView addSubview:self.codeImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //头像
    self.iconImageView.frame = CGRectMake(20, 20, self.contentView.height - 40, self.contentView.height - 40);
    self.iconImageView.layer.cornerRadius = self.iconImageView.width / 2;
    self.iconImageView.layer.masksToBounds = YES;
    
    //名字 个性签名
    self.nameLabel.frame = CGRectMake(self.iconImageView.right + 20, self.iconImageView.y + 8, self.contentView.width - self.iconImageView.right - 10, self.iconImageView.height/3);
    
    self.descripLabel.frame = CGRectMake(self.nameLabel.x, self.nameLabel.bottom, self.nameLabel.width, self.nameLabel.height);
    self.descripLabel.font = [UIFont systemFontOfSize:15];
    self.descripLabel.textColor = MYCOLOR_GRAY;
    self.codeImageView.frame = CGRectMake(self.contentView.width - 20 - self.contentView.height/3, self.contentView.height/3, self.contentView.height/3, self.contentView.height/3);
    
}

#pragma mark - setters and getters
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"originalportrit"];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"毛大毛";
    }
    return _nameLabel;
}

- (UILabel *)descripLabel{
    if (!_descripLabel) {
        _descripLabel = [UILabel new];
        _descripLabel.text = @"超级无敌美丽美少女";
    }
    return _descripLabel;
}

- (UIImageView *)codeImageView{
    if (!_codeImageView) {
        _codeImageView = [UIImageView new];
        _codeImageView.image = [UIImage imageNamed:@"icon_wo_qrcode"];
    }
    return _codeImageView;
}

+ (NSString *)cellIdentifier{
    return @"AboutMeTableViewCell";
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
