//
//  SetViewController.m
//  WooChat
//
//  Created by yuling on 16/11/15.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "SetViewController.h"
#import "AboutMeHeadTableViewCell.h"
#import "AddAuthViewController.h"
#import "NIMSDK.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    self.title = @"设置";
    
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1){
        return 6;
    }else if (section == 2){
        return 5;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AboutMeHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AboutMeHeadTableViewCell cellIdentifier]];
    if (indexPath.section == 0) {
        cell.iconImageView.image = [UIImage imageNamed:@"icon_set_about"];
        cell.nameLabel.text = @"关于WOOCHAT";
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.iconImageView.image = [UIImage imageNamed:@"version"];
                cell.nameLabel.text = @"当前版本";
                break;
            case 1:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_code"];
                cell.nameLabel.text = @"修改密码";
                break;
            case 2:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_view"];
                cell.nameLabel.text = @"短信验证";
                break;
            case 3:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_notice"];
                cell.nameLabel.text = @"新消息提醒";
                break;
            case 4:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_update"];
                cell.nameLabel.text = @"检查更新";
                break;
            case 5:
                cell.nameLabel.text = @"添加广告商";
                break;
            default:
                break;
        }
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_share"];
                cell.nameLabel.text = @"分享朋友";
                break;
            case 1:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_blacklist"];
                cell.nameLabel.text = @"黑名单";
                break;
            case 2:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_rt"];
                cell.nameLabel.text = @"意见反馈";
                break;
            case 3:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_rulls"];
                cell.nameLabel.text = @"使用条款";
                break;
            case 4:
                cell.iconImageView.image = [UIImage imageNamed:@"icon_set_secret"];
                cell.nameLabel.text = @"隐私设置";
                break;
            default:
                break;
        }
    }else{
        cell.iconImageView.image = [UIImage imageNamed:@"icon_set_exit"];
        cell.nameLabel.text = @"退出登录";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 5){
            AddAuthViewController *addVC = [AddAuthViewController new];
            [self.navigationController pushViewController:addVC animated:YES];
        }
    }else if(indexPath.section == 2){
    
    }else if(indexPath.section == 3){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定退出" preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleCancel) handler:nil];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [[UserInfo sharedInstance] clear];
                [[[NIMSDK sharedSDK] loginManager] logout:^(NSError * _Nullable error) {}];
                AppDelegate *delete =  (AppDelegate *)[UIApplication sharedApplication].delegate;
                
                UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
                
                delete.window.rootViewController = naviVC;
            }];
            
            [alert addAction:noAction];
            [alert addAction:sureAction];
            
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        }
}
#pragma mark - setters and getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MYCOLOR_BackGroudColor;
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
