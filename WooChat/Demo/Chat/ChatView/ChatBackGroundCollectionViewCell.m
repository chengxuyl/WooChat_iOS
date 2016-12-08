//
//  ChatBackGroundCollectionViewCell.m
//  WooChat
//
//  Created by qiubo on 2016/11/30.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ChatBackGroundCollectionViewCell.h"

@interface ChatBackGroundCollectionViewCell ()
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, strong) UILabel *choose;
@property (nonatomic, strong) UIImageView *yes;
@end
@implementation ChatBackGroundCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.backImage];
        [self.backImage addSubview:self.choose];
        [self.contentView addSubview:self.yes];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.backImage.frame = self.contentView.frame;
    self.backImage.layer.cornerRadius = 10;
    self.backImage.layer.masksToBounds = YES;
//    self.backImage.backgroundColor = MYCOLOR_BLUE;
    self.choose.frame = CGRectMake(self.backImage.x, self.backImage.height*4/5, self.backImage.width, self.backImage.height/5);
    self.choose.backgroundColor = MYCOLOR_BLUE;
    self.choose.alpha = 0.8;
    self.yes.frame = CGRectMake(0, 0, 20, 20);
    self.yes.center = self.choose.center;
}

- (void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        _imageName = imageName;
        self.backImage.image = [UIImage imageNamed:imageName];
    }
}
- (void)showChoose:(BOOL)isSelect{
    self.yes.hidden = !isSelect;
    self.choose.hidden = !isSelect;
}

- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [UIImageView new];
    }
    return _backImage;
}

- (UILabel *)choose{
    if (!_choose) {
        _choose = [UILabel new];
    }
    return _choose;
}

- (UIImageView *)yes{
    if (!_yes) {
        _yes = [UIImageView new];
        _yes.image = [UIImage imageNamed:@"yes"];
    }
    return _yes;
}

+ (NSString *)cellIdentifier{
    return @"ChatBackGroundCollectionViewCell";
}
@end
