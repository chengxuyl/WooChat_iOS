//
//  Logon&LandView.h
//  WooChat
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login_LandView : UIView

#pragma --登陆页--
//登陆视图
@property UIView *landView;
//账号
@property UITextField *mobileTextField;
//密码
@property UITextField *passwordTextField;
//注册
@property UIButton *landBtn;
//忘记密码
@property UIButton *forgetBtn;
//登陆按钮
@property UIButton *logonBtn;

#pragma --找回密码页--
//找回密码页视图
@property UIView *passWordView;
//账号
@property UITextField *forgetMobileTextField;
//验证码
@property UITextField *securityCodeTextField;
//获取验证码按钮
@property UIButton *securityCodeBtn;
//新密码
@property UITextField *theNewPassWord;
//再次输入新密码
@property UITextField *againPassWord;
//确定按钮
@property UIButton *sureBtn;

#pragma --注册页--
//注册页视图
@property UIView *loginView;
//头像按钮
@property UIButton *headBtn;
//昵称
@property UITextField *Nickname;
//电话号码
@property UITextField *LoginMobileTextField;
//电话号码Label
@property UILabel *LoginMobileLabel;
//国家按钮
@property UIButton *countryBtn;
//密码
@property UITextField *registerPassword;
//选中按钮1
@property UIButton *checkedBtn1;
//选中按钮2
@property UIButton *checkedBtn2;
//使用条款
@property UIButton *useBtn;
//个人信息保护 按钮
@property UIButton *saveBtn;
//成为会员按钮
@property UIButton *memberBtn;
@end
