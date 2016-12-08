//
//  FriendsDetailedViewController.m
//  WooChat
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "FriendsDetailedViewController.h"
#import "FriendsDetailedView.h"
#import "DialogueViewController.h"
#import "FriendsInfoModel.h"
@interface FriendsDetailedViewController ()

@end

@implementation FriendsDetailedViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createPage];
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];
    self.navigationController.navigationBar.frame = CGRectMake(0, -44, SCREEN_WIDTH, 44);
    
    [UIView commitAnimations];
}

- (void)viewDidDisappear:(BOOL)animated{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];
    
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    
    [UIView commitAnimations];
}
#pragma mark - 创建页面
- (void)createPage{
    FriendsDetailedView *FriendsDetailedV = [[FriendsDetailedView alloc]initWithName:self.mod.nickName With:@"超级无敌美少女." With:self.mod.mobile With:@"啊啊 啊啊啊"];
    [self.view addSubview:FriendsDetailedV.backgroundView];
    
    UIButton *chatBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/11, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6)];
    [chatBtn setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    chatBtn.tag = 1;
    [self.view addSubview:chatBtn];
    
    UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.4, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6)];
    [phoneBtn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn.tag = 2;
    [self.view addSubview:phoneBtn];
    
    UIButton *circleBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.345, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6)];
    [circleBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    [circleBtn addTarget:self action:@selector(circleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    circleBtn.tag = 3;
    [self.view addSubview:circleBtn];
    
    //二级按钮
    UIButton *phoneBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(chatBtn.center.x, chatBtn.center.y, 0, 0)];
    [phoneBtn1 setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
//    [phoneBtn1 addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn1.tag = 4;
    [self.view addSubview:phoneBtn1];
    
    UIButton *phoneBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(phoneBtn.center.x, phoneBtn.center.y, 0, 0)];
    [phoneBtn2 setImage:[UIImage imageNamed:@"phone_vedio"] forState:UIControlStateNormal];
//    [phoneBtn2 addTarget:self action:@selector(phoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn2.tag = 5;
    [self.view addSubview:phoneBtn2];
    
    UIButton *phoneBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(circleBtn.center.x, circleBtn.center.y, 0, 0)];
    [phoneBtn3 setImage:[UIImage imageNamed:@"phone_off"] forState:UIControlStateNormal];
    [phoneBtn3 addTarget:self action:@selector(phoneBtn3) forControlEvents:UIControlEventTouchUpInside];
    phoneBtn3.tag = 6;
    [self.view addSubview:phoneBtn3];
    
}
#pragma mark - 点击事件
- (void)chatBtnClick{
    DialogueViewController *bv = [[DialogueViewController alloc]init];
    bv.mod = self.mod;
    NIMSession *session = [NIMSession session:self.mod.imId type:NIMSessionTypeP2P];
    bv.session = session;
    bv.friendIn = YES;
    [self.navigationController pushViewController:bv animated:YES];
}
- (void)phoneBtnClick{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];
    
    UIButton *btn1 = [self.view viewWithTag:1];
    btn1.frame = CGRectMake(btn1.center.x, btn1.center.y, 0, 0);
    UIButton *btn2 = [self.view viewWithTag:2];
    btn2.frame = CGRectMake(btn2.center.x, btn2.center.y, 0, 0);
    UIButton *btn3 = [self.view viewWithTag:3];
    btn3.frame = CGRectMake(btn3.center.x, btn3.center.y, 0, 0);
    
    UIButton *btn4 = [self.view viewWithTag:4];
    btn4.frame = CGRectMake(SCREEN_WIDTH/11, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6);
    UIButton *btn5 = [self.view viewWithTag:5];
    btn5.frame = CGRectMake(SCREEN_WIDTH/2.4, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6);
    UIButton *btn6 = [self.view viewWithTag:6];
    btn6.frame = CGRectMake(SCREEN_WIDTH/1.345, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6);
    
    [UIView commitAnimations];
}
- (void)circleBtnClick{
    
}
- (void)phoneBtn3{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];
    
    UIButton *btn1 = [self.view viewWithTag:4];
    btn1.frame = CGRectMake(btn1.center.x, btn1.center.y, 0, 0);
    UIButton *btn2 = [self.view viewWithTag:5];
    btn2.frame = CGRectMake(btn2.center.x, btn2.center.y, 0, 0);
    UIButton *btn3 = [self.view viewWithTag:6];
    btn3.frame = CGRectMake(btn3.center.x, btn3.center.y, 0, 0);
    
    UIButton *btn4 = [self.view viewWithTag:1];
    btn4.frame = CGRectMake(SCREEN_WIDTH/11, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6);
    UIButton *btn5 = [self.view viewWithTag:2];
    btn5.frame = CGRectMake(SCREEN_WIDTH/2.4, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6);
    UIButton *btn6 = [self.view viewWithTag:3];
    btn6.frame = CGRectMake(SCREEN_WIDTH/1.345, SCREEN_HEIGHT/1.17, SCREEN_WIDTH/6, SCREEN_WIDTH/6);
    
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
