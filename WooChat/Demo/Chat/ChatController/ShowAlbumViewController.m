//
//  ShowAlbumViewController.m
//  WooChat
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ShowAlbumViewController.h"

@interface ShowAlbumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *imagesArr;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger tempInt;
@end

@implementation ShowAlbumViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
//    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    NSArray<NIMMessage *> *messages = [[[NIMSDK sharedSDK] conversationManager] messagesInSession:self.session
                                                        message:nil
                                                          limit:nil];
    self.imagesArr = [NSMutableArray array];
    int i = 0;
    for (NIMMessage *message in messages) {
        if (message.messageType == NIMMessageTypeImage) {
            [self.imagesArr addObject:message];
        }
        if ([message isEqual:self.message]) {
            self.tempInt = i;
        }
        i++;
    }
    [self creatCollectionView];
}

- (void)creatCollectionView{
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collect.backgroundColor = [UIColor blackColor];
    //注册item类型 这里使用系统的类型
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"images"];
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    collect.pagingEnabled = YES;
    
    [collect scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.tempInt inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.view addSubview:collect];
}

#pragma mark - collectionViewDelegate and dataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"images" forIndexPath:indexPath];
    NIMMessage *message = self.imagesArr[indexPath.item];
    NIMImageObject *imageObject = [[NIMImageObject alloc]init];
    imageObject = (NIMImageObject *)message.messageObject;
    UIImageView *imageView = [[UIImageView alloc] init];
    if (imageObject.size.width > SCREEN_WIDTH && imageObject.size.height < SCREEN_HEIGHT) {
        imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH * imageObject.size.height) / imageObject.size.width);
    }else if (imageObject.size.height > SCREEN_HEIGHT && imageObject.size.width < SCREEN_WIDTH){
        imageView.frame = CGRectMake(0, 0, (imageObject.size.width * SCREEN_HEIGHT) / imageObject.size.height, SCREEN_HEIGHT);
    }
    else if (imageObject.size.height > SCREEN_HEIGHT && imageObject.size.width > SCREEN_WIDTH){
        if (imageObject.size.height > imageObject.size.width) {
            imageView.frame = CGRectMake(0, 0, (imageObject.size.width * SCREEN_HEIGHT) / imageObject.size.height, SCREEN_HEIGHT);
        }else{
            imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH * imageObject.size.height) / imageObject.size.width);
        }
    }
    else{
        imageView.frame = CGRectMake(0, 0, imageObject.size.width, imageObject.size.height);
    }
    imageView.center = self.view.center;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageObject.url]];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imageObject.thumbPath]];
    [cell addSubview:imageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:false];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
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
