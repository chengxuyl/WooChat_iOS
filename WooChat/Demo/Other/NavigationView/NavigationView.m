//
//  NavigationView.m
//  Moatong
//
//  Created by 殷玮 on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "NavigationView.h"
#import "UIButton+_UnSelected.h"
@implementation NavigationView
- (instancetype)init
{
    self = [super init];
    if (self) {
        //头像按钮
        _headImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(4, 4, 36, 36)];
//        [_headImageBtn setBackgroundColor:[UIColor redColor]];
        [_headImageBtn setBackgroundImage:[UIImage imageNamed:@"originalportrit"] forState:(UIControlStateNormal)];
        _headImageBtn.layer.cornerRadius = 34/2.0;
        _headImageBtn.layer.masksToBounds = YES;
        
        //右边加号按钮
        _RightBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
        [_RightBtn setBackgroundImage:[UIImage imageNamed:@"main_menu"] forState:UIControlStateNormal];
        
        //右边翻译按钮
        _transelateBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
        [_transelateBtn setBackgroundImage:[UIImage imageNamed:@"transelate"] forState:UIControlStateNormal];
        
        
        //右边设置按钮
        _setBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
        [_setBtn setBackgroundImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
        
        //右上角发送按钮-灰色
        _nvSendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/7, 35)];
        [_nvSendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_nvSendBtn setBackgroundImage:[UIImage imageNamed:@"send_buttun"] forState:UIControlStateNormal];
        _nvSendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _nvSendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        //返回按钮
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/15, 30)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        
        //相册详细页面右上角发送按钮
        _nvOriginaSendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, 35)];
        [_nvOriginaSendBtn setBackgroundImage:[UIImage imageNamed:@"send_count_buttun"] forState:UIControlStateNormal];
        _nvOriginaSendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _nvOriginaSendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nvOriginaSendBtn setTitleColor:MYCOLOR_BLUE forState:UIControlStateNormal];
    }
    return self;
}

+(UIButton *)headImageBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(4, 4, 36, 36)];
//    [btn setBackgroundImage:[UIImage imageNamed:@"friends_normal"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.layer.cornerRadius = 34/2.0;
    btn.layer.masksToBounds = YES;
    
    return btn;
}
+(UIButton *)RightBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
    [btn setBackgroundImage:[UIImage imageNamed:@"main_menu"] forState:UIControlStateNormal];
    return btn;
}
@end
