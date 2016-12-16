//
//  ChatViewController.m
//  Moatong
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ChatViewController.h"
#import "NavigationView.h"
#import "ToolsbarView.h"
#import "FriendsViewController.h"
#import "AdvertisementViewController.h"
#import "FriendCircleViewController.h"
#import "MoreViewController.h"
#import "NIMSDK.h"
#import "ChatViewTableViewCell.h"
#import "AboutMeViewController.h"
#import "DialogueViewController.h"
#import "CountryView.h"
@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource, NIMConversationManagerDelegate, NIMLoginManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChatViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigation];
    [self createPage];
    [self.view addSubview:self.tableView];
    //获取会话列表
    _recentSessions = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    if (!self.recentSessions.count) {
        _recentSessions = [NSMutableArray array];
    }
    [[[NIMSDK sharedSDK] conversationManager] addDelegate:self];
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
}

#pragma mark - NIMLoginManagerDelegate
- (void)onLogin:(NIMLoginStep)step
{
    if (step == NIMLoginStepSyncOK) {
        [self reload];
    }
}

#pragma mark - 导航条设置
-(void)createNavigation{
    self.navigationItem.title = @"MoaTong";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    NavigationView *nv = [[NavigationView alloc]init];
    UIBarButtonItem *headImageBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.headImageBtn];
    self.navigationItem.leftBarButtonItem = headImageBtnItem;
    [nv.headImageBtn addTarget:self action:@selector(asd2) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.transelateBtn];
    self.navigationItem.rightBarButtonItem = RightBtnItem;
    [nv.transelateBtn addTarget:self action:@selector(rightPop:) forControlEvents:UIControlEventTouchUpInside];
    nv.transelateBtn.selected = NO;
    
}

