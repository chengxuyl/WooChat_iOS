//
//  SetViewController.m
//  WooChat
//
//  Created by yuling on 16/11/14.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AddAuthViewController.h"
#import "ReorganizeScrollView.h"
#import <AVFoundation/AVFoundation.h>
@interface AddAuthViewController ()<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation AddAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    self.title = @"添加广告商";
    [self.view addSubview:self.scrollView];
    
    
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.view.backgroundColor = MYCOLOR_BLUE;
    //        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.picker.delegate = self;
    self.picker.allowsEditing = YES;
    
    //请求参数字典
    self.dic = [NSMutableDictionary dictionary];
    [self.dic setObject:[UserInfo sharedInstance].uid forKey:@"uid"];
    [self.dic setObject:[UserInfo sharedInstance].mobile forKey:@"mobile"];
    
    [self.dic setObject:@"" forKey:@"agentcode"];//邀请码b
    [self.dic setObject:@"" forKey:@"cname"];//公司名称b
    [self.dic setObject:@"" forKey:@"legal"];//法人b
    [self.dic setObject:@"" forKey:@"cnumber"];//营业号f
    [self.dic setObject:@"" forKey:@"tel"];//固定电话b
    [self.dic setObject:@"" forKey:@"zipcode"];//邮编f
    [self.dic setObject:@"" forKey:@"contact"];//负责人f
    [self.dic setObject:@"" forKey:@"contactmobile"];//负责人电话f
    [self.dic setObject:@"" forKey:@"contactemail"];//负责人邮箱f
    [self.dic setObject:@"" forKey:@"url"];//店铺urlf
    [self.dic setObject:@"" forKey:@"address"];//店铺地址f
    [self.dic setObject:@"" forKey:@"licensepic"];//营业执照照片b
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBtn)];
    UIView *backGroudView = [[UIView alloc] init];
    backGroudView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(24.0f/750.0f*SCREEN_WIDTH, 0, SCREEN_WIDTH * 3/ 10, 98.0f/750.0f*SCREEN_WIDTH)];
    label1.attributedText = [self attributedWithString:@"*邀请码:"];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, label1.bottom, SCREEN_WIDTH, 0.5)];
    line1.backgroundColor = MYCOLOR_Line;
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(label1.right+20, label1.y, SCREEN_WIDTH - label1.right, label1.height)];
    textField1.placeholder = @"请输入邀请码";
    textField1.delegate = self;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label1.bottom, label1.width, label1.height)];
    label2.attributedText = [self attributedWithString:@"*公司名称:"];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, label2.bottom, line1.width, line1.height)];
    line2.backgroundColor = MYCOLOR_Line;
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label2.y, textField1.width, textField1.height)];
    textField2.placeholder = @"请输入公司名称";
    textField2.delegate = self;
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label2.bottom, label1.width, label1.height)];
    label3.attributedText = [self attributedWithString:@"*法人:"];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, label3.bottom, line1.width, line1.height)];
    line3.backgroundColor = MYCOLOR_Line;
    UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label3.y, textField1.width, textField1.height)];
    textField3.placeholder = @"请输入法人姓名";
    textField3.delegate = self;
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label3.bottom, label1.width, label1.height)];
    label4.attributedText = [self attributedWithString:@"  营业号:"];
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, label4.bottom, line1.width, line1.height)];
    line4.backgroundColor = MYCOLOR_Line;
    UITextField *textField4 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label4.y, textField1.width, textField1.height)];
    textField4.placeholder = @"请输入营业号";
    textField4.delegate = self;
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label4.bottom, label1.width, label1.height)];
    label5.attributedText = [self attributedWithString:@"*固定电话:"];
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, label5.bottom, line1.width, line1.height)];
    line5.backgroundColor = MYCOLOR_Line;
    UITextField *textField5 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label5.y, textField1.width, textField1.height)];
    textField5.placeholder = @"请输入固定电话";
    textField5.delegate = self;
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label5.bottom, label1.width, label1.height)];
    label6.attributedText = [self attributedWithString:@"  邮编:"];
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(0, label6.bottom, line1.width, line1.height)];
    line6.backgroundColor = MYCOLOR_Line;
    UITextField *textField6 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label6.y, textField1.width, textField1.height)];
    textField6.placeholder = @"请输入邮编";
    textField6.delegate = self;
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label6.bottom, label1.width, label1.height)];
    label7.attributedText = [self attributedWithString:@"  负责人:"];
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(0, label7.bottom, line1.width, line1.height)];
    line7.backgroundColor = MYCOLOR_Line;
    UITextField *textField7 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label7.y, textField1.width, textField1.height)];
    textField7.placeholder = @"请输入负责人姓名";
    textField7.delegate = self;
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label7.bottom, label1.width, label1.height)];
    label8.attributedText = [self attributedWithString:@"  负责人电话:"];
    UIView *line8 = [[UIView alloc] initWithFrame:CGRectMake(0, label8.bottom, line1.width, line1.height)];
    line8.backgroundColor = MYCOLOR_Line;
    UITextField *textField8 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label8.y, textField1.width, textField1.height)];
    textField8.placeholder = @"请输入负责人电话";
    textField8.delegate = self;
    
    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label8.bottom, label1.width, label1.height)];
    label9.attributedText = [self attributedWithString:@"  负责人邮箱:"];
    UIView *line9 = [[UIView alloc] initWithFrame:CGRectMake(0, label9.bottom, line1.width, line1.height)];
    line9.backgroundColor = MYCOLOR_Line;
    UITextField *textField9 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label9.y, textField1.width, textField1.height)];
    textField9.placeholder = @"请输入负责人邮箱";
    textField9.delegate = self;

    UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label9.bottom, label1.width, label1.height)];
    label10.attributedText = [self attributedWithString:@"  店铺URL:"];
    UIView *line10 = [[UIView alloc] initWithFrame:CGRectMake(0, label10.bottom, line1.width, line1.height)];
    line10.backgroundColor = MYCOLOR_Line;
    UITextField *textField10 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label10.y, textField1.width, textField1.height)];
    textField10.placeholder = @"请输入店铺URL";
    textField10.delegate = self;
    
    UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label10.bottom, label1.width, label1.height)];
    label11.attributedText = [self attributedWithString:@"  地址:"];
    UIView *line11 = [[UIView alloc] initWithFrame:CGRectMake(0, label11.bottom, line1.width, line1.height)];
    line11.backgroundColor = MYCOLOR_Line;
    UITextField *textField11 = [[UITextField alloc] initWithFrame:CGRectMake(textField1.x, label11.y, textField1.width, textField1.height)];
    textField11.placeholder = @"请输入店铺地址";
    textField11.delegate = self;

    UILabel *label12 = [[UILabel alloc] initWithFrame:CGRectMake(label1.x, label11.bottom, label1.width, label1.height)];
    label12.attributedText = [self attributedWithString:@"*营业执照照片:"];

    UIImageView *addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(label1.right + 20, label12.y + 10, 60, 60)];
    addImageView.image = [UIImage imageNamed:@"添加图片"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    addImageView.userInteractionEnabled = YES;
    [addImageView addGestureRecognizer:tap];
    
    
    backGroudView.frame = CGRectMake(0, 10, SCREEN_WIDTH, addImageView.bottom + 10);
    [self.scrollView addSubview:backGroudView];
    [backGroudView addSubview:label1];
    [backGroudView addSubview:label2];
    [backGroudView addSubview:label3];
    [backGroudView addSubview:label4];
    [backGroudView addSubview:label5];
    [backGroudView addSubview:label6];
    [backGroudView addSubview:label7];
    [backGroudView addSubview:label8];
    [backGroudView addSubview:label9];
    [backGroudView addSubview:label10];
    [backGroudView addSubview:label11];
    [backGroudView addSubview:label12];
    [backGroudView addSubview:addImageView];
    
    [backGroudView addSubview:line1];
    [backGroudView addSubview:line2];
    [backGroudView addSubview:line3];
    [backGroudView addSubview:line4];
    [backGroudView addSubview:line5];
    [backGroudView addSubview:line6];
    [backGroudView addSubview:line7];
    [backGroudView addSubview:line8];
    [backGroudView addSubview:line9];
    [backGroudView addSubview:line10];
    [backGroudView addSubview:line11];
    
    [backGroudView addSubview:textField1];
    [backGroudView addSubview:textField2];
    [backGroudView addSubview:textField3];
    [backGroudView addSubview:textField4];
    [backGroudView addSubview:textField5];
    [backGroudView addSubview:textField6];
    [backGroudView addSubview:textField7];
    [backGroudView addSubview:textField8];
    [backGroudView addSubview:textField9];
    [backGroudView addSubview:textField10];
    [backGroudView addSubview:textField11];
}

