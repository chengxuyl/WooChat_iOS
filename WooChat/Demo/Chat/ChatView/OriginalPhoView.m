//
//  OriginalPhoView.m
//  WooChat
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "OriginalPhoView.h"

@implementation OriginalPhoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
        _toolView.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0];
        
        
        //原图选择图片
        _picImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"original_photo"]];
        [_toolView addSubview:_picImageView];
        [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(24);
            make.top.equalTo(_toolView).with.offset(10);
            make.bottom.equalTo(_toolView).with.offset(-10);
            make.left.equalTo(_toolView).with.offset(10);
        }];
        
        //原图大小label
        _picSize = [[UILabel alloc]init];
        _picSize.text = @"原图";
        _picSize.textColor = [UIColor whiteColor];
        [_toolView addSubview:_picSize];
        [_picSize mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_toolView).with.offset(10);
            make.bottom.equalTo(_toolView).with.offset(-10);
            make.left.equalTo(_picImageView.mas_right).with.offset(2);
        }];
        
        //原图按钮
        _picBtn = [[UIButton alloc]init];
        [_toolView addSubview:_picBtn];
        [_picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(SCREEN_WIDTH/7);
            make.top.equalTo(_toolView).with.offset(10);
            make.bottom.equalTo(_toolView).with.offset(-10);
            make.left.equalTo(_toolView).with.offset(10);
        }];
        
        UILabel *selectedLabel = [[UILabel alloc]init];
        selectedLabel.text = @"选择";
        selectedLabel.textColor = [UIColor whiteColor];
        [_toolView addSubview:selectedLabel];
        [selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_toolView).with.offset(10);
            make.bottom.equalTo(_toolView).with.offset(-10);
            make.right.equalTo(_toolView).with.offset(-10);
        }];
        
        //选择图片
        _selectedImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"select_photo_press"]];
        [_toolView addSubview:_selectedImageView];
        [_selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(24);
            make.top.equalTo(_toolView).with.offset(10);
            make.bottom.equalTo(_toolView).with.offset(-10);
            make.right.equalTo(selectedLabel.mas_left).with.offset(-2);
        }];
        
        
        //选择按钮
        _selectedBtn = [[UIButton alloc]init];
        [_toolView addSubview:_selectedBtn];
        [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_toolView).with.offset(10);
            make.bottom.equalTo(_toolView).with.offset(-10);
            make.left.equalTo(_selectedImageView.mas_left).with.offset(0);
            make.right.equalTo(selectedLabel.mas_right).with.offset(0);
        }];
        
    }
    return self;
}
@end
