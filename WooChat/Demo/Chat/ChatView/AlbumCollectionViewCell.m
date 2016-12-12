//
//  AlbumCollectionViewCell.m
//  WooChat
//
//  Created by apple on 16/12/12.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AlbumCollectionViewCell.h"

@implementation AlbumCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.albumImageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    if (self.imageObject.size.width > SCREEN_WIDTH && self.imageObject.size.height < SCREEN_HEIGHT) {
//        self.albumImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH * self.imageObject.size.height) / self.imageObject.size.width);
//    }else if (self.imageObject.size.height > SCREEN_HEIGHT && self.imageObject.size.width < SCREEN_WIDTH){
//        self.albumImageView.frame = CGRectMake(0, 0, (self.imageObject.size.width * SCREEN_HEIGHT) / self.imageObject.size.height, SCREEN_HEIGHT);
//    }
//    else if (self.imageObject.size.height > SCREEN_HEIGHT && self.imageObject.size.width > SCREEN_WIDTH){
//        if (self.imageObject.size.height > self.imageObject.size.width) {
//            self.albumImageView.frame = CGRectMake(0, 0, (self.imageObject.size.width * SCREEN_HEIGHT) / self.imageObject.size.height, SCREEN_HEIGHT);
//        }else{
//            self.albumImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH * self.imageObject.size.height) / self.imageObject.size.width);
//        }
//    }
//    else{
//        self.albumImageView.frame = CGRectMake(0, 0, self.imageObject.size.width, self.imageObject.size.height);
//    }
//    self.albumImageView.center = self.contentView.center;
}

- (UIImageView *)albumImageView{
    if (!_albumImageView) {
        _albumImageView = [UIImageView new];
        
    }
    return _albumImageView;
}

- (void)setImageObject:(NIMImageObject *)imageObject{
    if (_imageObject != imageObject) {
        _imageObject = imageObject;
        [self.albumImageView sd_setImageWithURL:[NSURL URLWithString:imageObject.url]];
    }
}
@end
