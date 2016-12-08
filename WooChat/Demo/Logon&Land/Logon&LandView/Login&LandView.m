//
//  Logon&LandView.m
//  WooChat
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "Login&LandView.h"

@implementation Login_LandView
- (instancetype)init
{
    self = [super init];
    if (self) {
#pragma --登陆页--
        _landView = [[UIView alloc]initWithFrame:self.superview.bounds];
        //账号
        _landView.backgroundColor = [UIColor whiteColor];
        
        _mobileTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/6, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _mobileTextField.layer.borderWidth = 0.5f;
        _mobileTextField.layer.cornerRadius = 10;
        _mobileTextField.layer.borderColor = MYCOLOR_GRAY.CGColor;
        _mobileTextField.placeholder = @"手机号";
        _mobileTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _mobileTextField.leftViewMode = UITextFieldViewModeAlways;
        [_landView addSubview:_mobileTextField];
        
        //密码
        _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/3.8, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _passwordTextField.layer.borderWidth = 0.5f;
        _passwordTextField.layer.cornerRadius = 10;
        _passwordTextField.layer.borderColor = MYCOLOR_GRAY.CGColor;
        _passwordTextField.placeholder = @"密码";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.clearsOnBeginEditing = YES;
        
        _passwordTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        [_landView addSubview:_passwordTextField];
        
        //注册
        _landBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/2.7, SCREEN_WIDTH/4, SCREEN_HEIGHT/20)];
        [_landBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_landBtn setTitleColor:[UIColor colorWithCGColor:MYCOLOR_GRAY.CGColor] forState:UIControlStateNormal];
        [_landView addSubview:_landBtn];
        
        //忘记密码
        _forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.98, SCREEN_HEIGHT/2.7, SCREEN_WIDTH/4, SCREEN_HEIGHT/20)];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetBtn.titleLabel.textColor = [UIColor blackColor];
        [_forgetBtn setTitleColor:[UIColor colorWithCGColor:MYCOLOR_GRAY.CGColor] forState:UIControlStateNormal];
        [_landView addSubview:_forgetBtn];
        
        //中间的线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2.7, SCREEN_WIDTH/300, SCREEN_HEIGHT/20)];
        line.layer.backgroundColor = MYCOLOR_GRAY.CGColor;
        [_landView addSubview:line];
        
        //登陆按钮
        _logonBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/2.2, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _logonBtn.layer.backgroundColor = MYCOLOR_BLUE.CGColor;
        _logonBtn.layer.cornerRadius = 10;
        [_logonBtn setTitle:@"登 录" forState:UIControlStateNormal];
        _logonBtn.titleLabel.font = [UIFont systemFontOfSize: 22.0];
        [_landView addSubview:_logonBtn];
#pragma --找回密码页--
        //找回密码页视图
        _passWordView = [[UIView alloc]initWithFrame:self.superview.bounds];
        _passWordView.backgroundColor = [UIColor whiteColor];
        
        //账号
        _forgetMobileTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/6, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _forgetMobileTextField.layer.borderWidth = 0.5f;
        _forgetMobileTextField.layer.cornerRadius = 10;
        _forgetMobileTextField.layer.borderColor = MYCOLOR_GRAY.CGColor;
        _forgetMobileTextField.placeholder = @"请输入您的手机号";
        _forgetMobileTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _forgetMobileTextField.leftViewMode = UITextFieldViewModeAlways;
        [_passWordView addSubview:_forgetMobileTextField];
        
        //验证码
        _securityCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/3.8, SCREEN_WIDTH/2.35, SCREEN_HEIGHT/15)];
        _securityCodeTextField.layer.borderWidth = 0.5f;
        _securityCodeTextField.layer.cornerRadius = 10;
        _securityCodeTextField.layer.borderColor = MYCOLOR_GRAY.CGColor;
        _securityCodeTextField.placeholder = @"请输入验证码";
        _securityCodeTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _securityCodeTextField.leftViewMode = UITextFieldViewModeAlways;
        [_passWordView addSubview:_securityCodeTextField];
        
        //获取验证码按钮
        _securityCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.9, SCREEN_HEIGHT/3.8, SCREEN_WIDTH/2.35, SCREEN_HEIGHT/15)];
        _securityCodeBtn.layer.backgroundColor = MYCOLOR_BLUE.CGColor;
        _securityCodeBtn.layer.cornerRadius = 10;
        [_securityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _securityCodeBtn.titleLabel.font = [UIFont systemFontOfSize: 22.0];
        [_passWordView addSubview:_securityCodeBtn];

        //新密码
        _theNewPassWord = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/2.8, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _theNewPassWord.layer.borderWidth = 0.5f;
        _theNewPassWord.layer.cornerRadius = 10;
        _theNewPassWord.layer.borderColor = MYCOLOR_GRAY.CGColor;
        _theNewPassWord.placeholder = @"请输入新密码";
        _theNewPassWord.secureTextEntry = YES;
        _theNewPassWord.clearsOnBeginEditing = YES;
        _theNewPassWord.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _theNewPassWord.leftViewMode = UITextFieldViewModeAlways;
        [_passWordView addSubview:_theNewPassWord];

        //再次输入新密码
        _againPassWord = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/2.2, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _againPassWord.layer.borderWidth = 0.5f;
        _againPassWord.layer.cornerRadius = 10;
        _againPassWord.layer.borderColor = MYCOLOR_GRAY.CGColor;
        _againPassWord.placeholder = @"请再次输入新密码";
        
        _againPassWord.secureTextEntry = YES;
        _againPassWord.clearsOnBeginEditing = YES;
        _againPassWord.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _againPassWord.leftViewMode = UITextFieldViewModeAlways;
        [_passWordView addSubview:_againPassWord];

        //确定按钮
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/1.8, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _sureBtn.layer.backgroundColor = MYCOLOR_BLUE.CGColor;
        _sureBtn.layer.cornerRadius = 10;
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize: 22.0];
        [_passWordView addSubview:_sureBtn];
        
