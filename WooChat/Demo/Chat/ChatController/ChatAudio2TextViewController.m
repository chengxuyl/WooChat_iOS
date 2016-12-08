//
//  ChatAudio2TextViewController.m
//  WooChat
//
//  Created by qiubo on 2016/12/2.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ChatAudio2TextViewController.h"

@interface ChatAudio2TextViewController ()<NIMMediaManagerDelgate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation ChatAudio2TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.cancelBtn];
    [[[NIMSDK sharedSDK] mediaManager] addDelegate:self];
    NIMAudioToTextOption *option = [[NIMAudioToTextOption alloc] init];
    option.url                   = [(NIMAudioObject *)self.message.messageObject url];
    option.filepath              = [(NIMAudioObject *)self.message.messageObject path];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [[[NIMSDK sharedSDK] mediaManager] transAudioToText:option
                                                 result:^(NSError *error, NSString *text) {
                                                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                     weakSelf.cancelBtn.hidden = YES;
                                                     [weakSelf show:error
                                                               text:text];
                                                     if (!error) {
                                                         weakSelf.message.isPlayed = YES;
                                                     }else{
                                                         NSLog(@"audio 2 text error, %@",error);
                                                         [weakSelf.textView removeFromSuperview];
                                                     }
                                                 }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.textView addGestureRecognizer:tap];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self hide];
}

- (void)hide{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)show:(NSError *)error
        text:(NSString *)text
{
    if (error) {
        [ViewFactory alertViewShowWithTitle:@"提示" message:@"转换失败"];
    }
    else
    {
        _textView.text = text;
        [_textView sizeToFit];
        if (self.textView.height > self.view.height) {
            self.textView.height = self.view.height;
            self.textView.scrollEnabled = YES;
        }else{
            self.textView.scrollEnabled = NO;
        }
    }
}
#pragma mark - setters and getters
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
        _textView.font = [UIFont systemFontOfSize:20];
        _textView.editable = NO;
    }
    return _textView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _cancelBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 80, 80, 30);
        _cancelBtn.centerX = self.view.centerX;
        _cancelBtn.layer.cornerRadius = 10;
        _cancelBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _cancelBtn.layer.borderWidth = 0.5;
    }
    return _cancelBtn;
}

- (void)setMessage:(NIMMessage *)message{
    if (_message != message) {
        _message = message;
    }
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
