//
//  AdvertisementView.m
//  WooChat
//
//  Created by apple on 16/8/26.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "AdvertisementView.h"
#define PADDING 1
@implementation AdvertisementView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _AdvertisementView =[[UIView alloc]initWithFrame:CGRectMake(0, 128, SCREEN_WIDTH, SCREEN_HEIGHT/3.2+6)];
        _AdvertisementView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        _AdvertisementBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, SCREEN_HEIGHT/3.2)];
        _AdvertisementBtnView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [_AdvertisementView addSubview:_AdvertisementBtnView];
        
        UIView *view1 = [[UIView alloc]init];
        UIView *view2 = [[UIView alloc]init];
        UIView *view3 = [[UIView alloc]init];
        UIView *view4 = [[UIView alloc]init];
        [_AdvertisementBtnView addSubview:view1];
        [_AdvertisementBtnView addSubview:view2];
        [_AdvertisementBtnView addSubview:view3];
        [_AdvertisementBtnView addSubview:view4];
        [self addBackgroundImageWithView:view1 ImageName:@"clothing" Name:@"服装"];
        [self addBackgroundImageWithView:view2 ImageName:@"communication" Name:@"通讯"];
        [self addBackgroundImageWithView:view3 ImageName:@"houseproperty" Name:@"房地产"];
        [self addBackgroundImageWithView:view4 ImageName:@"car" Name:@"汽车"];
        
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@[view2,view3,view4]);
            make.top.equalTo(_AdvertisementBtnView);
            make.left.equalTo(_AdvertisementBtnView);
            make.height.mas_equalTo((_AdvertisementBtnView.bounds.size.height-2*PADDING)/3);
            make.width.mas_equalTo((_AdvertisementBtnView.bounds.size.width-3*PADDING)/4);
            make.width.equalTo(@[view2,view3,view4]);
        }];
        [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view1.mas_right).with.offset(PADDING);
            make.right.equalTo(view3.mas_left).with.offset(-PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view3.mas_right).with.offset(PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        
        UIView *view5 = [[UIView alloc]init];
        UIView *view6 = [[UIView alloc]init];
        UIView *view7 = [[UIView alloc]init];
        UIView *view8 = [[UIView alloc]init];
        [_AdvertisementBtnView addSubview:view5];
        [_AdvertisementBtnView addSubview:view6];
        [_AdvertisementBtnView addSubview:view7];
        [_AdvertisementBtnView addSubview:view8];
        [self addBackgroundImageWithView:view5 ImageName:@"movies" Name:@"影视"];
        [self addBackgroundImageWithView:view6 ImageName:@"yummy" Name:@"美食"];
        [self addBackgroundImageWithView:view7 ImageName:@"wedding" Name:@"婚庆"];
        [self addBackgroundImageWithView:view8 ImageName:@"appliances" Name:@"家电"];
        
        [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@[view6,view7,view8]);
            make.top.equalTo(view1.mas_bottom).with.offset(PADDING);
            make.left.equalTo(_AdvertisementBtnView);
            make.height.mas_equalTo((_AdvertisementBtnView.bounds.size.height-2*PADDING)/3);
            make.width.mas_equalTo((_AdvertisementBtnView.bounds.size.width-3*PADDING)/4);
            make.width.equalTo(@[view6,view7,view8]);
        }];
        [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view2.mas_bottom).with.offset(PADDING);
            make.left.equalTo(view5.mas_right).with.offset(PADDING);
            make.right.equalTo(view7.mas_left).with.offset(-PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        [view7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view3.mas_bottom).with.offset(PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        [view8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view4.mas_bottom).with.offset(PADDING);
            make.left.equalTo(view7.mas_right).with.offset(PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        
        UIView *view9 = [[UIView alloc]init];
        UIView *view10 = [[UIView alloc]init];
        UIView *view11 = [[UIView alloc]init];
        UIView *view12 = [[UIView alloc]init];
        [_AdvertisementBtnView addSubview:view9];
        [_AdvertisementBtnView addSubview:view10];
        [_AdvertisementBtnView addSubview:view11];
        [_AdvertisementBtnView addSubview:view12];
        [self addBackgroundImageWithView:view9 ImageName:@"tourism" Name:@"旅游"];
        [self addBackgroundImageWithView:view10 ImageName:@"cosmetology" Name:@"美容"];
        [self addBackgroundImageWithView:view11 ImageName:@"smallcommodities" Name:@"小商品"];
        [self addBackgroundImageWithView:view12 ImageName:@"medicalcare" Name:@"医疗"];
        
        [view9 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@[view10,view11,view12]);
            make.top.equalTo(view5.mas_bottom).with.offset(PADDING);
            make.left.equalTo(_AdvertisementBtnView);
            make.height.mas_equalTo((_AdvertisementBtnView.bounds.size.height-2*PADDING)/3);
            make.width.mas_equalTo((_AdvertisementBtnView.bounds.size.width-3*PADDING)/4);
            make.width.equalTo(@[view10,view11,view12]);
        }];
        [view10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view9.mas_right).with.offset(PADDING);
            make.top.equalTo(view6.mas_bottom).with.offset(PADDING);
            make.right.equalTo(view11.mas_left).with.offset(-PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        [view11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view7.mas_bottom).with.offset(PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        [view12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view8.mas_bottom).with.offset(PADDING);
            make.left.equalTo(view11.mas_right).with.offset(PADDING);
            make.height.mas_equalTo(_AdvertisementBtnView.bounds.size.height/3);
        }];
        
        //下方按钮条
        _downBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/10-3, frame.size.width, SCREEN_HEIGHT/10)];
        _downBtnView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        UIView *View1 = [[UIView alloc]initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT/10)];
        View1.backgroundColor = [UIColor whiteColor];
        UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, SCREEN_HEIGHT/130, SCREEN_WIDTH/10, SCREEN_HEIGHT/18)];
        [View1 addSubview:iv1];
        [iv1 setImage:[UIImage imageNamed:@"admore_adrecord"]];
        UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/30, SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT/10)];
        lable1.text = @"观看广告记录";
        lable1.textColor = [UIColor blackColor];
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.font = [UIFont systemFontOfSize:14];
        [View1 addSubview:lable1];
        [_downBtnView addSubview:View1];
        
        UIView *View2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+0.5, 3, SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT/10)];
        View2.backgroundColor = [UIColor whiteColor];
        UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, SCREEN_HEIGHT/130, SCREEN_WIDTH/10, SCREEN_HEIGHT/18)];
        [View2 addSubview:iv2];
        [iv2 setImage:[UIImage imageNamed:@"researchrecord"]];
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/30, SCREEN_WIDTH/2-0.5, SCREEN_HEIGHT/10)];
        lable2.text = @"观看调研记录";
        lable2.textColor = [UIColor blackColor];
        lable2.textAlignment = NSTextAlignmentCenter;
        lable2.font = [UIFont systemFontOfSize:14];
        [View2 addSubview:lable2];
        [_downBtnView addSubview:View2];
        
        view1.tag = 11;
        view2.tag = 12;
        view3.tag = 13;
        view4.tag = 14;
        view5.tag = 15;
        view6.tag = 16;
        view7.tag = 17;
        view8.tag = 18;
        view9.tag = 19;
        view10.tag = 20;
        view11.tag = 21;
        view12.tag = 22;
    }
    return self;
}
//背景图
- (void)addBackgroundImageWithView:(UIView *)view
                         ImageName:(NSString *)imageName
                              Name:(NSString *)name{
    
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc]init];
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY).with.offset(-10);
        make.centerX.equalTo(view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/11, SCREEN_HEIGHT/19));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.bottom.equalTo(view).with.offset(-5);
    }];
}
@end
