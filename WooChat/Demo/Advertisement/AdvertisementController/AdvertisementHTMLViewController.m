//
//  AdvertisementHTMLViewController.m
//  WooChat
//
//  Created by yuling on 16/11/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AdvertisementHTMLViewController.h"

@interface AdvertisementHTMLViewController ()

@end

@implementation AdvertisementHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"HTML";
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    
    //HTML接口
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"8175591f8a2a4d97a96fe6f169bcd271" forKey:@"uid"];
//    [dic setObject:@"123456" forKey:@"mobile"];
//    [dic setObject:self.adid forKey:@"adid"];
//    [[ServerAPI sharedAPI] serverPostWithName:@"adHtml" WithDic:dic completion:^(NSDictionary *resultDict) {
//        NSLog(@"%@-HTMl", resultDict);
//    }];
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
