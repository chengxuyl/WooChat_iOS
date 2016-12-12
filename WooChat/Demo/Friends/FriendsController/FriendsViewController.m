//
//  FriendsViewController.m
//  Moatong
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "FriendsViewController.h"
#import "NavigationView.h"
#import "ToolsbarView.h"
#import "ChatViewController.h"
#import "AdvertisementViewController.h"
#import "FriendCircleViewController.h"
#import "MoreViewController.h"
#import "PopView.h"
#import "TableViewModel.h"
#import "NSString+PinYin.h"
#import "FriendsDetailedViewController.h"
#import "AddFriendsViewController.h"
#import "SearchConditionViewController.h"
#import "FriendsInfoModel.h"
#import "AddFriendsViewController.h"
@interface FriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property UITableView *tableView;
@property NSMutableArray *dataSource;
@property NavigationView *nv;
@property UITapGestureRecognizer *tap;
@property PopView *pop;
@property NSMutableArray *modArr;
@property FMDatabase *db;
@property NSMutableArray *tempArr;
@end

@implementation FriendsViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createNavigation];
    [self createPage];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)viewDidAppear:(BOOL)animated{
    //导航条复原动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];

    self.navigationController.navigationBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);

    [UIView commitAnimations];
}
- (void)viewDidDisappear:(BOOL)animated{
    if (_pop.popView) {
        [_pop.popView removeFromSuperview];
        _nv.RightBtn.selected = NO;
        [_tableView removeGestureRecognizer:_tap];
    }
}   
#pragma mark - 导航条
-(void)createNavigation{
    self.navigationItem.title = @"WooChat";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    _nv = [[NavigationView alloc]init];
    
    UIBarButtonItem *headImageBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_nv.headImageBtn];
    self.navigationItem.leftBarButtonItem = headImageBtnItem;
    [_nv.headImageBtn addTarget:self action:@selector(asd2) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_nv.RightBtn];
    self.navigationItem.rightBarButtonItem = RightBtnItem;
    [_nv.RightBtn addTarget:self action:@selector(rightPop:) forControlEvents:UIControlEventTouchUpInside];
    _nv.RightBtn.selected = NO;
    
    //右上角加号Pop菜单
    _pop = [[PopView alloc]init];
    
//    [pop.groupChatBtn addTarget:self action:@selector(groupChatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_pop.addFriendsBtn addTarget:self action:@selector(addFriendsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_pop.searchConditionBtn addTarget:self action:@selector(searchConditionBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [pop.RichScanBtn addTarget:self action:@selector(RichScanBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [pop.photographBtn addTarget:self action:@selector(photographBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
//Pop添加好友按钮点击事件
- (void)addFriendsBtnClick{
    AddFriendsViewController * AfVc = [[AddFriendsViewController alloc]init];
    [self.navigationController pushViewController:AfVc animated:YES];
}