#pragma --注册页--
        //注册页视图
        _loginView = [[UIView alloc]initWithFrame:self.superview.bounds];
        _loginView.backgroundColor = [UIColor whiteColor];
        
        //头像按钮
        _headBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.5, SCREEN_HEIGHT/7, SCREEN_WIDTH/5, SCREEN_WIDTH/5)];
        _headBtn.layer.masksToBounds = YES;
        [_headBtn setBackgroundImage:[UIImage imageNamed:@"circle_select"] forState:UIControlStateNormal];
        [_loginView addSubview:_headBtn];
        
        //昵称
        _Nickname = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, SCREEN_HEIGHT/3.3, SCREEN_WIDTH/1.35, SCREEN_HEIGHT/15)];
        _Nickname.placeholder = @"请输入真实姓名";
        _Nickname.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _Nickname.leftViewMode = UITextFieldViewModeAlways;

        UIImageView *NicknameBackgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/3.3, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        [NicknameBackgroundImage setImage:[UIImage imageNamed:@"joinmember_textarea"]];
        UILabel *NicknameLabel = [[UILabel alloc]init];
        NicknameLabel.frame =CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/3.3, SCREEN_WIDTH/6, SCREEN_HEIGHT/15);
        NicknameLabel.text = @"昵称";
        NicknameLabel.textAlignment = NSTextAlignmentCenter;
        NicknameLabel.textColor = [UIColor whiteColor];
        [_loginView addSubview:NicknameBackgroundImage];
        [_loginView addSubview:NicknameLabel];
        [_loginView addSubview:_Nickname];
        
        
        //电话号码 & 电话号码背景图 &国家按钮_LLView
        _LoginMobileTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, SCREEN_HEIGHT/2.6, SCREEN_WIDTH/1.35, SCREEN_HEIGHT/15)];
        _LoginMobileTextField.placeholder = @"电话号码长度为8-11位";
        _LoginMobileTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _LoginMobileTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
        UIImageView *LoginMobileBackgroundimageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/2.6, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        [LoginMobileBackgroundimageView setImage:[UIImage imageNamed:@"joinmember_textarea"]];
        
        _LoginMobileLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/17, SCREEN_HEIGHT/2.6, SCREEN_WIDTH/11, SCREEN_HEIGHT/15)];
        _LoginMobileLabel.text = @"82";
        _LoginMobileLabel.textAlignment = NSTextAlignmentRight;
        _LoginMobileLabel.textColor = [UIColor whiteColor];
        
        UIImageView *arrowIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"littlepoint"]];
        arrowIV.frame = CGRectMake(SCREEN_WIDTH/6.1, SCREEN_HEIGHT/2.41, SCREEN_WIDTH/50, SCREEN_HEIGHT/110);
        
        _countryBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/2.6, SCREEN_WIDTH/6, SCREEN_HEIGHT/15)];
        [_loginView addSubview:LoginMobileBackgroundimageView];
        [_loginView addSubview:_LoginMobileLabel];
        [_loginView addSubview:arrowIV];
        [_loginView addSubview:_countryBtn];
        [_loginView addSubview:_LoginMobileTextField];
        
        //密码
        _registerPassword = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, SCREEN_HEIGHT/2.15, SCREEN_WIDTH/1.35, SCREEN_HEIGHT/15)];
        _registerPassword.placeholder = @"请输入密码";
        _registerPassword.secureTextEntry = YES;
        _registerPassword.clearsOnBeginEditing = YES;
        _registerPassword.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        _registerPassword.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView *registerPasswordBackgroundimageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/2.15, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        [registerPasswordBackgroundimageView setImage:[UIImage imageNamed:@"joinmember_textarea"]];
        UILabel *registerPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/2.15, SCREEN_WIDTH/6, SCREEN_HEIGHT/15)];
        registerPasswordLabel.text = @"密码";
        registerPasswordLabel.textAlignment = NSTextAlignmentCenter;
        registerPasswordLabel.textColor = [UIColor whiteColor];
        
        [_loginView addSubview:registerPasswordBackgroundimageView];
        [_loginView addSubview:registerPasswordLabel];
        [_loginView addSubview:_registerPassword];
        
        //选中按钮
        _checkedBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/16, SCREEN_HEIGHT/1.8, SCREEN_WIDTH/16, SCREEN_HEIGHT/30)];
        [_checkedBtn1 setBackgroundImage:[UIImage imageNamed:@"v_nomal"] forState:UIControlStateNormal];
        [_checkedBtn1 setBackgroundImage:[UIImage imageNamed:@"v_select"] forState:UIControlStateSelected];
        _checkedBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/16, SCREEN_HEIGHT/1.65, SCREEN_WIDTH/16, SCREEN_HEIGHT/30)];
        [_checkedBtn2 setBackgroundImage:[UIImage imageNamed:@"v_nomal"] forState:UIControlStateNormal];
        [_checkedBtn2 setBackgroundImage:[UIImage imageNamed:@"v_select"] forState:UIControlStateSelected];
        [_loginView addSubview:_checkedBtn1];
        [_loginView addSubview:_checkedBtn2];
        
        //同意Label
        UILabel *agreeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8, SCREEN_HEIGHT/1.8, SCREEN_WIDTH/8, SCREEN_HEIGHT/30)];
        agreeLabel1.text = @"同意";
        agreeLabel1.textAlignment = NSTextAlignmentCenter;
        agreeLabel1.textColor = [UIColor blackColor];
        
        UILabel *agreeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8, SCREEN_HEIGHT/1.65, SCREEN_WIDTH/8, SCREEN_HEIGHT/30)];
        agreeLabel2.text = @"同意";
        agreeLabel2.textAlignment = NSTextAlignmentCenter;
        agreeLabel2.textColor = [UIColor blackColor];
        [_loginView addSubview:agreeLabel1];
        [_loginView addSubview:agreeLabel2];
        
        //使用条款 & 个人信息保护
        UILabel *useLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.1, SCREEN_HEIGHT/1.8, SCREEN_WIDTH/4.4, SCREEN_HEIGHT/30)];
        useLabel1.text = @"使用条款";
        useLabel1.textColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0];
        
        UILabel *useLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.1, SCREEN_HEIGHT/1.65, SCREEN_WIDTH/2.9, SCREEN_HEIGHT/30)];
        useLabel2.text = @"个人信息保护";
        useLabel2.textColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0];
        
        [_loginView addSubview:useLabel1];
        [_loginView addSubview:useLabel2];
        
        
        _useBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.12, SCREEN_HEIGHT/1.799, SCREEN_WIDTH/4.4, SCREEN_HEIGHT/30)];
                              
        _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.12, SCREEN_HEIGHT/1.648, SCREEN_WIDTH/2.9, SCREEN_HEIGHT/30)];
                              
        [_loginView addSubview:_useBtn];
        [_loginView addSubview:_saveBtn];
        
        //成为会员按钮
        _memberBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/22, SCREEN_HEIGHT/1.5, SCREEN_WIDTH/1.1, SCREEN_HEIGHT/15)];
        _memberBtn.layer.backgroundColor = MYCOLOR_BLUE.CGColor;
        _memberBtn.layer.cornerRadius = 10;
        [_memberBtn setTitle:@"成为会员" forState:UIControlStateNormal];
        _memberBtn.titleLabel.font = [UIFont systemFontOfSize: 22.0];
        [_loginView addSubview:_memberBtn];
        
    }
    return self;
}
@end
