//
//  AddressBookViewController.m
//  WooChat
//
//  Created by qiubo on 2016/11/23.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AddressBookViewController.h"
#import "ContactsModel.h"
#import "AddressBookModel.h"
#import "NSString+PinYin.h"
#import "ContactsTableViewCell.h"
#import "ContactsModel.h"
#import <MessageUI/MessageUI.h>
@interface AddressBookViewController ()<UITableViewDelegate, UITableViewDataSource, ContactsTableViewCellDelegate, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通讯录朋友";
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    [self createTableView];
    [self.view addSubview:self.tableView];
}

#pragma mark - 表格视图
//创建表格视图;
- (void)createTableView{
    self.dataSource = [NSMutableArray array];

    for (char i = 'A'; i <= 'Z'; i++)
    {
        
        NSString * str = [NSString stringWithFormat:@"%c",i];
        
        NSMutableArray * carMuArr = [[NSMutableArray alloc]init];
        
        for (AddressBookModel *mod in self.sysArr)
        {
            NSString * carName = mod.name;
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
        
        for (AddressBookModel *mod in self.sysArr)
        {
            NSString * carName = mod.name;
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

    [self.tableView reloadData];;
    
}

#pragma mark - tableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dic = _dataSource[section];
    NSArray * arr = dic[@"Arr"];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactsTableViewCell cellIdentifier]];
    NSDictionary * dic = _dataSource[indexPath.section];
    NSArray * arr = dic[@"Arr"];
    cell.delegate = self;
    AddressBookModel *mod = arr[indexPath.row];
    
    if ([mod.isFriend isEqualToString:@"1"]) {
        cell.celltype = 1;
    }else if ([mod.isFriend isEqualToString:@"2"]){
        cell.celltype = 2;
    }else if ([mod.isFriend isEqualToString:@""]){
        cell.celltype = 3;
    }
    cell.mod = mod;

    return cell;
}
//设置组名
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary * dic = _dataSource[section];
    return dic[@"Title"];
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

#pragma mark - ContactsTableViewCellDelegate
- (void)typeBtnClickedBtn:(UIButton *)btn tableViewCell:(ContactsTableViewCell *)tableViewCell{
    //    CellTypeIsAdd = 1,//已添加
//    CellTypeAdd = 2,//添加
//    CellTypeInvite = 3,//邀请
    switch (tableViewCell.celltype) {
        case CellTypeIsAdd:
            
            break;
        case CellTypeAdd:
            
            break;
        case CellTypeInvite:{
            //显示发短信的控制器
            
            MFMessageComposeViewController *vc =[[MFMessageComposeViewController alloc] init];
            if([MFMessageComposeViewController canSendText]){
                // 设置短信内容
                
                vc.body = @"WooChat非常好, 快来下载吧~balablabalabal";
                
                // 设置收件人列表
                
                vc.recipients = @[tableViewCell.mod.tel];
                
                // 设置代理
                
                vc.messageComposeDelegate = self;
                
                // 显示控制器
                [self presentViewController:vc animated:YES completion:nil];
            }
        }
            
            break;
        default:
            break;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller.view endEditing:YES];
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setters and getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[ContactsTableViewCell class] forCellReuseIdentifier:[ContactsTableViewCell cellIdentifier]];
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
