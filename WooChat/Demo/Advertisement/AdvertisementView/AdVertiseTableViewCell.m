//
//  AdVertiseTableViewCell.m
//  WooChat
//
//  Created by yuling on 16/11/11.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AdVertiseTableViewCell.h"
#import "AdvertisementModel.h"
#import <UIImageView+WebCache.h>
@interface AdVertiseTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *integralLabel;
@end
@implementation AdVertiseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.integralLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //头像
    self.iconImageView.frame = CGRectMake(20, 8, self.contentView.height-16, self.contentView.height-16);
    self.iconImageView.layer.cornerRadius = self.iconImageView.width/2;
    self.iconImageView.layer.masksToBounds = YES;
    //描述
    self.nameLabel.frame = CGRectMake(self.iconImageView.right +20, self.iconImageView.y, self.contentView.width - self.iconImageView.right - 40, self.iconImageView.height/3);
    
    self.typeLabel.frame = CGRectMake(self.nameLabel.x, self.nameLabel.bottom, self.nameLabel.width, self.nameLabel.height);
    self.typeLabel.textColor = MYCOLOR_GRAY;
    
    self.integralLabel.frame = CGRectMake(self.typeLabel.x, self.typeLabel.bottom, self.typeLabel.width, self.typeLabel.height);
    self.integralLabel.textColor = [UIColor redColor];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.height - 0.5, self.contentView.width, 0.5)];
    line.backgroundColor = MYCOLOR_Line;
    [self.contentView addSubview:line];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - setters and getters
- (void)setModel:(AdvertisementModel *)model{
    if (_model != model) {
        _model = model;
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/6db3ba0f4bfbfbed0b84fdf379f0f736aec31f7d.jpg"] placeholderImage:[UIImage imageNamed:@"originalportrit"]];
        self.nameLabel.text = self.model.adsubject;
        if ([self.model.adtype isEqualToString:@"01"]) {
            self.typeLabel.text = @"图文广告";
        }else {
            self.typeLabel.text = @"视频广告";
        };
        if (self.model.score) {
            self.integralLabel.text = [NSString stringWithFormat:@"积分:%@", self.model.score];
        }else{
            self.integralLabel.text = @"积分:0";
        }
    }
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
//        _iconImageView.image = [UIImage imageNamed:@"originalportrit"];
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"广告名称";
    }
    return _nameLabel;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.text = @"广告类型";
    }
    return _typeLabel;
}

- (UILabel *)integralLabel{
    if (!_integralLabel) {
        _integralLabel = [UILabel new];
        _integralLabel.text = @"积分:50";
    }
    return _integralLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellIdenttifier{
    return @"AdVertiseTableViewCell";
}
@end
