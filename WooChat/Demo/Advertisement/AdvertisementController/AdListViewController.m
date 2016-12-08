//
//  AdListViewController.m
//  WooChat
//
//  Created by yuling on 16/11/11.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AdListViewController.h"
#import "AdVertiseTableViewCell.h"
@interface AdListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation AdListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    //测试广告接口
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"8175591f8a2a4d97a96fe6f169bcd271" forKey:@"uid"];
//    [dic setObject:@"1992" forKey:@"birthyear"];
//    [dic setObject:@"8" forKey:@"birthmonth"];
//    [dic setObject:@"男" forKey:@"gender"];
//    [dic setObject:@"CHN" forKey:@"country"];
//    [dic setObject:@"210000" forKey:@"state"];
//    [dic setObject:@"210200" forKey:@"prefecture"];
//    [dic setObject:@"HTML" forKey:@"adclass"];
//    [[ServerAPI sharedAPI] serverPostWithName:@"superAd" WithDic:dic completion:^(NSDictionary *resultDict) {
//        NSLog(@"%@======dic", resultDict);
//    }];

}

#pragma mark - tableViewDelegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_HEIGHT/3.2+6)/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AdVertiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AdVertiseTableViewCell cellIdenttifier]];
    return cell;
}
#pragma mark - setters and getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        [_tableView registerClass:[AdVertiseTableViewCell class] forCellReuseIdentifier:[AdVertiseTableViewCell cellIdenttifier]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
