//
//  RetrievePassWordViewController.m
//  WooChat
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "RetrievePassWordViewController.h"
#import "Login&LandView.h"
@interface RetrievePassWordViewController ()
@property Login_LandView *LLView;

@end

@implementation RetrievePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createPage];
}
#pragma mark - 页面
- (void)createPage{
    self.navigationItem.title = @"找回密码";
    _LLView = [[Login_LandView alloc]init];
    self.view = _LLView.passWordView;
}
//收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
