//
//  AboutMeViewController.m
//  WooChat
//
//  Created by yuling on 16/11/11.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AboutMeViewController.h"
#import "AboutMeTableViewCell.h"
#import "AboutMeHeadTableViewCell.h"
#import "EditMeViewController.h"
#import "ServerAPI.h"
#import "UserInfoModel.h"
@interface AboutMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserInfoModel *model;
@end

@implementation AboutMeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取会员信息
    
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    [mDic setObject:[UserInfo sharedInstance].mobile forKey:@"mobile"];
    [[ServerAPI sharedAPI] serverPostWithName:@"memberInfo" WithDic:mDic completion:^(NSDictionary *resultDict) {
        NSLog(@"%@---memberInfo", resultDict);
        self.model = [UserInfoModel new];
        [self.model setValuesForKeysWithDictionary:resultDict];
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    self.title = @"我";
    
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - tableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AboutMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AboutMeTableViewCell cellIdentifier]];
//        cell.descripLabel.text = self.model.signature;
        cell.nameLabel.text = self.model.nickName;
        
        return cell;
    }else{
        AboutMeHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AboutMeHeadTableViewCell cellIdentifier]];
        if (indexPath.row == 0) {
            cell.iconImageView.image = [UIImage imageNamed:@"icon_wo_pic"];
            cell.nameLabel.text = @"相册";
        }else if (indexPath.row == 1){
            cell.iconImageView.image = [UIImage imageNamed:@"icon_wo_col"];
            cell.nameLabel.text = @"收藏";
        }else{
            cell.iconImageView.image = [UIImage imageNamed:@"purse"];
            cell.nameLabel.text = @"钱包";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        EditMeViewController *editVC = [EditMeViewController new];
        editVC.model = self.model;
        [self.navigationController pushViewController:editVC animated:YES];
    }
}

#pragma mark - setters and getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MYCOLOR_BackGroudColor;
        [_tableView registerClass:[AboutMeTableViewCell class] forCellReuseIdentifier:[AboutMeTableViewCell cellIdentifier]];
        [_tableView registerClass:[AboutMeHeadTableViewCell class] forCellReuseIdentifier:[AboutMeHeadTableViewCell cellIdentifier]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
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
