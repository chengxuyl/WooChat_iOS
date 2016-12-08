//
//  OriginalPhoViewController.m
//  WooChat
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "OriginalPhoViewController.h"
#import "NavigationView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhoModel.h"
#import "DialogueViewController.h"
#import "OriginalPhoView.h"
@interface OriginalPhoViewController ()<UIScrollViewDelegate>
@property UIScrollView *scrollView;
@property NSMutableArray *selectedpicArr;
@property UIImage *nowImage;
@property OriginalPhoView *originalPhoView;
@property void (^sendNumBlock)(int);
@end

@implementation OriginalPhoViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _picArr = [[NSMutableArray alloc]init];
        _selectedpicArr = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (PhoModel *mod in _picArr) {
        mod.select = YES;
        [_selectedpicArr addObject:mod];
    }
    [self setNavigation];
    [self createPage];
}
#pragma mark - 导航条设置
- (void)setNavigation{
    self.navigationItem.title = [NSString stringWithFormat:@"1/%lu",_picArr.count];
    [self.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil
                                                                                   action:nil];
    negativeSpacer.width = SCREEN_WIDTH/30 * -1;

    NavigationView *nv = [[NavigationView alloc]init];
    [nv.nvOriginaSendBtn setTitle:[NSString stringWithFormat:@"发送(%lu/%lu)",_picArr.count,_picArr.count] forState:UIControlStateNormal];
    _sendNumBlock = ^(int num){
        [nv.nvOriginaSendBtn setTitle:[NSString stringWithFormat:@"发送(%d/%lu)",num,_picArr.count] forState:UIControlStateNormal];
    };
    
    [nv.nvOriginaSendBtn addTarget:self action:@selector(nvOriginaSendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //导航条左右按钮位移
    UIBarButtonItem *nvOriginaSendBtn = [[UIBarButtonItem alloc]initWithCustomView:nv.nvOriginaSendBtn];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,
                                                nvOriginaSendBtn];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:nv.backBtn];
    [nv.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,
                                               backBtnItem];
    //scrollView自增64关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)nvOriginaSendBtnClick{
    UINavigationController *NavigationC = self.navigationController;
    NSMutableArray *viewCArr = [[NSMutableArray alloc] init];
    for (DialogueViewController *viewC in [NavigationC viewControllers]) {
        [viewCArr addObject:viewC];
        if ([viewC isKindOfClass:[DialogueViewController class]]) {
            
//            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (PhoModel *mod in _selectedpicArr) {
                if (mod.select == YES) {
//                    [arr addObject:mod];
                    if (_originalPhoView.picBtn.selected == YES) {
                        ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
                        [lib assetForURL:mod.imageURL resultBlock:^(ALAsset *asset) {
                            ALAssetRepresentation *rep = asset.defaultRepresentation;
                            CGImageRef imageRef = rep.fullResolutionImage;
                            UIImage *image = [UIImage imageWithCGImage:imageRef
                                                                 scale:rep.scale
                                                           orientation:(UIImageOrientation)rep.orientation];
                            [viewC ImageSend:image];
                        } failureBlock:^(NSError *error) {
                        }];
                    }else{
                        [viewC ImageSend:mod.thumb];
                    }
                }
            }
            break;
        }
    }
    [NavigationC setViewControllers:viewCArr animated:YES];
}
#pragma mark - 创建页面
- (void)createPage{
    [self createScrollView];
    _originalPhoView = [[OriginalPhoView alloc]init];
    [self.view addSubview:_originalPhoView.toolView];
    [_originalPhoView.selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_originalPhoView.picBtn addTarget:self action:@selector(picBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _originalPhoView.picBtn.selected = NO;
    
}

/**  计算当前选中的图片个数 */
- (int)nowNum{
    int num = 0;
    for (PhoModel *mod in _selectedpicArr) {
        if (mod.select == YES) {
            num++;
        }
    }
    return num;
}
//屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation ==UIInterfaceOrientationPortrait||interfaceOrientation ==UIInterfaceOrientationPortraitUpsideDown)
    {
        return YES;
    }
    return NO;
}
#pragma mark - 滚动视图
- (void)createScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < _picArr.count; i++) {
            ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
            [lib assetForURL:[_picArr[i] imageURL] resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = asset.defaultRepresentation;
                CGImageRef imageRef = rep.fullResolutionImage;
                UIImage *image = [UIImage imageWithCGImage:imageRef
                                                     scale:rep.scale
                                               orientation:(UIImageOrientation)rep.orientation];
                
                PhoModel *mod = [[PhoModel alloc]init];
                mod = _picArr[i];
                //图片转Data计算大小
                NSData *imageData = UIImagePNGRepresentation(image);
                if (imageData.length/1024/1024 > 1) {
                    mod.imageLength = [NSString stringWithFormat:@"原图(%luMB)",imageData.length/1024/1024];
                }else
                    mod.imageLength = [NSString stringWithFormat:@"原图(%luKB)",imageData.length/1024];
                
                UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleDoubleTap:)];
                [doubleTap setNumberOfTapsRequired:2];
                UIScrollView*s = [[UIScrollView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
                s.backgroundColor= [UIColor clearColor];
                s.contentSize=CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
                s.delegate=self;
                s.minimumZoomScale=1;
                s.maximumZoomScale=10.0;
                [s setZoomScale:1.0];
                UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                imageview.contentMode=UIViewContentModeScaleAspectFit;
                
                imageview.image= image;
                imageview.userInteractionEnabled=YES;
                [imageview addGestureRecognizer:doubleTap];
                [s addSubview:imageview];
                [_scrollView addSubview:s];
            } failureBlock:^(NSError *error) {
                
            }];
        }
    });
    
    
    
    [_scrollView setContentSize:CGSizeMake(_picArr.count*SCREEN_WIDTH, 0)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = FALSE;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    //设置缩放的最小、最大 比例
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 100;
}

