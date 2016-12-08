//
//  ChatBackGroundViewController.m
//  WooChat
//
//  Created by qiubo on 2016/11/30.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ChatBackGroundViewController.h"
#import "ChatBackGroundCollectionViewCell.h"
#import "DialogueViewController.h"
@interface ChatBackGroundViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ChatBackGroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择背景图";
    self.view.backgroundColor = [UIColor grayColor];
    [self creatCollectionView];
}

- (void)creatCollectionView{
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - 50) / 4, (SCREEN_WIDTH - 50) / 4);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collect.backgroundColor = [UIColor grayColor];
    //注册item类型 这里使用系统的类型
    [collect registerClass:[ChatBackGroundCollectionViewCell class] forCellWithReuseIdentifier:[ChatBackGroundCollectionViewCell cellIdentifier]];
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    
    [self.view addSubview:collect];
}

#pragma mark - collectionViewDelegate and dataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChatBackGroundCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:[ChatBackGroundCollectionViewCell cellIdentifier] forIndexPath:indexPath];
//    if (indexPath.item == 0) {
//        cell.imageName = @"back_s_01";
//    }else if (indexPath.row == 1){
//        cell.imageName = @"back_s_02";
//    }else{
//        cell.imageName = @"back_s_03";
//    }
    cell.imageName = [NSString stringWithFormat:@"btn_%ld", indexPath.row];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:[UserInfo sharedInstance].dataBasePath];
    [db open];
    NSString *chatBackGround = [db stringForQuery:@"SELECT chatBackGround FROM PersonList WHERE imId = ?",self.session.sessionId];
    if ([chatBackGround isEqualToString:cell.imageName]) {
        [cell showChoose:YES];
    }else{
        [cell showChoose:NO];
    }
    [db close];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatBackGroundCollectionViewCell *cell = (ChatBackGroundCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    for (UIView *view in collectionView.subviews) {
//        if ([view isKindOfClass:[ChatBackGroundCollectionViewCell class]]) {
//            ChatBackGroundCollectionViewCell *cell = (ChatBackGroundCollectionViewCell*)view;
//            [cell showChoose:YES];
//        }
//    }
    [cell showChoose:YES];
    FMDatabase *db = [[FMDatabase alloc] initWithPath:[UserInfo sharedInstance].dataBasePath];
    [db open];
    //更新
    [db executeUpdate:@"UPDATE PersonList SET chatBackGround = ? WHERE imId = ?",
     cell.imageName, self.session.sessionId];
    [db close];
    NSArray *temArray = self.navigationController.viewControllers;
    for(UIViewController *temVC in temArray)
    {
        if ([temVC isKindOfClass:[DialogueViewController class]])
        {
            [self.navigationController popToViewController:temVC animated:YES];
        }
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