- (void)rightPop:(UIButton *)btn{
    CountryView *view = [[CountryView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    view.center = self.view.center;
    [self.view addSubview:view];
}

- (void)asd2{
    AboutMeViewController *vc = [AboutMeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 创建页面
-(void)createPage{
    //页面跳转工具条
    ToolsbarView *toolsBarView = [[ToolsbarView alloc]initWithNum:2];
    [self.view addSubview:toolsBarView.toolsbar];
    [toolsBarView.FriendsBtn addTarget:self action:@selector(FriendsBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.adBtn addTarget:self action:@selector(adBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.FCBtn addTarget:self action:@selector(FCBtnPop) forControlEvents:UIControlEventTouchUpInside];
    [toolsBarView.moreBtn addTarget:self action:@selector(moreBtnPop) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 点击事件
//好友页面跳转
- (void)FriendsBtnPop{
    NSLog(@"zou");
    FriendsViewController *FriendsViewC = [[FriendsViewController alloc]init];
    UINavigationController *FriendsViewnc = [[UINavigationController alloc]initWithRootViewController:FriendsViewC];
    [ self presentViewController:FriendsViewnc animated: NO completion:nil];
    
}
//广告页面跳转
- (void)adBtnPop{
    AdvertisementViewController *AdvertisementViewC = [[AdvertisementViewController alloc]init];
    UINavigationController *AdvertisementViewnc = [[UINavigationController alloc]initWithRootViewController:AdvertisementViewC];
    [ self presentViewController:AdvertisementViewnc animated: NO completion:nil];
}
//朋友圈页面跳转
- (void)FCBtnPop{
    FriendCircleViewController *FriendCircleViewC = [[FriendCircleViewController alloc]init];
    UINavigationController *FriendCircleViewnc = [[UINavigationController alloc]initWithRootViewController:FriendCircleViewC];
    [ self presentViewController:FriendCircleViewnc animated: NO completion:nil];
}
//更多页面跳转
- (void)moreBtnPop{
    MoreViewController *MoreViewC = [[MoreViewController alloc]init];
    UINavigationController *MoreViewc = [[UINavigationController alloc]initWithRootViewController:MoreViewC];
    [ self presentViewController:MoreViewc animated: NO completion:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NIMRecentSession *recentSession = self.recentSessions[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self onDeleteRecentAtIndexPath:recentSession atIndexPath:indexPath];
    }
}
#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DialogueViewController *vc = [DialogueViewController new];
    vc.recent = self.recentSessions[indexPath.row];
    vc.friendIn = NO;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recentSessions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatViewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[ChatViewTableViewCell cellIdentifier]];
    NIMRecentSession *recent = self.recentSessions[indexPath.row];
    FMDatabase *db = [FMDatabase databaseWithPath:[[UserInfo sharedInstance] dataBasePath]];
    [db open];
    cell.nameLabel.text = [db stringForQuery:@"SELECT nickName FROM PersonList WHERE imId = ?",recent.session.sessionId];
    if (![db stringForQuery:@"SELECT nickName FROM PersonList WHERE imId = ?",recent.session.sessionId]) {
        [[NIMSDK sharedSDK].userManager fetchUserInfos:@[recent.session.sessionId] completion:^(NSArray<NIMUser *> * _Nullable users, NSError * _Nullable error) {
            cell.nameLabel.text = [users lastObject].userInfo.nickName;
        }];
    }
    NSString *url = [db stringForQuery:@"SELECT icon FROM PersonList WHERE imId = ?",recent.session.sessionId];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[url stringByReplacingOccurrencesOfString:@"8081" withString:@"8080"]] placeholderImage:[UIImage imageNamed:@"chat"]];
    [db close];

    if (recent.unreadCount == 0) {
        cell.noLabel.hidden = YES;
    }else{
        cell.noLabel.hidden = NO;
        cell.noLabel.text = [NSString stringWithFormat:@"%ld", recent.unreadCount];
    }
    cell.conLabel.text = [self messageContent:recent.lastMessage];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:recent.lastMessage.timestamp];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    cell.timeLabel.text = currentDateStr;
    return cell;
}

#pragma mark - NIMConversationManagerDelegate
- (void)didAddRecentSession:(NIMRecentSession *)recentSession
           totalUnreadCount:(NSInteger)totalUnreadCount{
    [self.recentSessions addObject:recentSession];
    [self sort];
    [self reload];
}

- (void)didUpdateRecentSession:(NIMRecentSession *)recentSession
              totalUnreadCount:(NSInteger)totalUnreadCount{
    for (NIMRecentSession *recent in self.recentSessions) {
        if ([recentSession.session.sessionId isEqualToString:recent.session.sessionId]) {
            [self.recentSessions removeObject:recent];
            break;
        }
    }
    NSInteger insert = [self findInsertPlace:recentSession];
    [self.recentSessions insertObject:recentSession atIndex:insert];
    [self reload];
}

- (void)messagesDeletedInSession:(NIMSession *)session{
    _recentSessions = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    [self reload];
}

- (void)allMessagesDeleted{
    _recentSessions = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    [self reload];
}

#pragma mark - Override
- (void)onDeleteRecentAtIndexPath:(NIMRecentSession *)recent atIndexPath:(NSIndexPath *)indexPath{
    id<NIMConversationManager> manager = [[NIMSDK sharedSDK] conversationManager];
    [manager deleteAllmessagesInSession:recent.session removeRecentSession:NO];
    [manager deleteRecentSession:recent];
    //清理本地数据
    [self.recentSessions removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
//    //如果删除本地会话后就不允许漫游当前会话，则需要进行一次删除服务器会话的操作
//    if (self.autoRemoveRemoteSession)
//    {
//        [manager deleteRemoteSessions:@[recent.session]
//                           completion:nil];
//    }
}
//- (NSString *)nameForRecentSession:(NIMRecentSession *)recent{
//    if (recent.session.sessionType == NIMSessionTypeP2P) {
//        return [NIMKitUtil showNick:recent.session.sessionId inSession:recent.session];
//    }else{
//        NIMTeam *team = [[NIMSDK sharedSDK].teamManager teamById:recent.session.sessionId];
//        return team.teamName;
//    }
//}
//
//- (NSString *)contentForRecentSession:(NIMRecentSession *)recent{
//    return [self messageContent:recent.lastMessage];
//}
//
//- (NSString *)timestampDescriptionForRecentSession:(NIMRecentSession *)recent{
//    return [NIMKitUtil showTime:recent.lastMessage.timestamp showDetail:NO];
//}


#pragma mark - Misc
- (void)reload{
    if (!self.recentSessions.count) {
        self.tableView.hidden = YES;
    }else{
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}

- (NSInteger)findInsertPlace:(NIMRecentSession *)recentSession{
    __block NSUInteger matchIdx = 0;
    __block BOOL find = NO;
    [self.recentSessions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NIMRecentSession *item = obj;
        if (item.lastMessage.timestamp <= recentSession.lastMessage.timestamp) {
            *stop = YES;
            find  = YES;
            matchIdx = idx;
        }
    }];
    if (find) {
        return matchIdx;
    }else{
        return self.recentSessions.count;
    }
}

- (void)sort{
    [self.recentSessions sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NIMRecentSession *item1 = obj1;
        NIMRecentSession *item2 = obj2;
        if (item1.lastMessage.timestamp < item2.lastMessage.timestamp) {
            return NSOrderedDescending;
        }
        if (item1.lastMessage.timestamp > item2.lastMessage.timestamp) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

#pragma mark - Private
- (NSString*)messageContent:(NIMMessage*)lastMessage{
    NSString *text = @"";
    switch (lastMessage.messageType) {
        case NIMMessageTypeText:
            text = lastMessage.text;
            break;
        case NIMMessageTypeAudio:
            text = @"[语音]";
            break;
        case NIMMessageTypeImage:
            text = @"[图片]";
            break;
        case NIMMessageTypeVideo:
            text = @"[视频]";
            break;
        case NIMMessageTypeLocation:
            text = @"[位置]";
            break;
        case NIMMessageTypeNotification:{
//            return [self notificationMessageContent:lastMessage];
        }
        case NIMMessageTypeFile:
            text = @"[文件]";
            break;
        case NIMMessageTypeTip:
            text = lastMessage.text;
            break;
        default:
            text = @"[未知消息]";
    }
//    if (lastMessage.session.sessionType == NIMSessionTypeP2P || lastMessage.messageType == NIMMessageTypeTip) {
//        return text;
//    }else{
//        NSString *nickName = [NIMKitUtil showNick:lastMessage.from inSession:lastMessage.session];
//        return nickName.length ? [nickName stringByAppendingFormat:@" : %@",text] : @"";
//    }
    return text;
}

#pragma mark - setters and getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MYCOLOR_BackGroudColor;
        [_tableView registerClass:[ChatViewTableViewCell class] forCellReuseIdentifier:[ChatViewTableViewCell cellIdentifier]];
        self.tableView.tableFooterView  = [[UIView alloc] init];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
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
