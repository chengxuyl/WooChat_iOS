//
//  PhoView.m
//  WooChat
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "PhoView.h"

@implementation PhoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
        _toolView.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0];
        _toolView.alpha = 0.8;
        
        _phoName = [[UILabel alloc]init];
        _phoName.text = @"相机胶卷";
        _phoName.textColor = [UIColor whiteColor];
        [_toolView addSubview:_phoName];
        
        [_phoName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_toolView).with.offset(5);
            make.bottom.equalTo(_toolView).with.offset(-5);
            make.left.equalTo(_toolView).with.offset(10);
        }];
        
        UIImageView *pulldownIv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"all_photo"]];
        [_toolView addSubview:pulldownIv];
        [pulldownIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(25);
            make.top.equalTo(_toolView).with.offset(10);
            make.bottom.equalTo(_toolView).with.offset(-10);
            make.left.equalTo(_phoName.mas_right).with.offset(0);
        }];
        
        _preBtn = [[UIButton alloc]init];
        [_preBtn setTitle:@"预览" forState:UIControlStateNormal];
        _preBtn.titleLabel.textAlignment = UITextAlignmentCenter;
        [_preBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_toolView addSubview:_preBtn];
        
        [_toolView addSubview:pulldownIv];
        [_preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(60);
            make.top.equalTo(_toolView).with.offset(5);
            make.bottom.equalTo(_toolView).with.offset(-5);
            make.right.equalTo(_toolView).with.offset(-10);
        }];
        
        
    }
    return self;
}

@end