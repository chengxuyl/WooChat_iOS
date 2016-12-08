//
//  ToolsbarView.m
//  WooChat
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ToolsbarView.h"
#define SIZE 12
@implementation ToolsbarView
- (instancetype)initWithNum:(int)num
{
    self = [super init];
    if (self) {
        
        _toolsbar = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 64)];
        _toolsbar.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        
        //图标1
        //好友页面工具条
        UIImageView *iv1 = [[UIImageView alloc]init];
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"好友";
        label1.textAlignment = NSTextAlignmentCenter;
        UIView *textV1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5, 64)];
        [_toolsbar addSubview:textV1];
        if (num == 1) {
            [iv1 setImage:[UIImage imageNamed:@"friends_select"]];
            label1.textColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1];
        }else{
            [iv1 setImage:[UIImage imageNamed:@"friends_normal"]];
            label1.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
        }
        label1.font = [UIFont systemFontOfSize:SIZE];
        _FriendsBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/26, 5, 50, 50)];
        [_toolsbar addSubview:label1];
        [_toolsbar addSubview:iv1];
        [_toolsbar addSubview:_FriendsBtn];

        [iv1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textV1.mas_centerY).with.offset(-10);
            make.centerX.mas_equalTo(textV1.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(textV1.mas_centerX);
            make.bottom.equalTo(_toolsbar).with.offset(-10);
        }];
        
        //图标2
        //聊天页面工具条
        UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3.95, 7, 36, 36)];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.15, 43, 45, 16)];
        label2.text = @"聊天";
        label2.textAlignment = NSTextAlignmentCenter;
        UIView *textV2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, 0, SCREEN_WIDTH/5, 64)];
        [_toolsbar addSubview:textV2];
        if (num == 2) {
            [iv2 setImage:[UIImage imageNamed:@"tab_chat_select"]];
            label2.textColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1];
        }else{
            [iv2 setImage:[UIImage imageNamed:@"chat_normal"]];
            label2.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
        }
        label2.font = [UIFont systemFontOfSize:SIZE];
        _chatBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.15, 5, 50, 50)];
        [_toolsbar addSubview:label2];
        [_toolsbar addSubview:iv2];
        [_toolsbar addSubview:_chatBtn];
        
        [iv2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textV2.mas_centerY).with.offset(-10);
            make.centerX.mas_equalTo(textV2.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(textV2.mas_centerX);
            make.bottom.equalTo(_toolsbar).with.offset(-10);
        }];
        
        //图标3
        //广告页面工具条
        UIImageView *iv3 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.2, 7, 36, 36)];
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.25, 43, 45, 16)];
        label3.text = @"广告";
        label3.textAlignment = NSTextAlignmentCenter;
        UIView *textV3 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*2, 0, SCREEN_WIDTH/5, 64)];
        [_toolsbar addSubview:textV3];
        if (num == 3) {
            [iv3 setImage:[UIImage imageNamed:@"ad_select"]];
            label3.textColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1];
        }else{
            [iv3 setImage:[UIImage imageNamed:@"ad_normal"]];
            label3.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
        }
        label3.font = [UIFont systemFontOfSize:SIZE];
        _adBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.25, 5, 50, 50)];
        [_toolsbar addSubview:label3];
        [_toolsbar addSubview:iv3];
        [_toolsbar addSubview:_adBtn];
        
        [iv3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textV3.mas_centerY).with.offset(-10);
            make.centerX.mas_equalTo(textV3.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(textV3.mas_centerX);
            make.bottom.equalTo(_toolsbar).with.offset(-10);
        }];
        
        //图标4
        //朋友圈页面工具条
        UIImageView *iv4 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.485, 7, 36, 36)];
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.535, 43, 55, 16)];
        label4.text = @"朋友圈";
        label4.textAlignment = NSTextAlignmentCenter;
        UIView *textV4 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*3, 0, SCREEN_WIDTH/5, 64)];
        [_toolsbar addSubview:textV4];
        if (num == 4) {
            [iv4 setImage:[UIImage imageNamed:@"tab_circle_select"]];
            label4.textColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1];
        }else{
            [iv4 setImage:[UIImage imageNamed:@"circle_normal"]];
            label4.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
        }
        label4.font = [UIFont systemFontOfSize:SIZE];
        _FCBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.535, 5, 50, 50)];
        [_toolsbar addSubview:label4];
        [_toolsbar addSubview:iv4];
        [_toolsbar addSubview:_FCBtn];
        [iv4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textV4.mas_centerY).with.offset(-10);
            make.centerX.mas_equalTo(textV4.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(textV4.mas_centerX);
            make.bottom.equalTo(_toolsbar).with.offset(-10);
        }];
        
        //图标5
        //更多页面工具条
        UIImageView *iv5 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.145, 7, 36, 36)];
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.16, 43, 45, 16)];
        label5.text = @"更多";
        label5.textAlignment = NSTextAlignmentCenter;
        UIView *textV5 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5*4, 0, SCREEN_WIDTH/5, 64)];
        [_toolsbar addSubview:textV5];
        if (num == 5) {
            [iv5 setImage:[UIImage imageNamed:@"more_select"]];
            label5.textColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1];
        }else{
            [iv5 setImage:[UIImage imageNamed:@"more_normal"]];
            label5.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1];
        }
        label5.font = [UIFont systemFontOfSize:SIZE];
        _moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.16, 5, 50, 50)];
        [_toolsbar addSubview:label5];
        [_toolsbar addSubview:iv5];
        [_toolsbar addSubview:_moreBtn];
        [iv5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textV5.mas_centerY).with.offset(-10);
            make.centerX.mas_equalTo(textV5.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(textV5.mas_centerX);
            make.bottom.equalTo(_toolsbar).with.offset(-10);
        }];
    }
    return self;
}
@end
