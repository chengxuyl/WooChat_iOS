//
//  DialogueViewController.m
//  WooChat
//
//  Created by apple on 16/8/29.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "DialogueViewController.h"
#import "DialogueView.h"
#import "Masonry.h"
#import "DialogueModel.h"
#import "MyMessageViewCell.h"
#import "MyAudioTableViewCell.h"
#import "MyImageTableViewCell.h"
#import "OthersMessageViewCell.h"
#import "OtherAudioTableViewCell.h"
#import "OtherImageTableViewCell.h"
#import "NIMSDK.h"
#import "NIMMediaManagerProtocol.h"
#import "PhoViewController.h"
#import "PhoModel.h"
#import "FriendsInfoModel.h"
#import "NIMConversationManagerProtocol.h"
#import "ChatInfoViewController.h"
#import "ChatAudio2TextViewController.h"
#define weakify(var)   __weak typeof(var) weakSelf = var
#define strongify(var) __strong typeof(var) strongSelf = var
@interface DialogueViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,NIMChatManagerDelegate,NIMMediaManagerDelgate, MyAudioTableViewCellDelegate, OtherAudioTableViewCellDelegate>
@property UITableView *tableView;
@property NSMutableArray *dataSource;
@property DialogueView *dialogueV;
@property NSArray<NIMMessage *> *messages;
@property NSString *otherMobile;
@property NSString *playPath;
@property DialogueModel *modelForMenu;
//@property CGFloat tempVolume;
//当前语音录制时间
@property float currentTime;
@end

