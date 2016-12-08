//
//  PhoViewController.m
//  WooChat
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "PhoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhoModel.h"
#import "PhoCollectionViewCell.h"
#import "PhoView.h"
#import "NavigationView.h"
#import "OriginalPhoViewController.h"

@interface PhoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property NSMutableArray *assetsArray;
@property NSMutableArray *selectAssetsArray;
@property ALAssetsLibrary *assetsLibrary;
@property UICollectionView * collectionView;
@property NSArray *receivePicArr;
@property NSString* groupName;
//预览统计数字
@property int picNum;
//预览按钮统计数字回调block
@property void(^numBlock)();
@end
@implementation PhoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _picNum = 0;
    [self ergodicPho];
    [self setNavigation];
    [self createPage];
}
#pragma mark - 页面设置
- (void)createPage{
    PhoView *pho = [[PhoView alloc]init];
    [self.view addSubview:pho.toolView];
    [self.view bringSubviewToFront:pho.toolView];
    
    [pho.preBtn addTarget:self action:@selector(preBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _numBlock = ^{
        if (_picNum == 0) {
            [pho.preBtn setTitle:@"预览" forState:UIControlStateNormal];
            [pho.preBtn setTitleColor:[UIColor colorWithRed:100/255.0 green:210/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        }else{
            [pho.preBtn setTitle:[NSString stringWithFormat:@"预览(%d)",_picNum] forState:UIControlStateNormal];
            [pho.preBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    };
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark - 导航条设置
- (void)setNavigation{
    self.navigationItem.title = _groupName;
    [self.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    negativeSpacer.width = SCREEN_WIDTH/30 * -1;
    
    NavigationView *nv = [[NavigationView alloc]init];
    
    UIBarButtonItem *nvSendBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.nvSendBtn];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,
                                                nvSendBtnItem];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.backBtn];
    [nv.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,
                                               backBtnItem];
}
#pragma mark - 集合视图
- (void)createCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //行 最小间距 如果横向滑动 则设置列间距  如果纵向滑动 则设置行间距
    flowLayout.minimumLineSpacing = 2;
    //item(cell) 之间最小间距
    flowLayout.minimumInteritemSpacing = 2;
    //设置 item 大小
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-4)/3-2, (SCREEN_WIDTH-4)/3-2);
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate  =self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"PhoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhoCollectionViewCell"];
    
    [self.view addSubview:_collectionView];
    [self.view sendSubviewToBack:_collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _assetsArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhoCollectionViewCell" forIndexPath:indexPath];
    
    [cell.imageView setImage:[_assetsArray[indexPath.row] thumb]];
    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (_receivePicArr.count != 0) {
        if ([_assetsArray[indexPath.row] select] == YES) {
            cell.selectBtn.selected = YES;
            _numBlock();
        }else{
            cell.selectBtn.selected = NO;
            _numBlock();
        }
    }
    cell.selectBtn.tag = indexPath.row;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    OriginalPhoViewController *opVC = [[OriginalPhoViewController alloc]init];
//    opVC.picArr = [NSMutableArray arrayWithArray:_selectAssetsArray];
//    [self.navigationController pushViewController:opVC animated:YES];
}
//相册略缩图 图片选中点击事件
- (void)selectBtnClick:(UIButton *)btn{
        if (btn.selected == YES) {
            btn.selected = NO;
            [_selectAssetsArray removeObject:_assetsArray[btn.tag]];
            _picNum--;
            _numBlock();
        }else{
            if (_picNum < 3) {
            btn.selected = YES;
                
            [_selectAssetsArray addObject:_assetsArray[btn.tag]];
            _picNum++;
            _numBlock();
            }
        }
}
#pragma mark - 取得相片
//遍历相册
- (void)ergodicPho{
    _selectAssetsArray = [[NSMutableArray alloc]init];
    
    _assetsLibrary = [[ALAssetsLibrary alloc] init];
    _assetsArray = [[NSMutableArray alloc]init];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [self setGroup:group];
            _groupName = [NSString stringWithFormat:@"%@",group];
            NSLog(@"%@",[NSString stringWithFormat:@"%@",group]);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Group not found!\n");
    }];
}
//群组遍历相片
- (void)setGroup:(ALAssetsGroup *)group{
    [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset == nil) return ;
        if (![[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {//不是图片
            return;
        }
        PhoModel *model = [[PhoModel alloc] init];
        model.thumb = [UIImage imageWithCGImage:asset.thumbnail];
        model.imageURL = asset.defaultRepresentation.url;
        
        [_assetsArray addObject:model];
        
    }];
    [self createCollectionView];
}
#pragma mark - 点击事件
//预览按钮点击事件
- (void)preBtnClick{
    if (_selectAssetsArray.count != 0) {
        OriginalPhoViewController *opVC = [[OriginalPhoViewController alloc]init];
        opVC.picArr = [NSMutableArray arrayWithArray:_selectAssetsArray];
        [opVC returnPicArr:^(NSArray *picArr) {
            _receivePicArr = [[NSArray alloc]initWithArray:picArr];
            
            for (int i = 0; i < _receivePicArr.count; i++) {
                PhoModel *model = _receivePicArr[i];
                for (int j = 0; j < _assetsArray.count; j++) {
                    PhoModel *mod = _assetsArray[j];
                    if (model.thumb == mod.thumb) {
                        mod.select = model.select;
                        if (mod.select == NO) {
                            [_selectAssetsArray removeObject:mod];
                            _picNum--;
                            _numBlock();
                        }
                    }
                }
            }
            [_collectionView reloadData];
        }];
        [self.navigationController pushViewController:opVC animated:YES];
    }
}
//导航返回按钮点击事件
- (void)back{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType: kCATransitionPush];
    [animation setSubtype: kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    [self.navigationController popViewControllerAnimated:NO];//禁止动画
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
