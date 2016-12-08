//
//  RegisterViewController.m
//  WooChat
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "RegisterViewController.h"
#import "Login&LandView.h"
#import <AFNetworking.h>
#import "ServerAPI.h"
@interface RegisterViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property Login_LandView *LLView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createPage];
    self.navigationItem.title = @"加入会员";
}
#pragma mark - 页面
- (void)createPage{
    _LLView = [[Login_LandView alloc]init];
    self.view = _LLView.loginView;
    [_LLView.headBtn addTarget:self action:@selector(headChoose:) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.countryBtn addTarget:self action:@selector(popCountry) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.checkedBtn1 addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.checkedBtn2 addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.useBtn addTarget:self action:@selector(useBtnPush) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.saveBtn addTarget:self action:@selector(saveBtnPush) forControlEvents:UIControlEventTouchUpInside];
    [_LLView.memberBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 注册
-(void)registerData
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:_LLView.LoginMobileTextField.text forKey:@"mobile"];
    [dic setObject:_LLView.registerPassword.text forKey:@"secret"];
    [dic setObject:_LLView.Nickname.text forKey:@"nickname"];

    [[ServerAPI sharedAPI] serverPostWithName:@"register" WithDic:dic completion:^(NSDictionary *resultDict) {
        NSString *code = [resultDict objectForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertC animated:YES completion:nil];
            UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //确定点击
                NSString *imid = [resultDict objectForKey:@"imid"];
                NSString *imtoken = [resultDict objectForKey:@"imtoken"];
                NSLog(@"imid--%@ /nimtoken--%@",imid,imtoken);
                [self.navigationController popViewControllerAnimated:nil];
            }];
            [alertC addAction:destructive];
        }
    }];
}
#pragma mark - 点击事件
- (void)registerClick{
    [self registerData];
}
//收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//头像选取
- (void)headChoose:(UIButton *)btn{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张",@"去相册选一张", nil];
    
    [actionSheet showInView:self.view];
}
//下方弹出回调
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self clickCamera];
            break;
        case 1:
            [self clickpickerImage];
            break;
        default:
            break;
    }
}
//点击相机
- (void)clickCamera{
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentModalViewController:picker animated:YES];//进入照相界面
}
//点击相册
- (void)clickpickerImage{
    //创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
//    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    //图片存入相册
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissModalViewControllerAnimated:YES];
    [_LLView.headBtn setBackgroundImage:image forState:UIControlStateNormal];
}
//电话号码国家按钮弹出菜单
-(void)popCountry{
    NSLog(@"123");
}
//选中按钮点击事件
- (void)selectedBtn:(UIButton *)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
    }
    else
        btn.selected = YES;
}
//使用条款跳转
- (void)useBtnPush{

}
//个人信息保护跳转
- (void)saveBtnPush{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