#pragma mark - private method
- (NSMutableAttributedString *)attributedWithString:(NSString *)string{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] range:NSMakeRange(1, str.length - 1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    return str;
}

- (void)tapImageView:(UITapGestureRecognizer *)gesture{
    [self.view endEditing:YES];
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
}

#pragma mark - UIImagePickerControllerDelegate
//当用户选取完成后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *image = [UIImage imageNamed:@"detail.jpg"];
    // 原始数据
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    }else{
        data = UIImagePNGRepresentation(image);
    }
    [[NSFileManager defaultManager] createFileAtPath:[NSTemporaryDirectory() stringByAppendingString:@"image.jpg"] contents:data attributes:nil];
    
    UIImage *newImage = [UIImage imageWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingString:@"image.jpg"]];
   
    data = UIImageJPEGRepresentation(newImage, 0.00000000000001);
    UIImage *result = [UIImage imageWithData:data];
    [self.dic setObject:result forKey:@"licensepic"];//营业执照照片b
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}


//当用户取消选取时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - privatemethod

- (void)saveBtn{
    NSLog(@"%@---dic", self.dic);
    [self.view endEditing:YES];
//    [[ServerAPI sharedAPI] serverPostWithName:@"commercialAuth" WithDic:self.dic completion:^(NSDictionary *resultDict) {
//        NSLog(@"%@----", resultDict);
//    }];
    
    [[ServerAPI sharedAPI] upLoadImageWithName:@"commercialAuth" WithDic:self.dic key:@"licensepic" completion:^(NSDictionary *resultDict) {
        NSLog(@"%@----上传成功", resultDict);
    }];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.scrollView setContentOffset:CGPointMake(0, textField.y - 64) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    NSLog(@"%@--textField", textField.text);
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([textField.placeholder isEqualToString:@"请输入邀请码"]) {
        [self.dic setObject:textField.text forKey:@"agentcode"];//邀请码b
    }else if ([textField.placeholder isEqualToString:@"请输入公司名称"]){
        [self.dic setObject:textField.text forKey:@"cname"];//公司名称b
    }else if ([textField.placeholder isEqualToString:@"请输入法人姓名"]){
        [self.dic setObject:textField.text forKey:@"legal"];//法人b
    }else if ([textField.placeholder isEqualToString:@"请输入营业号"]){
        [self.dic setObject:textField.text forKey:@"cnumber"];//营业号f
    }else if ([textField.placeholder isEqualToString:@"请输入固定电话"]){
        [self.dic setObject:textField.text forKey:@"tel"];//固定电话b
    }else if ([textField.placeholder isEqualToString:@"请输入邮编"]){
        [self.dic setObject:textField.text forKey:@"zipcode"];//邮编f
    }else if ([textField.placeholder isEqualToString:@"请输入负责人姓名"]){
        [self.dic setObject:textField.text forKey:@"contact"];//负责人f
    }else if ([textField.placeholder isEqualToString:@"请输入负责人电话"]){
        [self.dic setObject:textField.text forKey:@"contactmobile"];//负责人电话f
    }else if ([textField.placeholder isEqualToString:@"请输入负责人邮箱"]){
        [self.dic setObject:textField.text forKey:@"contactemail"];//负责人邮箱f
    }else if ([textField.placeholder isEqualToString:@"请输入店铺URL"]){
        [self.dic setObject:textField.text forKey:@"url"];//店铺urlf
    }else if ([textField.placeholder isEqualToString:@"请输入店铺地址"]){
        [self.dic setObject:textField.text forKey:@"address"];//店铺地址f
    }
}

#pragma mark - setters and getters
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[ReorganizeScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(0, 700);
    }
    return _scrollView;
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
