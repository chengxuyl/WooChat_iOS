//
//  AdvertisementViewController.m
//  Moatong
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AdvertisementViewController.h"
#import "ChatViewController.h"
#import "NavigationView.h"
#import "ToolsbarView.h"
#import "FriendsViewController.h"
#import "FriendCircleViewController.h"
#import "MoreViewController.h"
#import "AdvertisementView.h"
#import "AdVertiseTableViewCell.h"
#import "AdListViewController.h"
#import "AboutMeViewController.h"
#import "AdvertisementModel.h"
#import "AdvertisementHTMLViewController.h"
#import <Reachability.h>

@interface AdvertisementViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation AdvertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigation];
    [self createPage];
    self.dataArr = [NSMutableArray array];
    
    

    
//    Reachability *reach = [[Reachability alloc] init];
//    [reach startNotifier];
//    NSLog(@"%ld----", [reach currentReachabilityStatus]);
    //超级广告
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserInfo sharedInstance].uid forKey:@"uid"];
    [[ServerAPI sharedAPI] serverPostWithName:@"superAd" WithDic:dic completion:^(NSDictionary *resultDict) {
        NSArray *arr = [resultDict objectForKey:@"ad"];
        for (NSDictionary *dic in arr) {
            AdvertisementModel *model = [AdvertisementModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - 导航条
-(void)createNavigation{
    self.navigationItem.title = @"MoaTong";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    NavigationView *nv = [[NavigationView alloc]init];
    UIBarButtonItem *headImageBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.headImageBtn];
    self.navigationItem.leftBarButtonItem = headImageBtnItem;
    [nv.headImageBtn addTarget:self
                        action:@selector(asd2) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 页面
-(void)createPage{
    //页面跳转工具条
    ToolsbarView *toolsBarView = [[ToolsbarView alloc]initWithNum:3];
    [self.view addSubview:toolsBarView.toolsbar];
    
    [toolsBarView.FriendsBtn addTarget:self action:@selector(FriendsBtnPop)
                      forControlEvents:UIControlEventTouchUpInside];
    
    [toolsBarView.chatBtn addTarget:self action:@selector(chatBtnPop)
                   forControlEvents:UIControlEventTouchUpInside];
    
    [toolsBarView.FCBtn addTarget:self action:@selector(FCBtnPop)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [toolsBarView.moreBtn addTarget:self action:@selector(moreBtnPop)
                   forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //4*3广告按钮
    AdvertisementView *sAdvertisementV= [[AdvertisementView alloc]init];
    [self.view addSubview:sAdvertisementV.AdvertisementView];
    
    //广告条
    [self.view addSubview:self.tableView];
    
    //下方按钮条
    [self.view addSubview:sAdvertisementV.downBtnView];
    
    //点击广告的每一个分类
    for (UIView *view in sAdvertisementV.AdvertisementBtnView.subviews) {
        NSLog(@"%ld====", view.tag);
    }
}
#pragma mark - 点击事件
-(void)asd2{
    AboutMeViewController *aboutMeVC = [AboutMeViewController new];
    [self.navigationController pushViewController:aboutMeVC animated:YES];
}
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
//朋友圈页面跳转
- (void)FCBtnPop{
    FriendCircleViewController *FriendCircleViewC = [[FriendCircleViewController alloc]init];
    UINavigationController *FriendCircleViewnc = [[UINavigationController alloc]initWithRootViewController:FriendCircleViewC];
    [ self presentViewController:FriendCircleViewnc animated: NO completion:nil];
}
//更多页面跳转
- (void)moreBtnPop{
        MoreViewController *MoreViewC = [[MoreViewController alloc]init];
        UINavigationController *MoreViewc = [[UINavigationController alloc]initWithRootViewController:MoreViewC];
        [ self presentViewController:MoreViewc animated: NO completion:nil];
}

#pragma mark - tableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_HEIGHT/3.2+6)/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AdVertiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AdVertiseTableViewCell cellIdenttifier]];
    cell.model = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AdvertisementHTMLViewController *adHTMLVC = [AdvertisementHTMLViewController new];
    AdvertisementModel *model = [self.dataArr objectAtIndex:indexPath.row];
    adHTMLVC.adid = model.adid;
    [self.navigationController pushViewController:adHTMLVC animated:YES];
}
#pragma mark - getters and setters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 128 +SCREEN_HEIGHT/3.2+6, SCREEN_WIDTH, SCREEN_HEIGHT - 128 -SCREEN_HEIGHT/3.2-6-SCREEN_HEIGHT/10-2) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[AdVertiseTableViewCell class] forCellReuseIdentifier:[AdVertiseTableViewCell cellIdenttifier]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
