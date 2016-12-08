//
//  EditMeViewController.m
//  WooChat
//
//  Created by yuling on 16/11/14.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "EditMeViewController.h"
#import "EditMeTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "UserInfoModel.h"
@interface EditMeViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation EditMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编辑资料";
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    
    [self.view addSubview:self.tableView];
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.view.backgroundColor = MYCOLOR_BLUE;
    //        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
}

#pragma mark - tableViewDelegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[EditMeTableViewCell cellIdentifier]];
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"头像";
            cell.cellType = @"icon";
            break;
        case 1:
            cell.titleLabel.text = @"昵称";
            cell.descripLabel.text = self.model.nickName;
            break;
        case 2:
            cell.titleLabel.text = @"手机";
            cell.descripLabel.text = self.model.mobile;
            break;
        case 3:
            cell.titleLabel.text = @"性别";
            if ([self.model.gender isEqualToString:@"1"]) {
                cell.descripLabel.text = @"男";
            }else if ([self.model.gender isEqualToString:@"2"]){
                cell.descripLabel.text = @"女";
            }else{
                cell.descripLabel.text = @"未设置";
            }
            break;
        case 4:
            cell.titleLabel.text = @"年龄";
            if ([self.model.age isEqualToString:@""]) {
                cell.descripLabel.text = @"未设置";
            }else if ([self.model.age isEqualToString:@"1"]) {
                cell.descripLabel.text = @"未成年";
            }else if ([self.model.age isEqualToString:@"2"]) {
                cell.descripLabel.text = @"19~29岁";
            }else if ([self.model.age isEqualToString:@"3"]) {
                cell.descripLabel.text = @"30~39岁";
            }else if ([self.model.age isEqualToString:@"4"]) {
                cell.descripLabel.text = @"40~49岁";
            }else if ([self.model.age isEqualToString:@"5"]) {
                cell.descripLabel.text = @"50~59岁";
            }else if ([self.model.age isEqualToString:@"6"]) {
                cell.descripLabel.text = @"60~69岁";
            }else if ([self.model.age isEqualToString:@"7"]) {
                cell.descripLabel.text = @"70~79岁";
            }
            break;
        case 5:
            cell.titleLabel.text = @"地区";
            cell.descripLabel.text = self.model.country;
            break;
        case 6:
            cell.titleLabel.text = @"详细地址";
            cell.descripLabel.text = self.model.address;
            break;
        case 7:
            cell.titleLabel.text = @"兴趣";
            cell.descripLabel.text = self.model.hobbies;
            break;
        case 8:
            cell.titleLabel.text = @"ID";
//            cell.descripLabel.text = @"2818";
            break;
        case 9:
            cell.titleLabel.text = @"名片";
            cell.cellType = @"pic";
            break;
        case 10:
            cell.titleLabel.text = @"个性签名";
            cell.descripLabel.text = self.model.signature;
            break;
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserInfo sharedInstance].mobile forKey:@"mobile"];
//    [dic setObject:@"毛大毛" forKey:@"fullname"];
//    [dic setObject:@"1988" forKey:@"birthyear"];
//    [dic setObject:@"8" forKey:@"birthmonth"];
//    [dic setObject:@"20" forKey:@"birthday"];
//    [dic setObject:@"CHN" forKey:@"country"];
//    [dic setObject:@"210000" forKey:@"state"];
//    [dic setObject:@"210200" forKey:@"prefecture"];
//    [dic setObject:@"和平现代城24" forKey:@"address"];
//    [dic setObject:@"01,02,03" forKey:@"hobbies"];
//    [dic setObject:@"超级无敌美丽美少女" forKey:@"signature"];
    
    if (indexPath.row == 0) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择来源" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            NSString *mediaType = AVMediaTypeVideo;
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请在iPhone的\"设置-隐私-相机\"选项中,允许微信访问你的相机." delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alert show];
            }
            [self presentViewController:self.picker animated:YES completion:nil];
        }];
        [alert addAction:actionC];
        UIAlertAction *actionP= [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.picker animated:YES completion:nil];

        }];
        [alert addAction:actionP];
        /* cancle */
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        [alert addAction:cancle];
        
        
    }else if (indexPath.row == 1){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:[[alert textFields] firstObject].text forKey:@"nickname"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action];
        /* cancle */
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        [alert addAction:cancle];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 3){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别修改" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *actionM = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"1" forKey:@"gender"];
            [self changeWithDic:dic];
        }];
        [alert addAction:actionM];
        UIAlertAction *actionF = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"2" forKey:@"gender"];
            [self changeWithDic:dic];
        }];
        [alert addAction:actionF];
        /* cancle */
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:cancle];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 6){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"填写详细地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:[[alert textFields] firstObject].text forKey:@"address"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action];
        /* cancle */
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        [alert addAction:cancle];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 4){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"年龄修改" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"未成年" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"1" forKey:@"age"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action1];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"19~29岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"2" forKey:@"age"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action2];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"29~39岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"3" forKey:@"age"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action3];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"39~49岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"4" forKey:@"age"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action4];
        UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"49~59岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"5" forKey:@"age"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action5];
        UIAlertAction *action6 = [UIAlertAction actionWithTitle:@"59~69岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"6" forKey:@"age"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action6];
        UIAlertAction *action7 = [UIAlertAction actionWithTitle:@"69~79岁" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:@"7" forKey:@"age"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action7];
        /* cancle */
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:cancle];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else if(indexPath.row == 10){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"填写个性签名" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [dic setObject:[[alert textFields] firstObject].text forKey:@"signature"];
            [self changeWithDic:dic];
        }];
        [alert addAction:action];
        /* cancle */
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        [alert addAction:cancle];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)changeWithDic:(NSMutableDictionary *)dic{
    [[ServerAPI sharedAPI] serverPostWithName:@"memberUpdate" WithDic:dic completion:^(NSDictionary *resultDict) {
        NSLog(@"%@=-=-=-", resultDict);
    }];
}
#pragma mark - UIImagePickerControllerDelegate
//当用户选取完成后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@---", info);
    UIImage *pic = [info objectForKey:UIImagePickerControllerEditedImage];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UserInfo sharedInstance].mobile forKey:@"mobile"];
    [dic setObject:pic forKey:@"file"];
    [[ServerAPI sharedAPI] upLoadImageWithName:@"iconUpload" WithDic:dic key:@"file" completion:^(NSDictionary *resultDict) {
        NSLog(@"%@----上传", resultDict);
    }];
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

//当用户取消选取时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - setters and getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MYCOLOR_BackGroudColor;
        [_tableView registerClass:[EditMeTableViewCell class] forCellReuseIdentifier:[EditMeTableViewCell cellIdentifier]];
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