@implementation DialogueViewController
- (void)viewWillAppear:(BOOL)animated{
   [super viewWillAppear:animated];
   [self creatBackGround];
   //获取当前会员聊天记录
   [self getChatList];
   [self upDataCell];
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
   self.mod = [FriendsInfoModel new];
    [[[NIMSDK sharedSDK] chatManager] addDelegate:self];
   [[[NIMSDK sharedSDK] mediaManager] addDelegate:self];
    [self createPage];
    [super viewDidLoad];
      self.automaticallyAdjustsScrollViewInsets = NO;
   
   UIButton *more = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 24, 24)];
   [more setBackgroundImage:[UIImage imageNamed:@"我"] forState:UIControlStateNormal];
   UIBarButtonItem *RightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:more];
   self.navigationItem.rightBarButtonItem = RightBtnItem;
   [more addTarget:self action:@selector(rightPop:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightPop:(UIButton *)btn{
   ChatInfoViewController *vc = [ChatInfoViewController new];
   if (self.friendIn == YES) {
      vc.session = self.session;
   }else{
      vc.session = self.recent.session;
   }
   [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 获取历史记录
- (void)getChatList{
   _dataSource = [[NSMutableArray alloc]init];
   //获取当前会员聊天记录
   if (self.friendIn == YES) {
      self.messages =  [[[NIMSDK sharedSDK] conversationManager] messagesInSession:self.session
                                                                           message:nil
                                                                             limit:20];
      self.title = self.mod.nickName;
      //将消息设置为已读
      [[NIMSDK sharedSDK].conversationManager markAllMessagesReadInSession:self.session];
      [[NIMSDK sharedSDK].chatManager sendMessageReceipt:[[NIMMessageReceipt alloc] initWithMessage:[self.messages lastObject]] completion:nil];
      if (!self.messages.count) {
         self.mod.imId = self.session.sessionId;
      }
   }else{
      self.messages =  [[[NIMSDK sharedSDK] conversationManager] messagesInSession:self.recent.session
                                                                           message:nil
                                                                             limit:20];
      //将消息设置为已读
      [[NIMSDK sharedSDK].conversationManager markAllMessagesReadInSession:self.recent.session];
      [[NIMSDK sharedSDK].chatManager sendMessageReceipt:[[NIMMessageReceipt alloc] initWithMessage:[self.messages lastObject]] completion:^(NSError * _Nullable error) {
         NSLog(@"%@---发送已读回执error", error);
      }];
      FMDatabase *db = [FMDatabase databaseWithPath:[[UserInfo sharedInstance] dataBasePath]];
      [db open];
      self.title = [db stringForQuery:@"SELECT nickName FROM PersonList WHERE imId = ?",self.recent.session.sessionId];
      if (![db stringForQuery:@"SELECT nickName FROM PersonList WHERE imId = ?",self.recent.session.sessionId]) {
         self.title = [[NIMSDK sharedSDK].userManager userInfo:self.recent.session.sessionId].userInfo.nickName;
         if (self.messages.count != 0) {
            NIMMessage *firstMed = self.messages[0];
            
            if (![firstMed.from isEqualToString:[UserInfo sharedInstance].imId]) {
               self.otherMobile = [firstMed.remoteExt objectForKey:@"mobile"];
               [self.view addSubview:[self addFriendView]];
            }
         }
      }
      //      [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[db stringForQuery:@"SELECT icon FROM PersonList WHERE imId = ?",recent.session.sessionId]] placeholderImage:[UIImage imageNamed:@"chat"]] ;
      if (!self.messages.count) {
         NSString *imid = [db stringForQuery:@"SELECT imId FROM PersonList WHERE nickName = ?",self.title];
         self.mod.imId = imid;
      }
      [db close];
   }
}

#pragma mark - 更新cell
- (void)upDataCell{
   for (NIMMessage *message in self.messages) {
      if (![message.from isEqualToString:[UserInfo sharedInstance].imId]) {
         //         self.otherMobile = [message.remoteExt objectForKey:@"mobile"];
         //         NSLog(@"%@====from===%@===mobile===%@", [UserInfo sharedInstance].imId, message.from, [message.remoteExt objectForKey:@"mobile"]);
      }
      //表格视图刷新显示本条消息
      DialogueModel *model = [[DialogueModel alloc]init];
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
      [dateFormatter setDateFormat:@"HH:mm"];
      model.message = message;
      model.time = [dateFormatter stringFromDate:time];
      model.messageType = message.messageType;
      if (self.mod.imId.length == 0) {
         self.mod = [FriendsInfoModel new];
         self.mod.imId = message.session.sessionId;
      }
//      model.isPlay = message.isPlayed;
//      NSLog(@"%d---isplay", message.isPlayed);
      if (message.messageType == NIMMessageTypeText) {
         model.text = message.text;
      }else if (message.messageType == NIMMessageTypeImage){
         NIMImageObject *imageObject = [[NIMImageObject alloc]init];
         imageObject = (NIMImageObject *)message.messageObject;
         model.imagePath = imageObject.path;
         model.imageThumbPath = imageObject.thumbPath;
         //         model.imagePic =
      }else if (message.messageType == NIMMessageTypeAudio){
         NIMAudioObject *audioObject = [[NIMAudioObject alloc]init];
         audioObject = (NIMAudioObject *)message.messageObject;
         model.audioPath = audioObject.path;
         model.duration = audioObject.duration;
      }else if(message.messageType == NIMMessageTypeTip){
         model.text = message.text;
         if (!message.isOutgoingMsg) {
            FMDatabase *db = [[FMDatabase alloc] initWithPath:[UserInfo sharedInstance].dataBasePath];
            [db open];
            if (![db stringForQuery:@"SELECT nickName FROM PersonList WHERE mobile = ?",[message.remoteExt objectForKey:@"mobile"]]) {
               [self upDateDB];
            }
         }
      }
      
      if (message.isOutgoingMsg == YES) {
         model.isRead = message.isRemoteRead;
         model.myOrOther = @"my";
      }else{
         model.myOrOther = @"other";
      }
      
      [_dataSource addObject:model];
   }
   [self reloadTableView];
}

- (UIView *)addFriendView{
   UIView *addview = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
   addview.backgroundColor = [UIColor whiteColor];
   CustomdBtn *addFriendBtn = [CustomdBtn buttonWithType:(UIButtonTypeCustom)];
//   addFriendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
   [addFriendBtn setImage:[UIImage imageNamed:@"accept_d"] forState:(UIControlStateNormal)];
   [addFriendBtn setTitle:@"接受" forState:(UIControlStateNormal)];
   [addFriendBtn setTitleColor:MYCOLOR_GRAY forState:(UIControlStateNormal)];
   addFriendBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, addview.height);
   addFriendBtn.layer.borderColor = MYCOLOR_GRAY.CGColor;
   addFriendBtn.layer.borderWidth = 0.5;
   [addview addSubview:addFriendBtn];
   [addFriendBtn addTarget:self action:@selector(addFriendBtn:) forControlEvents:(UIControlEventTouchUpInside)];
   CustomdBtn *noFriendBtn = [CustomdBtn buttonWithType:(UIButtonTypeCustom)];
   [noFriendBtn setImage:[UIImage imageNamed:@"refuse_d"] forState:(UIControlStateNormal)];
   [noFriendBtn setTitle:@"拒绝" forState:(UIControlStateNormal)];
   [noFriendBtn setTitleColor:MYCOLOR_GRAY forState:(UIControlStateNormal)];
   noFriendBtn.frame = CGRectMake(addFriendBtn.right, 0, SCREEN_WIDTH/3, addview.height);
   noFriendBtn.layer.borderColor = MYCOLOR_GRAY.CGColor;
   noFriendBtn.layer.borderWidth = 0.5;
   [addview addSubview:noFriendBtn];
   CustomdBtn *complainBtn = [CustomdBtn buttonWithType:(UIButtonTypeCustom)];
   [complainBtn setImage:[UIImage imageNamed:@"complaints_d"] forState:(UIControlStateNormal)];
   [complainBtn setTitle:@"举报" forState:(UIControlStateNormal)];
   [complainBtn setTitleColor:MYCOLOR_GRAY forState:(UIControlStateNormal)];
   complainBtn.frame = CGRectMake(noFriendBtn.right, 0, SCREEN_WIDTH/3, addview.height);
   complainBtn.layer.borderColor = MYCOLOR_GRAY.CGColor;
   complainBtn.layer.borderWidth = 0.5;
   [addview addSubview:complainBtn];
   addview.layer.borderColor = MYCOLOR_GRAY.CGColor;
   addview.layer.borderWidth = 0.5;
   return addview;
}

#pragma mark - 添加好友 / 拒绝 / 投诉
- (void)addFriendBtn:(UIButton *)btn{
   
   
   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
   [dic setObject:[UserInfo sharedInstance].mobile forKey:@"smobile"];
   [dic setObject:self.otherMobile forKey:@"tmobile"];
   [dic setObject:@"1" forKey:@"type"];
   [dic setObject:@"star" forKey:@"0"];
   [[ServerAPI sharedAPI] serverPostWithName:@"friendsUpdate" WithDic:dic completion:^(NSDictionary *resultDict) {
      if ([[resultDict objectForKey:@"code"] isEqualToString:@"200"]) {
         //构造消息
         NIMTipObject *tip = [[NIMTipObject alloc] init];
         NIMMessage *message = [[NIMMessage alloc] init];
         message.remoteExt = @{@"mobile": [UserInfo sharedInstance].mobile};
         message.timestamp = [[NSDate date] timeIntervalSince1970];
         NSString *IMid = [NSString new];
         IMid = self.mod.imId;
         message.text = @"我通过了你的朋友验证请求,现在我们可以开始聊天了";
         message.messageObject = tip;
         //构造会话
         NIMSession *session = [NIMSession session:IMid type:NIMSessionTypeP2P];
         
         //发送消息
         [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
         [self upDateDB];
         NSLog(@"%@---添加好友----%@--dic", resultDict, dic);
         [[self addFriendView] removeFromSuperview];
      }
   }];
}

//-(void)viewDidAppear:(BOOL)animated{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationDelay:0];
//    
//    self.navigationController.navigationBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
//   
//    [UIView commitAnimations];
//}
#pragma mark - 创建页面
//创建页面
- (void)createPage{
   
   [self createTableView];
   
   _dialogueV = [[DialogueView alloc]init];
   [self.view addSubview:_dialogueV.iconView];
   _dialogueV.iconView.tag = 1;
   _dialogueV.voiceBtn.tag = 2;
   _dialogueV.textView.delegate = self;
   [_dialogueV.changeBtn1 addTarget:self action:@selector(changeBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
   [_dialogueV.changeBtn2 addTarget:self action:@selector(changeBtn2Click:) forControlEvents:UIControlEventTouchUpInside];
   _dialogueV.changeBtn2.tag = 3;
   [_dialogueV.SendBtn addTarget:self action:@selector(sendOnClick) forControlEvents:UIControlEventTouchUpInside];
   _dialogueV.textView.tag = 4;
   [_dialogueV.voiceBtn addTarget:self action:@selector(voiceTouchDown) forControlEvents:UIControlEventTouchDown];
   [_dialogueV.voiceBtn addTarget:self action:@selector(voiceTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
   [_dialogueV.voiceBtn addTarget:self action:@selector(voiceTouchDragExit) forControlEvents:UIControlEventTouchDragExit];
   [_dialogueV.voiceBtn addTarget:self action:@selector(voiceTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
   [_dialogueV.PicBtn addTarget:self action:@selector(PicBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
//图片按钮点击事件
- (void)PicBtnClick{
   PhoViewController *pho = [[PhoViewController alloc]init];
   
   CATransition *animation = [CATransition animation];
   [animation setDuration:0.5];
   [animation setType: kCATransitionPush];
   [animation setSubtype: kCATransitionFromTop];//跳转方向样式
   [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
   
   [self.navigationController pushViewController:pho animated:NO];//禁止导航动画
   [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
}
#pragma mark - 表格视图
//创建表格视图
- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT/13 - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
   
    
   [_tableView registerNib:[UINib nibWithNibName:@"MyMessageViewCell" bundle:nil] forCellReuseIdentifier:@"MyMessageViewCell"];
   [_tableView registerNib:[UINib nibWithNibName:@"MyAudioTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyAudioTableViewCell"];
   [_tableView registerNib:[UINib nibWithNibName:@"MyImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyImageTableViewCell"];
   [_tableView registerNib:[UINib nibWithNibName:@"OthersMessageViewCell" bundle:nil] forCellReuseIdentifier:@"OthersMessageViewCell"];
   [_tableView registerNib:[UINib nibWithNibName:@"OtherAudioTableViewCell" bundle:nil] forCellReuseIdentifier:@"OtherAudioTableViewCell"];
   [_tableView registerNib:[UINib nibWithNibName:@"OtherImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"OtherImageTableViewCell"];
    _tableView.separatorStyle =NO;
   [self creatBackGround];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 50.0;
   
   
   [self.view addSubview:_tableView];
   [self reloadTableView];
}

- (void)creatBackGround{
   //设置聊天背景
   FMDatabase *db = [[FMDatabase alloc] initWithPath:[UserInfo sharedInstance].dataBasePath];
   [db open];
   NSString *imId;
   if (self.friendIn == YES) {
      imId = self.session.sessionId;
   }else{
      imId = self.recent.session.sessionId;
   }
   NSString *chatBackGround = [db stringForQuery:@"SELECT chatBackGround FROM PersonList WHERE imId = ?",imId];
   if ([db stringForQuery:@"SELECT chatBackGround FROM PersonList WHERE imId = ?",imId]) {
//      chatBackGround = [chatBackGround stringByReplacingCharactersInRange:NSMakeRange(4, 2) withString:@""];
      UIImageView* bgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:chatBackGround]];
      bgview.frame = self.view.bounds;
      [self.tableView setBackgroundView:bgview];
   }
   [db close];
}
-(void)reloadTableView{
   [self.tableView reloadData];
   dispatch_async(dispatch_get_main_queue(), ^{
      if (_dataSource.count) {
         NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_dataSource.count-1 inSection:0];
         [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:NO];
      }
   });
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell *cell = [[UITableViewCell alloc]init];
   DialogueModel *model = [[DialogueModel alloc]init];
   DialogueModel *model1 = [[DialogueModel alloc]init];
   
   model = _dataSource[indexPath.row];
      
   switch (model.messageType) {
      case NIMMessageTypeTip:{
         if ([model.myOrOther isEqualToString:@"my"]) {
            MyMessageViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"MyMessageViewCell" forIndexPath:indexPath];
            myCell.model = model;
            myCell.messageLabel.text = model.text;
            if (indexPath.row-1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [myCell removeTime];
               }else
                  myCell.timeLabel.text = model.time;
            }else
               myCell.timeLabel.text = model.time;
            cell = myCell;
         }else{
            OthersMessageViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"OthersMessageViewCell" forIndexPath:indexPath];
            otherCell.model = model;
            otherCell.messageLabel.text = model.text;
            if (indexPath.row -1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [otherCell removeTime];
               }else
                  otherCell.timeLabel.text = model.time;
            }else
               otherCell.timeLabel.text = model.time;
            cell = otherCell;
         }
      }
         break;
         /**
          *    消息类型:信息型
          *           如果数据源上一条信息的时间与本条时间相同，移除时间labal
          *           属性包括
          *                   时间 & 信息
          **/
      case NIMMessageTypeText:{
         
         if ([model.myOrOther isEqualToString:@"my"]) {
            MyMessageViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"MyMessageViewCell" forIndexPath:indexPath];
            myCell.model = model;
            myCell.fly.alpha = 1.0;
            if (model.isRead == YES) {
               myCell.fly.image = [UIImage imageNamed:@"butterfly_fly_01"];
            }else{
               myCell.fly.image = [UIImage imageNamed:@"butterfly_stand"];
            }
            myCell.messageLabel.text = model.text;
            if (indexPath.row-1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [myCell removeTime];
               }else
                  myCell.timeLabel.text = model.time;
            }else
               myCell.timeLabel.text = model.time;
            cell = myCell;
         }else{
            OthersMessageViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"OthersMessageViewCell" forIndexPath:indexPath];
            otherCell.model = model;
            otherCell.messageLabel.text = model.text;
            if (indexPath.row -1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [otherCell removeTime];
               }else
                  otherCell.timeLabel.text = model.time;
            }else
               otherCell.timeLabel.text = model.time;
            cell = otherCell;
         }
      }
         break;
         /**
          *    消息类型:语音型
          *           如果数据源上一条信息的时间与本条时间相同，移除时间labal
          *           属性包括
          *                   时间 & 语音路径 & 语音时长
          *                                   语音时长 = 秒数取1拼接空格
          **/
      case NIMMessageTypeAudio:{
         
         if ([model.myOrOther isEqualToString:@"my"]) {
            MyAudioTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"MyAudioTableViewCell" forIndexPath:indexPath];
            myCell.mod = model;
            myCell.delegate = self;
            myCell.duration = model.duration;
            myCell.audioPath = model.audioPath;
            myCell.fly.alpha = 1.0;
            if (model.isRead == YES) {
               myCell.fly.image = [UIImage imageNamed:@"butterfly_fly_01"];
            }else{
               myCell.fly.image = [UIImage imageNamed:@"butterfly_stand"];
            }
            int time =(int)myCell.duration/1000;
            if (time == 0) {
               time = 1;
            }
            myCell.second.text = [NSString stringWithFormat:@"%d\"",time];
            for (int i = 1; i < time; i++) {
               myCell.second.text =  [NSString stringWithFormat:@"%@%@",myCell.second.text,@" "];
            }
            if (indexPath.row-1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [myCell removeTime];
               }else
                  myCell.timeLabel.text = model.time;
            }else
               myCell.timeLabel.text = model.time;
            cell = myCell;
         }else{
            OtherAudioTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"OtherAudioTableViewCell" forIndexPath:indexPath];
            otherCell.mod = model;
            otherCell.delegate = self;
            otherCell.audioPath = model.audioPath;
            otherCell.duration = model.duration;
            otherCell.isPlay.hidden = YES;
            int time =(int)otherCell.duration/1000;
            if (time == 0) {
               time = 1;
            }
            otherCell.second.text = [NSString stringWithFormat:@"%d\"",time];
            for (int i = 1; i < time; i++) {
               otherCell.second.text =  [NSString stringWithFormat:@"%@%@",otherCell.second.text,@" "];
            }
            if (indexPath.row -1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [otherCell removeTime];
               }else
                  otherCell.timeLabel.text = model.time;
            }else
               otherCell.timeLabel.text = model.time;
            cell = otherCell;
         }
      }
         break;
         /**
          *    消息类型:图片型
          *           如果数据源上一条信息的时间与本条时间相同，移除时间labal
          *           属性包括
          *                   时间 & 图片路径 & 略缩图路径
          **/
      case NIMMessageTypeImage:{
         
         if ([model.myOrOther isEqualToString:@"my"]) {
            MyImageTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"MyImageTableViewCell" forIndexPath:indexPath];
            myCell.model = model;
            myCell.fly.alpha = 1.0;
            if (model.isRead == YES) {
               myCell.fly.image = [UIImage imageNamed:@"butterfly_fly_01"];
            }else{
               myCell.fly.image = [UIImage imageNamed:@"butterfly_stand"];
            }
            myCell.path = model.imagePath;
//            myCell.MessageImage.image = model.imagePic;
            [myCell.MessageImage setImage:[UIImage imageWithContentsOfFile:model.imageThumbPath]];
            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(Tap:)];
            [myCell.MessageImage addGestureRecognizer:Tap];
            myCell.MessageImage.userInteractionEnabled = YES;
            if (indexPath.row-1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [myCell removeTime];
               }else
                  myCell.timeLabel.text = model.time;
            }else
               myCell.timeLabel.text = model.time;
            cell = myCell;
         }else{
            OtherImageTableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"OtherImageTableViewCell" forIndexPath:indexPath];
            otherCell.model = model;
            otherCell.path = model.imagePath;
//            otherCell.MessageImage.image = model.imagePic;
            [otherCell.MessageImage setImage:[UIImage imageWithContentsOfFile:model.imageThumbPath]];
            otherCell.MessageImage.userInteractionEnabled = YES;
            if (indexPath.row -1 >= 0) {
               model1 = _dataSource[indexPath.row-1];
               if ([model1.time isEqualToString:model.time]) {
                  [otherCell removeTime];
               }else
                  otherCell.timeLabel.text = model.time;
            }else
               otherCell.timeLabel.text = model.time;
            cell = otherCell;
         }
      }
         break;
      default:
         break;
   }
   cell.backgroundColor = [UIColor clearColor];
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
   [cell setNeedsUpdateConstraints];
   [cell updateConstraintsIfNeeded];
   UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCell:)];
   [cell addGestureRecognizer:longPress];
   cell.userInteractionEnabled = YES;
   return cell;
}