//按条件查找
- (void)searchConditionBtnClick{
    SearchConditionViewController *searchVC = [SearchConditionViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - 页面
-(void)createPage{
    //页面跳转工具条
    ToolsbarView *toolsBarView = [[ToolsbarView alloc]initWithNum:1];
    [self.view addSubview:toolsBarView.toolsbar];
    [toolsBarView.chatBtn addTarget:self action:@selector(chatBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.adBtn addTarget:self action:@selector(adBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.FCBtn addTarget:self action:@selector(FCBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.moreBtn addTarget:self action:@selector(moreBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [self createTableView];
}
#pragma mark - 表格视图
//创建表格视图;
- (void)createTableView{
    _dataSource = [[NSMutableArray alloc]init];
//    TableViewModel *model = [[TableViewModel alloc]init];
//    NSArray *arr = [[NSArray alloc]initWithArray:model.contentsArray];
    _modArr = [NSMutableArray array];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.db = [FMDatabase databaseWithPath:[[UserInfo sharedInstance] dataBasePath]];
    
    self.tempArr = [NSMutableArray array];
    //判断是否有数据库
    if ([fileManager fileExistsAtPath:[[UserInfo sharedInstance] dataBasePath]] == NO) {
        
        if (![self.db open]) {
            
            NSLog(@"Could not open db.");
            return ;
        }
        //建立table
        [self.db executeUpdate:@"CREATE TABLE PersonList (nickName text, mobile text, imId text, icon text, chatBackGround text)"];
        //获取好友列表
        NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
        [mDic setObject:[UserInfo sharedInstance].mobile forKey:@"mobile"];
        [[ServerAPI sharedAPI] serverPostWithName:@"friends" WithDic:mDic completion:^(NSDictionary *resultDict) {
            self.tempArr = [resultDict objectForKey:@"friends"];
            for (NSDictionary *dic in self.tempArr) {
                FriendsInfoModel *mod = [FriendsInfoModel new];
                [mod setValuesForKeysWithDictionary:dic];
                //插入资料
                [self.db executeUpdate:@"INSERT INTO PersonList (nickName, mobile, imId, icon, chatBackGround) VALUES (?,?,?,?, ?)",
                 mod.nickName, mod.mobile, mod.imId, mod.icon, @""];
            }
            [self sortContacts];
            [self.tableView reloadData];
        }];

    }else{
        // 查询数据
        [self.db open];
        FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM PersonList"];
        
        // 遍历结果集
        
        while ([rs next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:[rs stringForColumn:@"nickName"] forKey:@"nickName"];
            [dic setObject:[rs stringForColumn:@"mobile"] forKey:@"mobile"];
            [dic setObject:[rs stringForColumn:@"imId"] forKey:@"imId"];
            [dic setObject:[rs stringForColumn:@"icon"] forKey:@"icon"];
            [self.tempArr addObject:dic];
        }
        [self sortContacts];
    }
    
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 128, SCREEN_WIDTH, SCREEN_HEIGHT-128) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.view addSubview:_tableView];
    
}

- (void)sortContacts{
    for (char i = 'A'; i <= 'Z'; i++)
    {
        
        NSString * str = [NSString stringWithFormat:@"%c",i];
        
        NSMutableArray * carMuArr = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in self.tempArr)
        {
            FriendsInfoModel *mod = [FriendsInfoModel new];
            [mod setValuesForKeysWithDictionary:dic];
            
            NSString * carName = mod.nickName;
            if ([[carName getFirstLetter] isEqualToString:str])
            {
                [carMuArr addObject:mod];
            }
        }
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:str forKey:@"Title"];
        [dic setObject:carMuArr forKey:@"Arr"];
        if (carMuArr.count != 0) {
            [_dataSource addObject:dic];
        }
    }
    NSString *str = [NSString stringWithFormat:@"%c",'#'];
    if ([str isEqualToString:@"#"]) {
        NSMutableArray * carMuArr = [[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in self.tempArr)
        {
            FriendsInfoModel *mod = [FriendsInfoModel new];
            [mod setValuesForKeysWithDictionary:dic];
            
            NSString * carName = mod.nickName;
            if ([[carName getFirstLetter] isEqualToString:str])
            {
                [carMuArr addObject:mod];
            }
        }
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:str forKey:@"Title"];
        [dic setObject:carMuArr forKey:@"Arr"];
        if (carMuArr.count != 0) {
            [_dataSource addObject:dic];
        }
    }
}
//表格视图手势 用于收回popView
- (void)addToucheEvent:(UITapGestureRecognizer *)tap
{
    [_pop.popView removeFromSuperview];
    _nv.RightBtn.selected = NO;
    [_tableView removeGestureRecognizer:_tap];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else{
        
        NSDictionary * dic = _dataSource[section-1];
        NSArray * arr = dic[@"Arr"];
        return arr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"新的朋友";
            cell.imageView.image = [UIImage imageNamed:@"addfriend"];
            cell.imageView.backgroundColor = [UIColor greenColor];
            cell.imageView.layer.cornerRadius = cell.imageView.height /2;
            cell.imageView.layer.masksToBounds = YES;
        }else{
            cell.imageView.image = [UIImage imageNamed:@"groupchat"];
            cell.textLabel.text = @"群聊";
            cell.imageView.backgroundColor = [UIColor yellowColor];
            cell.imageView.layer.cornerRadius = cell.imageView.height /2;
            cell.imageView.layer.masksToBounds = YES;
        }
    }else{
        
        NSDictionary * dic = _dataSource[indexPath.section-1];
        NSArray * arr = dic[@"Arr"];
        FriendsInfoModel *mod = arr[indexPath.row];
        cell.textLabel.text = mod.nickName;
    }
//    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

//设置组名
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"✨";
    }else{
        NSDictionary * dic = _dataSource[section-1];
        return dic[@"Title"];
    }
}

//设置索引名
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    tableView.sectionIndexColor = [UIColor blackColor];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in _dataSource)
    {
        [arr addObject:dic[@"Title"]];
    }
    return arr;
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%@",[[_dataSource[indexPath.section] valueForKey:@"Arr"] objectAtIndex:indexPath.row]);
//    NSLog(@"%ld %ld",indexPath.row,indexPath.section);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AddFriendsViewController *vc = [AddFriendsViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
        }
    }else{
        FriendsDetailedViewController *FriendsDetailedViewC = [[FriendsDetailedViewController alloc]init];
        FriendsDetailedViewC.mod = [[_dataSource[indexPath.section-1] valueForKey:@"Arr"] objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:FriendsDetailedViewC animated:YES];
    }
}
#pragma mark - 点击事件
//导航条右边添加按钮点击事件
-(void)rightPop:(UIButton *)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
        [_pop.popView removeFromSuperview];
        [_tableView removeGestureRecognizer:_tap];
    }else{
        btn.selected = YES;
        [self.view addSubview:_pop.popView];
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addToucheEvent:)];
        [_tableView addGestureRecognizer:_tap];
    }
}
-(void)asd2{
    NSLog(@"这是左边头像按钮");
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
//更多页面跳转
- (void)moreBtnPop{
    MoreViewController *MoreViewC = [[MoreViewController alloc]init];
    UINavigationController *MoreViewc = [[UINavigationController alloc]initWithRootViewController:MoreViewC];
    [ self presentViewController:MoreViewc animated: NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
