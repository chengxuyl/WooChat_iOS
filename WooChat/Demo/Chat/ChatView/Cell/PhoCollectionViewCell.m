//
//  PhoCollectionViewCell.m
//  WooChat
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "PhoCollectionViewCell.h"

@implementation PhoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _select = NO;
//    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"image_cicle"] forState:UIControlStateNormal];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"image_cicle_select"] forState:UIControlStateSelected];
//    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(_imageView.bounds.size.width/4, _imageView.bounds.size.width/4));
//        make.top.equalTo(self.contentView).with.offset(0);
//        make.right.equalTo(self.contentView).with.offset(0);
//    }];
}

@end