#pragma mark - ScrollView delegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{
    for(UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView{
    if(scrollView == _scrollView){
        CGFloat x = scrollView.contentOffset.x;
        if(x == -SCREEN_WIDTH/3){
        }
        else{
            //            offset = x;
            for(UIScrollView*s in scrollView.subviews){
                if([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0]; //scrollView每滑动一次将要出现的图片较正常时候图片的倍数（将要出现的图片显示的倍数）
                }
            }
        }
        
        int num = _scrollView.contentOffset.x / SCREEN_WIDTH;
        PhoModel *mod = _selectedpicArr[num];
        if (mod.select == YES) {
            [_originalPhoView.selectedImageView setImage:[UIImage imageNamed:@"select_photo_press"]];
        }else
            [_originalPhoView.selectedImageView setImage:[UIImage imageNamed:@"select_photo"]];
        
        if (_originalPhoView.picBtn.selected == YES) {
            _originalPhoView.picSize.text = mod.imageLength;
        }else
            _originalPhoView.picSize.text = @"原图";
    }
}
/** 图片双击放大手势*/
-(void)handleDoubleTap:(UIGestureRecognizer*)gesture{
    if ([(UIScrollView*)gesture.view.superview zoomScale] == 1) {
        float newScale = [(UIScrollView*)gesture.view.superview zoomScale] *2;//每次双击放大倍数
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
        [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
    }else{
        float newScale = [(UIScrollView*)gesture.view.superview zoomScale] /2;//每次双击放大倍数
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
        [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height=self.view.frame.size.height / scale;
    zoomRect.size.width=self.view.frame.size.width / scale;
    zoomRect.origin.x= center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y= center.y - (zoomRect.size.height / 2.0);

    return zoomRect;
}
#pragma mark - 点击事件
//导航返回按钮点击事件
- (void)back{
    if (self.returnPicBlock != nil) {
        self.returnPicBlock(_selectedpicArr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnPicArr:(returnBlock)block{
    self.returnPicBlock = block;
}
//原图选择按钮点击事件
- (void)picBtnClick:(UIButton *)btn{
    if (btn.selected == NO) {
        btn.selected = YES;
        int num = _scrollView.contentOffset.x / SCREEN_WIDTH;
        [_originalPhoView.picImageView setImage:[UIImage imageNamed:@"original_photo_select"]];
        _originalPhoView.picSize.text = [_selectedpicArr[num] imageLength];
    }else{
        btn.selected = NO;
        [_originalPhoView.picImageView setImage:[UIImage imageNamed:@"original_photo"]];
        _originalPhoView.picSize.text = @"原图";
    }
}

//图片选择按钮点击事件
- (void)selectedBtnClick:(UIButton *)btn{
    int num = _scrollView.contentOffset.x / SCREEN_WIDTH;
    PhoModel *mod = _selectedpicArr[num];
    if (mod.select == YES) {
        [_originalPhoView.selectedImageView setImage:[UIImage imageNamed:@"select_photo"]];
        mod.select = NO;
        _sendNumBlock([self nowNum]);
    }else{
        [_originalPhoView.selectedImageView setImage:[UIImage imageNamed:@"select_photo_press"]];
        mod.select = YES;
        _sendNumBlock([self nowNum]);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
