//
//  LogonViewController.m
//  WooChat
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "LoginViewController.h"
#import "Login&LandView.h"
#import "FriendsViewController.h"
#import "RetrievePassWordViewController.h"
#import "RegisterViewController.h"
#import "ServerAPI.h"
#import "NIMSDK.h"
@interface LoginViewController ()
@property Login_LandView *LLView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self createPage];
}
#pragma mark - 导航条
-(void)createNavigation{
    self.navigationItem.title = @"登录";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}
#pragma mark - 页面
-(void)createPage{
    _LLView = [[Login_LandView alloc]init];
    self.view = _LLView.landView;
    [_LLView.landBtn addTarget:self action:@selector(land) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.forgetBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.logonBtn addTarget:self action:@selector(logon) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 点击事件
//收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//注册
- (void)land{
    RegisterViewController *RegisterVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RegisterVC animated:YES];
}
//忘记密码
- (void)forget{
    RetrievePassWordViewController *RetrievePassWordVC = [[RetrievePassWordViewController alloc]init];
    [self.navigationController pushViewController:RetrievePassWordVC animated:YES];
}
#pragma mark - 登陆
//登陆
- (void)logon{
    NSString *mobile = _LLView.mobileTextField.text;
    NSString *secret = _LLView.passwordTextField.text;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:mobile forKey:@"mobile"];
    [dic setObject:secret forKey:@"secret"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ServerAPI sharedAPI] serverPostWithName:@"login" WithDic:dic completion:^(NSDictionary *resultDict) {
        
        NSString *code = [resultDict objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            [UserInfo sharedInstance].icon = [resultDict objectForKey:@"icon"];
            [UserInfo sharedInstance].imId = [resultDict objectForKey:@"imId"];
            [UserInfo sharedInstance].nickName = [resultDict objectForKey:@"nickName"];
            [UserInfo sharedInstance].uid = [resultDict objectForKey:@"uid"];
            [UserInfo sharedInstance].mobile = mobile;
            [UserInfo sharedInstance].passWord = secret;
            [UserInfo sharedInstance].imToken = [resultDict objectForKey:@"imtoken"];
            
            [[[NIMSDK sharedSDK] loginManager] login:[resultDict objectForKey:@"imId"]
                                               token:[resultDict objectForKey:@"imtoken"]
                                          completion:^(NSError *error) {
                                              if (!error) {
                                                  NSLog(@"登陆成功");
                                              }else
                                                  NSLog(@"%@",error);
                                          }];
            [self.view endEditing:YES];
            FriendsViewController *friendsVC = [[FriendsViewController alloc]init];
            [self.navigationController pushViewController:friendsVC animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else if ([code isEqualToString:@"302"]) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [ViewFactory alertViewShowWithTitle:@"提示" message:@"密码错误"];
        }else if ([code isEqualToString:@"310"]){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [ViewFactory alertViewShowWithTitle:@"提示" message:@"用户不存在"];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
