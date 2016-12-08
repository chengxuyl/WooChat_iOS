//
//  ChatInfoViewController.m
//  WooChat
//
//  Created by qiubo on 2016/11/30.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ChatInfoViewController.h"
#import "ChatBackGroundViewController.h"
@interface ChatInfoViewController ()<UITableViewDelegate, UITableViewDataSource, NIMChatManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ChatInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"聊天信息";
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    switch (indexPath.row) {
        case 0:{
            
            cell.textLabel.text = @"新消息提醒";
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 0, 20, 10)];
            switchButton.centerY = cell.contentView.centerY;
            switchButton.onTintColor = MYCOLOR_BLUE;
            [switchButton setOn:YES];
            //            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:switchButton];
        }
            break;
        case 1:
            cell.textLabel.text = @"设置聊天背景";
            break;
        case 2:
            cell.textLabel.text = @"查找聊天记录";
            break;
        case 3:
            cell.textLabel.text = @"清空聊天记录";
            break;
        case 4:
            cell.textLabel.text = @"投诉";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:{
            ChatBackGroundViewController *vc = [ChatBackGroundViewController new];
            vc.session = self.session;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            NIMMessageSearchOption *option = [[NIMMessageSearchOption alloc] init];
            option.searchContent = @"1";
//            NSArray *uids = [self searchUsersByKeyword:self.keyWord users:self.members];
//            option.fromIds       = uids;
            option.limit         = 20;
            [[[NIMSDK sharedSDK] conversationManager] searchMessages:self.session option:option result:^(NSError * _Nullable error, NSArray<NIMMessage *> * _Nullable messages) {
                NSLog(@"%ld===messages", messages.count);
            }];
        }
            break;
        case 3:{
            UIAlertController *alert = [[UIAlertController alloc] init];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"清空聊天记录" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                [[[NIMSDK sharedSDK] conversationManager] deleteAllmessagesInSession:self.session removeRecentSession:NO];
                [alert dismissViewControllerAnimated:yes completion:nil];
            }];
            [alert addAction:yes];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:yes completion:nil];
            
        }
            break;
        case 4:
            
            break;
        default:
            break;
    }
}

#pragma mark - setters and getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MYCOLOR_BackGroudColor;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
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