#pragma mark - Action-UIMenuController
- (void)longPressCell:(UILongPressGestureRecognizer *)longPress{
   
   if ([longPress state] == UIGestureRecognizerStateBegan) {
      //文字
      if ([longPress.view isKindOfClass:[MyMessageViewCell class]]) {
         MyMessageViewCell *cell = (MyMessageViewCell *)longPress.view;
         self.modelForMenu = cell.model;
         NSMutableArray *items = [NSMutableArray array];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"复制"
                                                     action:@selector(copyText:)]];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"转发"
                                                     action:@selector(transmitMsg:)]];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"收藏"
                                                     action:@selector(collectMsg:)]];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回"
                                                     action:@selector(recallMsg:)]];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除"
                                                     action:@selector(deleteMsg:)]];
         if ([items count] && [self becomeFirstResponder]) {
            UIMenuController *controller = [UIMenuController sharedMenuController];
            controller.menuItems = items;
            
            [controller setTargetRect:cell.MessageLabelBKImage.bounds inView:cell.MessageLabelBKImage];
            [controller setMenuVisible:YES animated:YES];
            [controller update];
         }
      }else if ([longPress.view isKindOfClass:[MyAudioTableViewCell class]]){
         //语音
         if ([longPress.view isKindOfClass:[MyAudioTableViewCell class]]) {
            MyAudioTableViewCell *cell = (MyAudioTableViewCell *)longPress.view;
            self.modelForMenu = cell.mod;
            NSMutableArray *items = [NSMutableArray array];
            [items addObject:[[UIMenuItem alloc] initWithTitle:@"转文字"
                                                        action:@selector(audio2Text:)]];
            [items addObject:[[UIMenuItem alloc] initWithTitle:@"收藏"
                                                        action:@selector(collectMsg:)]];
            [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回"
                                                        action:@selector(recallMsg:)]];
            [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除"
                                                        action:@selector(deleteMsg:)]];
            if ([items count] && [self becomeFirstResponder]) {
               UIMenuController *controller = [UIMenuController sharedMenuController];
               controller.menuItems = items;
               [controller setTargetRect:cell.messageBKImage.bounds inView:cell.messageBKImage];
               [controller setMenuVisible:YES animated:YES];
               [controller update];
            }
         }
      }else if ([longPress.view isKindOfClass:[MyImageTableViewCell class]]) {
         MyImageTableViewCell *cell = (MyImageTableViewCell *)longPress.view;
         self.modelForMenu = cell.model;
         NSMutableArray *items = [NSMutableArray array];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"转发"
                                                     action:@selector(transmitMsg:)]];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"收藏"
                                                     action:@selector(collectMsg:)]];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"撤回"
                                                     action:@selector(recallMsg:)]];
         [items addObject:[[UIMenuItem alloc] initWithTitle:@"删除"
                                                     action:@selector(deleteMsg:)]];
         if ([items count] && [self becomeFirstResponder]) {
            UIMenuController *controller = [UIMenuController sharedMenuController];
            controller.menuItems = items;
            
            [controller setTargetRect:cell.MessageImage.bounds inView:cell.MessageImage];
            [controller setMenuVisible:YES animated:YES];
            [controller update];
         }
      }
   }
}
- (void)audio2Text:(UIMenuItem *)item{
   ChatAudio2TextViewController *vc = [ChatAudio2TextViewController new];
   vc.message = self.modelForMenu.message;
   [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
   [self presentViewController:vc
                      animated:YES
                    completion:nil];
}

- (void)copyText:(UIMenuItem *)item{
   UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
   pasteboard.string = self.modelForMenu.message.text;
}

- (void)deleteMsg:(UIMenuItem *)item{
   [self.dataSource removeObject:self.modelForMenu];
   [self reloadTableView];
   [[NIMSDK sharedSDK].conversationManager deleteMessage:self.modelForMenu.message];
}
- (void)recallMsg:(UIMenuItem *)item{
   [[NIMSDK sharedSDK].chatManager revokeMessage:self.modelForMenu.message completion:^(NSError * _Nullable error) {
      if (error) {
         if (error.code == NIMRemoteErrorCodeDomainExpireOld) {
            [ViewFactory alertViewShowWithTitle:@"提示" message:@"发送时间超过2分钟的消息，不能被撤回"];

         }else{
            [ViewFactory alertViewShowWithTitle:@"提示" message:@"消息撤回失败，请重试"];
         }
      }
      else
      {
         [self.dataSource removeObject:self.modelForMenu];
         [self reloadTableView];
         NSLog(@"撤回");
//         NIMMessageModel *model = [self uiDeleteMessage:message];
//         NIMMessage *tip = [NTESSessionMsgConverter msgWithTip:[NTESSessionUtil tipOnMessageRevoked:message]];
//         tip.timestamp = model.messageTime;
//         [self uiAddMessages:@[tip]];
         
//         tip.timestamp = message.timestamp;
         // saveMessage 方法执行成功后会触发 onRecvMessages: 回调，但是这个回调上来的 NIMMessage 时间为服务器时间，和界面上的时间有一定出入，所以要提前先在界面上插入一个和被删消息的界面时间相符的 Tip, 当触发 onRecvMessages: 回调时，组件判断这条消息已经被插入过了，就会忽略掉。
//         [[NIMSDK sharedSDK].conversationManager saveMessage:tip forSession:message.session completion:nil];
      }
   }];
}
- (void)collectMsg:(UIMenuItem *)item{
   NSLog(@"收藏");
}
- (void)transmitMsg:(UIMenuItem *)item{
   NSLog(@"转发");
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
   if (!self.modelForMenu) {
      return NO;
   }
   return [super canPerformAction:action withSender:sender];
}

-(BOOL)canBecomeFirstResponder
{
   return YES;
}

#pragma mark - My / Other AudioTableViewCellDelegate
- (void)myAudioTableViewCellTapWithCell:(MyAudioTableViewCell *)tableViewCell{
   if ([self.playPath isEqualToString:tableViewCell.mod.audioPath]) {
      [[NIMSDK sharedSDK].mediaManager stopPlay];
   }else{
      
      [[NIMSDK sharedSDK].mediaManager switchAudioOutputDevice:NIMAudioOutputDeviceSpeaker];
//      [[NIMSDK sharedSDK].mediaManager playAudio:tableViewCell.mod.audioPath withDelegate:self];
      [[NIMSDK sharedSDK].mediaManager play:tableViewCell.mod.audioPath];
      if ([[NIMSDK sharedSDK].mediaManager isPlaying]) {
         [tableViewCell.soundImage startAnimating];
         self.AudioDone = ^(){
            [tableViewCell.soundImage stopAnimating];
         };
      }
   }
}

- (void)otherAudioTableViewCellTapWithCell:(OtherAudioTableViewCell *)tableViewCell{
   if ([self.playPath isEqualToString:tableViewCell.mod.audioPath]) {
      [[NIMSDK sharedSDK].mediaManager stopPlay];
   }else{
      
      [[NIMSDK sharedSDK].mediaManager switchAudioOutputDevice:NIMAudioOutputDeviceSpeaker];
//      [[NIMSDK sharedSDK].mediaManager playAudio:tableViewCell.mod.audioPath withDelegate:self];
      [[NIMSDK sharedSDK].mediaManager play:tableViewCell.mod.audioPath];
      if ([[NIMSDK sharedSDK].mediaManager isPlaying]) {
         [tableViewCell.soundImage startAnimating];
         self.AudioDone = ^(){
            [tableViewCell.soundImage stopAnimating];
         };
      }
   }
}

#pragma mark - NIMMediaManagerDelgate
- (void)playAudio:(NSString *)filePath didBeganWithError:(NSError *)error{
   self.playPath = filePath;
}

- (void)playAudio:(NSString *)filePath didCompletedWithError:(nullable NSError *)error{
   self.AudioDone();
   self.playPath = @"";
   NSLog(@"播完了");
}

/** 图片cell点击手势 */
- (void)Tap:(UITapGestureRecognizer *)tap{
   NSLog(@"点击图片");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**  
     *   如果tableview被拖动
     *   放弃响应 +&-号按钮复位 tableview视图复位
     */
    if (scrollView == _tableView) {
        UIView *view = [self.view viewWithTag:1];
        view.frame = CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/13, SCREEN_WIDTH, SCREEN_HEIGHT/2.6);
        UIButton *btn = [self.view viewWithTag:3];
        btn.selected = NO;
        _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT/13 - 64);
        [self.view endEditing:YES];
    }
}
#pragma mark - 语音录制 & 发送
//语音按钮按下
-(void)voiceTouchDown{
   [[[NIMSDK sharedSDK] mediaManager] record:NIMAudioTypeAAC duration:60.0f];

   [self.view addSubview:_dialogueV.stateView];

   [_dialogueV.stateView addSubview:_dialogueV.microView];
   [_dialogueV.stateView addSubview:_dialogueV.volumeView];
   [_dialogueV.stateView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self.view);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, SCREEN_WIDTH/3));
   }];
   [_dialogueV.microView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_dialogueV.stateView).with.offset(20);
            make.left.equalTo(_dialogueV.stateView).with.offset(15);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/10, SCREEN_WIDTH/3-40));
   }];
   [_dialogueV.volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(_dialogueV.microView).with.offset(0);
      make.left.equalTo(_dialogueV.microView).with.offset(SCREEN_WIDTH/10 +15);
      make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/10, SCREEN_WIDTH/3-40));
   }];
   
   
   //语音输入状态图片
