//
//  SearchChatHistroyViewController.m
//  WooChat
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "SearchChatHistroyViewController.h"

@interface SearchChatHistroyViewController ()< UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchList;
@end

@implementation SearchChatHistroyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"聊天记录";
    self.view.backgroundColor = MYCOLOR_BackGroudColor;
    
    [self createTableView];
    [self createSearch];
}

#pragma mark- TableView
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //取消选中状态
        //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f  blue:arc4random()%255/256.0f  alpha:1];
    }
    if (self.searchController.active) {
        //        _tableView.hidden = NO;
        NIMMessage *message = self.searchList[indexPath.row];
        [cell.textLabel setText:message.text];
    }
    
    
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
        self.searchList = [NSMutableArray arrayWithArray:messages];
        [self.tableView reloadData];
    }];}

    return YES;
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
