//
//  FriendCircleViewController.m
//  Moatong
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "FriendCircleViewController.h"
#import "AdvertisementViewController.h"
#import "ChatViewController.h"
#import "NavigationView.h"
#import "ToolsbarView.h"
#import "FriendsViewController.h"
#import "MoreViewController.h"
@interface FriendCircleViewController ()

@end

@implementation FriendCircleViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigation];
    [self createPage];
}
#pragma mark - 导航条
-(void)createNavigation{
    self.navigationItem.title = @"MoaTong";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    NavigationView *nv = [[NavigationView alloc]init];
    UIBarButtonItem *headImageBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.headImageBtn];
    self.navigationItem.leftBarButtonItem = headImageBtnItem;
    [nv.headImageBtn addTarget:self action:@selector(asd2) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 页面
-(void)createPage{
    //页面跳转工具条
    ToolsbarView *toolsBarView = [[ToolsbarView alloc]initWithNum:4];
    [self.view addSubview:toolsBarView.toolsbar];
    [toolsBarView.FriendsBtn addTarget:self action:@selector(FriendsBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.chatBtn addTarget:self action:@selector(chatBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.adBtn addTarget:self action:@selector(adBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.moreBtn addTarget:self action:@selector(moreBtnPop) forControlEvents:UIControlEventTouchUpInside];
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
//更多页面跳转
- (void)moreBtnPop{
    MoreViewController *MoreViewC = [[MoreViewController alloc]init];
    UINavigationController *MoreViewc = [[UINavigationController alloc]initWithRootViewController:MoreViewC];
    [ self presentViewController:MoreViewc animated: NO completion:nil];
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