//   @property UIImageView *stateView;
//   //语音输入取消图片
//   @property UIImageView *cancleView;
//   //语音输入失败图片
//   @property UIImageView *tooshotView;
//   //语音正在输入图片
//   @property UIImageView *microView;
}
//语音按钮抬起
-(void)voiceTouchUpInside{
   [[[NIMSDK sharedSDK] mediaManager] stopRecord];
   [_dialogueV.stateView removeFromSuperview];
}

//录音时长
- (void)recordAudioProgress:(NSTimeInterval)currentTime{
   _currentTime = currentTime;
//   NSLog(@"%f-----loud", [[NIMSDK sharedSDK].mediaManager recordPeakPower]);
//   if ([[NIMSDK sharedSDK].mediaManager recordPeakPower] > self.tempVolume) {
//      NSLog(@"声音大了");
//   }else{
//      NSLog(@"声音小了");
//   }
   CGFloat volume = [[NIMSDK sharedSDK].mediaManager recordPeakPower];
   if (volume>= -10) {
      _dialogueV.volumeView.image = [UIImage imageNamed:@"volume_6"];
   }else if (volume>= -20 && volume < -10){
      _dialogueV.volumeView.image = [UIImage imageNamed:@"volume_5"];
   }else if (volume>= -30 && volume < -20){
      _dialogueV.volumeView.image = [UIImage imageNamed:@"volume_4"];
   }else if (volume>= -40 && volume < -30){
      _dialogueV.volumeView.image = [UIImage imageNamed:@"volume_3"];
   }else if (volume>= -50 && volume < -40){
      _dialogueV.volumeView.image = [UIImage imageNamed:@"volume_2"];
   }else if (volume < -50){
      _dialogueV.volumeView.image = [UIImage imageNamed:@"volume_1"];
   }
}
//语音录制停止时会触发
- (void)recordAudio:(NSString *)filePath didCompletedWithError:(NSError *)error{
   
   if (_currentTime < 0.5) {
      NSLog(@"11111111111111111111111");
   }
   
   NIMAudioObject *audioObject = [[NIMAudioObject alloc] initWithSourcePath:filePath];
   NIMMessage *message        = [[NIMMessage alloc] init];
   message.messageObject      = audioObject;
   message.timestamp = [[NSDate date] timeIntervalSince1970];
   message.remoteExt = @{@"mobile": [UserInfo sharedInstance].mobile};
   NSString *IMid = [NSString new];
//   if ([[NIMSDK sharedSDK].loginManager.currentAccount isEqualToString:@"d733835b1045482da5179a755e99cda8"]){
//      IMid = @"19b2823c7e634bbc892e3833e5a8f004";
//   }else
//      IMid = @"d733835b1045482da5179a755e99cda8";
   IMid = self.mod.imId;
   
   //构造会话
   NIMSession *session = [NIMSession session:IMid type:NIMSessionTypeP2P];
   //发送消息
   [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
   
   //表格视图刷新显示本条消息
   DialogueModel *model = [[DialogueModel alloc]init];
   model.message = message;
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
   [dateFormatter setDateFormat:@"HH:mm"];
   model.time = [dateFormatter stringFromDate:time];
   model.messageType = NIMMessageTypeAudio;
   model.duration = audioObject.duration;
   model.audioPath = audioObject.path;
   model.myOrOther = @"my";
//   NSLog(@"-------%@",model.audioPath);
   [_dataSource addObject:model];
   
   [self reloadTableView];
}


//语音按钮上滑取消录制?
-(void)voiceTouchDragExit{
   NSLog(@"上华取消录音？");
}
//语音按钮上滑取消录制!
-(void)voiceTouchUpOutside{
   NSLog(@"取消录音!");
   [[[NIMSDK sharedSDK] mediaManager] cancelRecord];
   [_dialogueV.stateView removeFromSuperview];
}
//取消录音会触发
- (void)recordAudioDidCancelled{}
- (void)fetchMessageAttachment:(NIMMessage *)message
          didCompleteWithError:(NSError *)error{
   NSLog(@"接收完成   错误---%@",error);
}
- (void)willSendMessage:(NIMMessage *)message{
   NSLog(@"即将发送---");
}
- (void)sendMessage:(NIMMessage *)message
didCompleteWithError:(NSError *)error{
   NSLog(@"%@--error",error);
}
#pragma mark - 图片发送
- (void)ImageSend:(UIImage *)sendImage{
   
   //构造消息
   NIMImageObject * imageObject = [[NIMImageObject alloc] initWithImage:sendImage];
   NIMMessage *message          = [[NIMMessage alloc] init];
   message.messageObject        = imageObject;
   message.remoteExt = @{@"mobile": [UserInfo sharedInstance].mobile};
   NSString *IMid = [NSString new];
   IMid = self.mod.imId;
//   if ([[NIMSDK sharedSDK].loginManager.currentAccount isEqualToString:@"d733835b1045482da5179a755e99cda8"]){
//      IMid = @"19b2823c7e634bbc892e3833e5a8f004";
//   }else
//      IMid = @"d733835b1045482da5179a755e99cda8";
   //构造会话
   NIMSession *session = [NIMSession session:IMid type:NIMSessionTypeP2P];
   
   //发送消息
   [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];

   //表格视图刷新显示本条消息
   DialogueModel *model = [[DialogueModel alloc]init];
   model.message = message;
   model.imagePath = imageObject.path;
   model.imagePic = sendImage;
   model.messageType = NIMMessageTypeImage;
   model.imageThumbPath = imageObject.thumbPath;
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
   [dateFormatter setDateFormat:@"HH:mm"];
   model.time = [dateFormatter stringFromDate:time];
   model.myOrOther = @"my";
   [_dataSource addObject:model];
   [self reloadTableView];
}
#pragma mark - 消息发送
//发送消息按钮点击事件
- (void)sendOnClick{
   UITextView *textView = [self.view viewWithTag:4];
   NIMMessage *message = [[NIMMessage alloc] init];
   message.remoteExt = @{@"mobile": [UserInfo sharedInstance].mobile};
   message.text = textView.text;
   message.timestamp = [[NSDate date] timeIntervalSince1970];
   textView.text = @"";
   
   NSString *IMid = [NSString new];
   IMid = self.mod.imId;

   //构造会话
   NIMSession *session = [NIMSession session:IMid type:NIMSessionTypeP2P];
   
   //发送消息
   [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:nil];
   
   //表格视图刷新显示本条消息
   DialogueModel *model = [[DialogueModel alloc]init];
   model.message = message;
   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
   [dateFormatter setDateFormat:@"HH:mm"];
   model.time = [dateFormatter stringFromDate:time];
   model.messageType = NIMMessageTypeText;
   model.text = message.text;
   model.myOrOther = @"my";
   
   [_dataSource addObject:model];
   [self reloadTableView];
}
#pragma mark - 已读回执
- (void)onRecvMessageReceipt:(NIMMessageReceipt *)receipt{
   if ([receipt.session.sessionId isEqualToString:self.mod.imId]) {
   if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count -1 inSection:0]] class] == [MyMessageViewCell class]) {
      MyMessageViewCell *myCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count -1 inSection:0]];
      [myCell.fly startAnimating];
      [UIView animateWithDuration:2 animations:^{
//         myCell.fly.frame = CGRectMake(-42, myCell.fly.y, myCell.fly.width, myCell.fly.height);
         myCell.fly.frame = CGRectOffset(myCell.fly.frame, -200, -30);
         myCell.fly.alpha = 0;
         
      }];
   }else if([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count -1 inSection:0]] class] == [MyAudioTableViewCell class]){
      MyAudioTableViewCell *myCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count -1 inSection:0]];
      [myCell.fly startAnimating];
      [UIView animateWithDuration:2 animations:^{
//         myCell.fly.frame = CGRectMake(-42, myCell.fly.y, myCell.fly.width, myCell.fly.height);
         myCell.fly.frame = CGRectOffset(myCell.fly.frame, -200, -30);
         myCell.fly.alpha = 0;
      }];
   }else if([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count -1 inSection:0]] class] == [MyImageTableViewCell class]){
      MyImageTableViewCell *myCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count -1 inSection:0]];
      [myCell.fly startAnimating];
      [UIView animateWithDuration:2 animations:^{
//         myCell.fly.frame = CGRectMake(-42, myCell.fly.y, myCell.fly.width, myCell.fly.height);
         myCell.fly.frame = CGRectOffset(myCell.fly.frame, -200, -30);
         myCell.fly.alpha = 0;
      }];
   }
   for (DialogueModel *mod in self.dataSource) {
      [mod setIsRead:YES];
   }}
   
}
#pragma mark - 消息接收
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages{
   [[NIMSDK sharedSDK].conversationManager markAllMessagesReadInSession:[messages lastObject].session];
   [[NIMSDK sharedSDK].chatManager sendMessageReceipt:[[NIMMessageReceipt alloc] initWithMessage:[messages lastObject]] completion:nil];
   for (NIMMessage *message in messages) {
      if ([message.session.sessionId isEqualToString:self.mod.imId]) {
      DialogueModel *model = [[DialogueModel alloc]init];
      model.message = message;
      switch (message.messageType) {
         case NIMMessageTypeText:{
            model.text = message.text;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
            [dateFormatter setDateFormat:@"HH:mm"];
            model.time = [dateFormatter stringFromDate:time];
            model.messageType = NIMMessageTypeText;
            model.myOrOther = @"other";
            [_dataSource addObject:model];
            [self reloadTableView];
         }
         break;
         case NIMMessageTypeAudio:{
            NIMAudioObject *audioObject = [[NIMAudioObject alloc]init];
            audioObject = (NIMAudioObject *)message.messageObject;
            model.audioPath = audioObject.path;
            model.duration = audioObject.duration;
            model.messageType = NIMMessageTypeAudio;

            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
            [dateFormatter setDateFormat:@"HH:mm"];
            model.time = [dateFormatter stringFromDate:time];
            model.myOrOther = @"other";
            [_dataSource addObject:model];
            [self reloadTableView];
            
         }
               break;
         case NIMMessageTypeImage:{
            NIMImageObject *imageObject = [[NIMImageObject alloc]init];
            imageObject = (NIMImageObject *)message.messageObject;
            model.imagePath = imageObject.path;
            model.imageThumbPath = imageObject.thumbPath;
            model.messageType = NIMMessageTypeImage;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
            [dateFormatter setDateFormat:@"HH:mm"];
            model.time = [dateFormatter stringFromDate:time];
            model.myOrOther = @"other";
            [_dataSource addObject:model];
            [self reloadTableView];
         }
            break;
         case NIMMessageTypeTip:{
            NIMTipObject *tip = [[NIMTipObject alloc]init];
            tip = (NIMTipObject *)message.messageObject;
            model.text = message.text;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *time = [NSDate dateWithTimeIntervalSince1970:message.timestamp];
            [dateFormatter setDateFormat:@"HH:mm"];
            model.time = [dateFormatter stringFromDate:time];
            model.messageType = NIMMessageTypeText;
            model.myOrOther = @"other";
            [_dataSource addObject:model];
            [self upDateDB];
            [self reloadTableView];
            
         }
            break;
         default:
               break;
      }}
   }
}

