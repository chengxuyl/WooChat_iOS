//
//  MoreViewController.m
//  Moatong
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "MoreViewController.h"
#import "AdvertisementViewController.h"
#import "ChatViewController.h"
#import "NavigationView.h"
#import "ToolsbarView.h"
#import "FriendsViewController.h"
#import "FriendCircleViewController.h"
#import "MoreView.h"
#import "SetViewController.h"
#import "AboutMeViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigation];
    [self createPage];
}
#pragma mark - 导航条设置
-(void)createNavigation{
    self.navigationItem.title = @"MoaTong";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    NavigationView *nv = [[NavigationView alloc]init];
    UIBarButtonItem *headImageBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.headImageBtn];
    self.navigationItem.leftBarButtonItem = headImageBtnItem;
    [nv.headImageBtn addTarget:self action:@selector(asd2) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.setBtn];
    self.navigationItem.rightBarButtonItem = RightBtnItem;
    [nv.setBtn addTarget:self action:@selector(rightPop:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightPop:(UIButton *)button{
    SetViewController *setVC = [SetViewController new];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)asd2{
    AboutMeViewController *vc = [AboutMeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建页面
-(void)createPage{
    //页面跳转工具条
    ToolsbarView *toolsBarView = [[ToolsbarView alloc]initWithNum:5];
    [self.view addSubview:toolsBarView.toolsbar];
    [toolsBarView.FriendsBtn addTarget:self action:@selector(FriendsBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.chatBtn addTarget:self action:@selector(chatBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.adBtn addTarget:self action:@selector(adBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.FCBtn addTarget:self action:@selector(FCBtnPop) forControlEvents:UIControlEventTouchUpInside];
    
    //4*2更多按钮
    MoreView *moreView = [[MoreView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, SCREEN_HEIGHT/4.75)];
    [self.view addSubview:moreView.MoreViewBtnView];
}
#pragma mark - 点击事件
//好友页面跳转
- (void)FriendsBtnPop{
    FriendsViewController *FriendsViewC = [[FriendsViewController alloc]init];
    UINavigationController *FriendsViewnc = [[UINavigationController alloc]initWithRootViewController:FriendsViewC];
    [ self presentViewController:FriendsViewnc animated: NO completion:nil];
}
//聊天页面跳转
- (void)chatBtnPop{
    ChatViewController *ChatViewC = [[ChatViewController alloc]init];
    UINavigationController *ChatViewnc = [[UINavigationController alloc]initWithRootViewController:ChatViewC];
    [ self presentViewController:ChatViewnc animated: NO completion:nil];
}
//广告页面跳转
- (void)adBtnPop{
    AdvertisementViewController *AdvertisementViewC = [[AdvertisementViewController alloc]init];
    UINavigationController *AdvertisementViewnc = [[UINavigationController alloc]initWithRootViewController:AdvertisementViewC];
    [ self presentViewController:AdvertisementViewnc animated: NO completion:nil];
}
//朋友圈页面跳转
- (void)FCBtnPop{
    FriendCircleViewController *FriendCircleViewC = [[FriendCircleViewController alloc]init];
    UINavigationController *FriendCircleViewnc = [[UINavigationController alloc]initWithRootViewController:FriendCircleViewC];
    [ self presentViewController:FriendCircleViewnc animated: NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
