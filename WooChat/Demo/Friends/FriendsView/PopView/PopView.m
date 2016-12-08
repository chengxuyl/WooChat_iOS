//
//  PopView.m
//  Moatong
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "PopView.h"

@implementation PopView
- (instancetype)init
{
    self = [super init];
    if (self) {
        //底部图片
        _popView =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.8, 67, SCREEN_WIDTH/2.35, SCREEN_HEIGHT/2.8)];
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.35, SCREEN_HEIGHT/2.8)];
        [iv setImage:[UIImage imageNamed:@"tab"]];
        [_popView addSubview:iv];
//        _popView.userInteractionEnabled = YES;
        _popView.alpha = 0.95;
        
        //发起群聊
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/40, SCREEN_WIDTH/3.5, SCREEN_HEIGHT/20)];
//        view1.backgroundColor = [UIColor redColor];
        [_popView addSubview:view1];
        
        UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/11, SCREEN_WIDTH/11)];
//        iv1.backgroundColor = [UIColor blueColor];
        [iv1 setImage:[UIImage imageNamed:@"groupchat"]];
        [view1 addSubview:iv1];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 0, SCREEN_WIDTH/4, SCREEN_HEIGHT/20)];
        label1.text = @"发起群聊";
        label1.textColor = [UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentLeft;
//        label1.backgroundColor = [UIColor blueColor];
        [view1 addSubview:label1];
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/25, SCREEN_HEIGHT/12, SCREEN_WIDTH/3, 0.5)];
        line1.backgroundColor = [UIColor whiteColor];
        [_popView addSubview:line1];
        
        
        //添加朋友
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/11, SCREEN_WIDTH/3.5, SCREEN_HEIGHT/20)];
//        view2.backgroundColor = [UIColor redColor];
        [_popView addSubview:view2];
        
        UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/11, SCREEN_WIDTH/11)];
//        iv2.backgroundColor = [UIColor blueColor];
        [iv2 setImage:[UIImage imageNamed:@"addfriend"]];
        [view2 addSubview:iv2];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 0, SCREEN_WIDTH/4, SCREEN_HEIGHT/20)];
        label2.text = @"添加朋友";
        label2.textColor = [UIColor whiteColor];
        label2.textAlignment = NSTextAlignmentLeft;
//        label2.backgroundColor = [UIColor blueColor];
        [view2 addSubview:label2];
        
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/25, SCREEN_HEIGHT/6.7, SCREEN_WIDTH/3, 0.5)];
        line2.backgroundColor = [UIColor whiteColor];
        [_popView addSubview:line2];
        
        //按条件查找
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/6.3, SCREEN_WIDTH/3.5, SCREEN_HEIGHT/20)];
//        view3.backgroundColor = [UIColor redColor];
        [_popView addSubview:view3];
        
        UIImageView *iv3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/11, SCREEN_WIDTH/11)];
//        iv3.backgroundColor = [UIColor blueColor];
        [iv3 setImage:[UIImage imageNamed:@"conditionsearch"]];
        [view3 addSubview:iv3];
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 0, SCREEN_WIDTH/3, SCREEN_HEIGHT/20)];
        label3.text = @"按条件查找";
        label3.textColor = [UIColor whiteColor];
        label3.textAlignment = NSTextAlignmentLeft;
//        label3.backgroundColor = [UIColor blueColor];
        [view3 addSubview:label3];
        
        UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/25, SCREEN_HEIGHT/4.6, SCREEN_WIDTH/3, 0.5)];
        line3.backgroundColor = [UIColor whiteColor];
        [_popView addSubview:line3];
        
        //扫一扫
        UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/4.4, SCREEN_WIDTH/3.5, SCREEN_HEIGHT/20)];
//        view4.backgroundColor = [UIColor redColor];
        [_popView addSubview:view4];
        
        UIImageView *iv4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/11, SCREEN_WIDTH/11)];
//        iv4.backgroundColor = [UIColor blueColor];
        [iv4 setImage:[UIImage imageNamed:@"scan"]];
        [view4 addSubview:iv4];
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 0, SCREEN_WIDTH/4, SCREEN_HEIGHT/20)];
        label4.text = @"扫一扫";
        label4.textColor = [UIColor whiteColor];
        label4.textAlignment = NSTextAlignmentLeft;
//        label4.backgroundColor = [UIColor blueColor];
        [view4 addSubview:label4];
        
        UILabel *line4 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/25, SCREEN_HEIGHT/3.5, SCREEN_WIDTH/3, 0.5)];
        line4.backgroundColor = [UIColor whiteColor];
        [_popView addSubview:line4];
        
        //拍照分享
        UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/3.4, SCREEN_WIDTH/3.5, SCREEN_HEIGHT/20)];
//        view5.backgroundColor = [UIColor redColor];
        [_popView addSubview:view5];
        
        UIImageView *iv5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/11, SCREEN_WIDTH/11)];
//        iv5.backgroundColor = [UIColor blueColor];
        [iv5 setImage:[UIImage imageNamed:@"takepictureshare"]];
        [view5 addSubview:iv5];
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 0, SCREEN_WIDTH/4, SCREEN_HEIGHT/20)];
        label5.text = @"拍照分享";
        label5.textColor = [UIColor whiteColor];
        label5.textAlignment = NSTextAlignmentLeft;
//        label5.backgroundColor = [UIColor blueColor];
        [view5 addSubview:label5];
        
        //发起群聊按钮
        _groupChatBtn = [[UIButton alloc]initWithFrame:view1.frame];
        [_popView addSubview:_groupChatBtn];
        
        //添加朋友按钮
        _addFriendsBtn = [[UIButton alloc]initWithFrame:view2.frame];
        [_popView addSubview:_addFriendsBtn];

        //按条件查找按钮
        _searchConditionBtn = [[UIButton alloc]initWithFrame:view3.frame];
        [_popView addSubview:_searchConditionBtn];

        //扫一扫按钮
        _RichScanBtn = [[UIButton alloc]initWithFrame:view4.frame];
        [_popView addSubview:_RichScanBtn];

        //拍照分享按钮
        _photographBtn = [[UIButton alloc]initWithFrame:view5.frame];
        [_popView addSubview:_photographBtn];

        
    }
    return self;
}
@end