#pragma mark - 更新数据库
- (void)upDateDB{
   [[ServerAPI sharedAPI] serverPostWithName:@"memberInfo" WithDic:@{@"mobile":self.otherMobile}.mutableCopy completion:^(NSDictionary *resultDict) {
      FMDatabase *db = [[FMDatabase alloc] initWithPath:[UserInfo sharedInstance].dataBasePath];
      [db open];
      //插入资料
      [db executeUpdate:@"INSERT INTO PersonList (nickName, mobile, imId, icon) VALUES (?,?,?,?)",
       [resultDict objectForKey:@"nickName"], [resultDict objectForKey:@"mobile"], [resultDict objectForKey:@"imId"], [resultDict objectForKey:@"icon"]];
      [db close];
   }];
}

#pragma mark - 点击事件
//语音&输入按钮点击事件
- (void)changeBtn1Click:(UIButton *)btn{
   
    UIButton *voiceBtn = [self.view viewWithTag:2];
    if (btn.selected == NO) {
        //按住说话按钮frame更改
        voiceBtn.frame = CGRectMake(0, SCREEN_HEIGHT-SCREEN_HEIGHT/2.6, 0, 0);
        btn.selected = YES;
    }else{
        //按住说话按钮frame复原
        voiceBtn.frame = CGRectMake(SCREEN_WIDTH/4.5, SCREEN_HEIGHT/150, SCREEN_WIDTH/1.3, SCREEN_HEIGHT/15.5);
        btn.selected = NO;
    }
    [self.view endEditing:YES];
}
//+&-按钮点击事件
- (void)changeBtn2Click:(UIButton *)btn{
    UIView *view = [self.view viewWithTag:1];
    if (btn.selected == NO) {
        //下方操作视图上移
        view.frame = CGRectMake(0, SCREEN_HEIGHT-SCREEN_HEIGHT/2.6, SCREEN_WIDTH, SCREEN_HEIGHT/2.6);
        //tableview上移
       if (_dataSource.count > 4) {
          _tableView.frame = CGRectMake(0, 64 - (view.bounds.size.height - SCREEN_HEIGHT/13 - 2), SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT/13 - 64);
       }
        btn.selected = YES;
    }else{
        //下方操作视图回复到原始位置
        view.frame = CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/13, SCREEN_WIDTH, SCREEN_HEIGHT/2.6);
        //tableview回复到原始位置
        _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT/13 - 64);
        btn.selected = NO;
    }
    [self.view endEditing:YES];
}
#pragma mark - 响应事件
-(void)textViewDidBeginEditing:(UITextField *)textView{
   self.modelForMenu = nil;
    UIView *view = [self.view viewWithTag:1];
    //下方操作视图回复到原始位置
    view.frame = CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/13, SCREEN_WIDTH, SCREEN_HEIGHT/2.6);
    UIButton *btn = [self.view viewWithTag:3];
    btn.selected = NO;
    //tableview回复到原始位置
    _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT/13 - 64);
    //键盘弹出时视图上移
   if (_dataSource.count > 4) {
      self.view.frame = CGRectMake(0, self.view.bounds.origin.y - 216 - SCREEN_HEIGHT/13, self.view.frame.size.width, self.view.frame.size.height);
   }else{
      view.frame = CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/13*2 - 216, SCREEN_WIDTH, SCREEN_HEIGHT/2.6);
   }
}
-(void)textViewDidEndEditing:(UITextField *)textView{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIView *view = [self.view viewWithTag:1];
    //下方操作视图回复到原始位置
    view.frame = CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/13, SCREEN_WIDTH, SCREEN_HEIGHT/2.6);
    UIButton *btn = [self.view viewWithTag:3];
    btn.selected = NO;
    //tableview回复到原始位置
    _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT/13 - 64);
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated{
   [super viewWillDisappear:animated];
   if ([[[NIMSDK sharedSDK] mediaManager] isPlaying]) {
      [[[NIMSDK sharedSDK] mediaManager] stopPlay];
   }
}
@end

@implementation CustomdBtn

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
   return CGRectMake(contentRect.size.width /2 + 2.5, 0, contentRect.size.width /2, contentRect.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
   return CGRectMake(contentRect.size.width /2 - 22.5, (contentRect.size.height - 20) /2, 20, 20);
}

@end
