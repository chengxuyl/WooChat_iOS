//
//  MoreView.m
//  WooChat
//
//  Created by apple on 16/8/26.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "MoreView.h"

@implementation MoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _MoreViewBtnView = [[UIView alloc]initWithFrame:frame];
        _MoreViewBtnView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        //第一排
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(0, 2, SCREEN_WIDTH/4-0.5, SCREEN_HEIGHT/10) WithName:@"球播" WithImageName:@"qiubo"]];
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(SCREEN_WIDTH/4+0.5, 2, SCREEN_WIDTH/4-0.5, SCREEN_HEIGHT/10) WithName:@"短信" WithImageName:@"message"]];
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(SCREEN_WIDTH/2+1, 2, SCREEN_WIDTH/4-0.5, SCREEN_HEIGHT/10) WithName:@"公告" WithImageName:@"notice"]];
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(SCREEN_WIDTH/1.33+0.5, 2, SCREEN_WIDTH/4, SCREEN_HEIGHT/10) WithName:@"表情" WithImageName:@"sticks"]];
        
        //第二排
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(0, SCREEN_HEIGHT/10+3, SCREEN_WIDTH/4-0.5, SCREEN_HEIGHT/10) WithName:@"调研" WithImageName:@"marketresearch"]];
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(SCREEN_WIDTH/4+0.5, SCREEN_HEIGHT/10+3, SCREEN_WIDTH/4-0.5, SCREEN_HEIGHT/10) WithName:@"商城" WithImageName:@"shopping"]];
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(SCREEN_WIDTH/2+1, SCREEN_HEIGHT/10+3, SCREEN_WIDTH/4-0.5, SCREEN_HEIGHT/10) WithName:@"优惠券" WithImageName:@"coupon"]];
        [_MoreViewBtnView addSubview:[self createBtnViewWithFrame:CGRectMake(SCREEN_WIDTH/1.33+0.5, SCREEN_HEIGHT/10+3, SCREEN_WIDTH/4, SCREEN_HEIGHT/10) WithName:@"游戏" WithImageName:@"game"]];
    }
    return self;
}
//返回每个按钮的背景图
- (UIView *)createBtnViewWithFrame:(CGRect)frame WithName:(NSString *)name WithImageName:(NSString *)imageName{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    
    imageView.frame = CGRectMake(SCREEN_WIDTH/12.5, SCREEN_HEIGHT/100, SCREEN_WIDTH/11, SCREEN_HEIGHT/19);
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/16, frame.size.width, SCREEN_HEIGHT/30)];
    
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    return view;
}

@end
