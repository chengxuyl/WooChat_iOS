//
//  CountryView.m
//  WooChat
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "CountryView.h"
#import "CountryTableViewCell.h"
@interface CountryView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation CountryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self addSubview:self.tableView];
    return self;
}

#pragma mark - tableViewDelegate and datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CountryTableViewCell cellIdentifier]];
    
    cell.countryNameLabel.text = [[ServerAPI sharedAPI].countryList[indexPath.row] objectForKey:@"country"];
    if (indexPath.row == 0) {
        cell.voiceImage.hidden = YES;
    }else{
        cell.voiceImage.hidden = NO;
    }
    cell.countryImageView.image = [UIImage imageNamed:[[ServerAPI sharedAPI].countryList[indexPath.row] objectForKey:@"pic"]];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [ServerAPI sharedAPI].countryList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UserInfo sharedInstance].voice = [[ServerAPI sharedAPI].countryList[indexPath.row] objectForKey:@"voice"];
    [UserInfo sharedInstance].lang = [[ServerAPI sharedAPI].countryList[indexPath.row] objectForKey:@"lang"];
    NSLog(@"%@----%@", [UserInfo sharedInstance].voice, [UserInfo sharedInstance].lang);
    self.hidden  = YES;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[CountryTableViewCell class] forCellReuseIdentifier:[CountryTableViewCell cellIdentifier]];
    }
    return _tableView;
}


@end
