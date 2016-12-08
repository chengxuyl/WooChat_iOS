//
//  AddFriendsViewController.m
//  WooChat
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "NavigationView.h"
#import "ServerAPI.h"
#import "NIMSDK.h"
#import "FriendsDetailedViewController.h"
#import "FriendsInfoModel.h"
#import <ContactsUI/ContactsUI.h>
#import "AddressBookModel.h"
#import "AddressBookViewController.h"
#import "ContactsModel.h"
@interface AddFriendsViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, CNContactPickerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *searchMobile;
@end
@implementation AddFriendsViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self createNavigation];
}
-(void)viewDidAppear:(BOOL)animated{
    //导航条复原动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];
    
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    
    [UIView commitAnimations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:self.tableView];
}
#pragma mark - 导航条
-(void)createNavigation{
    self.navigationItem.title = @"添加朋友";
    [self.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil
                                                                                   action:nil];
    negativeSpacer.width = SCREEN_WIDTH/30 * -1;
    
    NavigationView *nv = [[NavigationView alloc]init];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.backBtn];
    [nv.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,
                                               backBtnItem];
    //scrollView自增64关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - searchBarDelegate
- (void)searchBtn:(UIButton *)btn{
    [self.view endEditing:YES];
    //查找好友
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.searchMobile forKey:@"mobile"];
   
    [[ServerAPI sharedAPI] serverPostWithName:@"memberInfo" WithDic:dic completion:^(NSDictionary *resultDict) {
        NSLog(@"%@--memberInfo", resultDict);
        FriendsInfoModel *mod = [FriendsInfoModel new];
        [mod setValuesForKeysWithDictionary:resultDict];
        if (![mod.mobile isEqualToString:@""]) {
            FriendsDetailedViewController * vc = [FriendsDetailedViewController new];
            vc.mod = mod;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [ViewFactory alertViewShowWithTitle:@"提示" message:@"该用户不存在"];
        }
    }];
    
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[UserInfo sharedInstance].mobile forKey:@"smobile"];
//    [dict setObject:self.searchMobile forKey:@"tmobile"];
//    [dict setObject:@"1" forKey:@"type"];
//    [dict setObject:@"0" forKey:@"star"];
//    [[ServerAPI sharedAPI] serverPostWithName:@"friendsUpdate" WithDic:dict completion:^(NSDictionary *resultDict) {
//        NSLog(@"%@===friendsUpdate", resultDict);
//    }];
    
}


#pragma mark - 点击事件
//导航返回按钮点击事件
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewDelegate and datasource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    bgView.backgroundColor = MYCOLOR_BackGroudColor;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 70)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"搜索" forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageNamed:@"addfriend_searchbutton_normal"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(searchBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.frame = CGRectMake(SCREEN_WIDTH - 80, 15, 70, 40);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"addfriend_testarea"]];
    imageView.frame = CGRectMake(10, 15, SCREEN_WIDTH - 100, 40);
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 80, 40)];
    textField.placeholder = @"至少输入四位";
    textField.textAlignment = NSTextAlignmentCenter;
    textField.delegate = self;
    imageView.userInteractionEnabled = YES;
    [imageView addSubview:textField];
    [view addSubview:imageView];
    [view addSubview:btn];
    view.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:view];
    return bgView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.imageView.image = [UIImage imageNamed:@"addfriend_telphonelist"];
    cell.textLabel.text = @"添加手机联系人";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //系统联系人信息数组
    NSMutableArray *addressBookArr = [NSMutableArray array];
    //电话号码数组
    NSMutableArray *arr = [NSMutableArray array];
    CNContactStore *addressBooks = [[CNContactStore alloc] init];
    
    CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:@[ CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey]];
    [addressBooks enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        AddressBookModel *model = [AddressBookModel new];
        model.name = [contact.familyName stringByAppendingString:contact.givenName];
        model.tel = [contact.phoneNumbers lastObject].value.stringValue;
        model.isFriend = @"";
        [addressBookArr addObject:model];
        [arr addObject:model.tel];;
    }];
    
    NSString *telStr = [arr componentsJoinedByString:@","];//将数组转换成字符串以","分离
    
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *strPath = [docPath stringByAppendingPathComponent:@"tel.txt"];
    
    NSError *error = nil;

    [telStr writeToFile:strPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserInfo sharedInstance].mobile forKey:@"mobile"];
    [dic setObject:strPath forKey:@"file"];
//    //筛选后的数组
//    NSMutableArray *contactsArr = [NSMutableArray array];
//    
//    [[ServerAPI sharedAPI] upLoadFileWithName:@"contactsFilterF" WithDic:dic key:@"file" completion:^(NSDictionary *resultDict) {
//        for (NSDictionary *dic in [resultDict objectForKey:@"results"]) {
//            ContactsModel *mod = [ContactsModel new];
//            [mod setValuesForKeysWithDictionary:dic];
//            [contactsArr addObject:mod];
//        }
//    }];

//    NSMutableArray *newAddressBookArr = [NSMutableArray array];
    [[ServerAPI sharedAPI] upLoadFileWithName:@"contactsFilterF" WithDic:dic key:@"file" success:^(NSDictionary *resultDict) {
        
        for (NSDictionary *dic in [resultDict objectForKey:@"results"]) {
            ContactsModel *contactsMod = [ContactsModel new];
            [contactsMod setValuesForKeysWithDictionary:dic];
            
            for (AddressBookModel *mod in addressBookArr) {
                
                if ([contactsMod.mobile isEqualToString: mod.tel]) {
                    if([contactsMod.isFriend isEqualToString:@"0"]){
                        mod.isFriend = @"2";
                    }
                    if ([contactsMod.isFriend isEqualToString:@"1"]) {
                        mod.isFriend = @"1";
                    }
                }
            }
        }
        
        AddressBookViewController *addVC = [AddressBookViewController new];
        addVC.sysArr = addressBookArr;
        [self.navigationController pushViewController:addVC animated:YES];
    } failure:^{
        
    }];
//    [[ServerAPI sharedAPI] upLoadFileWithName:@"contactsFilterF" WithDic:dic key:@"file" completion:^(NSDictionary *resultDict) {
//        for (NSDictionary *dic in [resultDict objectForKey:@"results"]) {
//            ContactsModel *contactsMod = [ContactsModel new];
//            [contactsMod setValuesForKeysWithDictionary:dic];
//            for (AddressBookModel *mod in addressBookArr) {
//                if ([contactsMod.mobile isEqualToString: mod.tel]) {
//                    if ([contactsMod.isFriend isEqualToString:@"1"]) {
//                        mod.isFriend = @"1";
//                    }else{
//                        mod.isFriend = @"2";
//                    }
//                }else{
//                    mod.isFriend = @"3";
//                }
//                [newAddressBookArr addObject:mod];
//            }
//        }
//    }];
    

    
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentLeft;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.searchMobile = textField.text;
}

#pragma mark - setters and getters

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MYCOLOR_BackGroudColor;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    }
    return _tableView;
}



@end
