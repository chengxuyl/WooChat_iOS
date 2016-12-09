//
//  SearchChatHistroyViewController.m
//  WooChat
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "SearchChatHistroyViewController.h"
#import "ChatViewTableViewCell.h"
@interface SearchChatHistroyViewController ()< UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchList;
@property (nonatomic, strong) UILabel *noLabel;
@end

@implementation SearchChatHistroyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"聊天记录";
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    
    [self createTableView];
    [self createSearch];
    
    /* 无结果label */
    self.noLabel.frame = CGRectMake(0, 0, 100, 50);
    self.noLabel.center = self.view.center;
    self.noLabel.hidden = YES;
    [self.view addSubview:self.noLabel];
}

#pragma mark- TableView
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[ChatViewTableViewCell class] forCellReuseIdentifier:[ChatViewTableViewCell cellIdentifier]];
    _tableView.tableFooterView  = [[UIView alloc] init];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active) {
//                _tableView.hidden = NO;
        return [self.searchList count];
    }else{
//                _tableView.hidden = YES;
        return 0;
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatViewTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:[ChatViewTableViewCell cellIdentifier]];
    
    NIMMessage *message = self.searchList[indexPath.row];
    FMDatabase *db = [FMDatabase databaseWithPath:[[UserInfo sharedInstance] dataBasePath]];
    [db open];

    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[db stringForQuery:@"SELECT icon FROM PersonList WHERE imId = ?",message.session.sessionId]] placeholderImage:[UIImage imageNamed:@"chat"]] ;
    [db close];

    if (!message.senderName) {
        cell.nameLabel.text = [UserInfo sharedInstance].nickName;
    }else{
        cell.nameLabel.text = message.senderName;
    }
    cell.conLabel.text = message.text;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:message.timestamp];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    cell.timeLabel.text = currentDateStr;
    cell.noLabel.hidden = YES;

    return cell;
}


#pragma mark- SearchController
- (void)createSearch{
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate = self;//*****这个很重要，一定要设置并引用了代理之后才能调用searchBar的常用方法
    _searchController.dimsBackgroundDuringPresentation = NO;//是否添加半透明覆盖层
    _searchController.hidesNavigationBarDuringPresentation = NO;//是否隐藏导航栏
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

#pragma mark - searchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    if (![searchBar.text isEqualToString:@""]) {
    NIMMessageSearchOption *option = [[NIMMessageSearchOption alloc] init];
    option.searchContent = searchBar.text;
    //            NSArray *uids = [self searchUsersByKeyword:self.keyWord users:self.members];
    //            option.fromIds       = uids;
    option.limit         = 20;
    [[[NIMSDK sharedSDK] conversationManager] searchMessages:self.session option:option result:^(NSError * _Nullable error, NSArray<NIMMessage *> * _Nullable messages) {
        if (messages.count == 0) {
            self.noLabel.hidden = NO;
        }else{
            self.noLabel.hidden = YES;
        }
        self.searchList = [NSMutableArray arrayWithArray:messages];
        [self.tableView reloadData];
    }];}

    return YES;
}

#pragma mark - setters and getters 
- (UILabel *)noLabel{
    if (!_noLabel) {
        _noLabel = [UILabel new];
        _noLabel.text = @"无结果";
        _noLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noLabel;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchController dismissViewControllerAnimated:NO completion:nil];
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
