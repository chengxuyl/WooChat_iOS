//
//  NavigationView.h
//  Moatong
//
//  Created by 殷玮 on 16/8/16.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationView : UIView
#pragma mark - chatView
//头像按钮
@property UIButton *headImageBtn;
//右边加号按钮
@property UIButton *RightBtn;
//右边翻译按钮
@property UIButton *transelateBtn;
//右边设置按钮
@property UIButton *setBtn;

#pragma mark - phoView
//右上角发送按钮-灰色
@property UIButton *nvSendBtn;
//相册详细页面右上角发送按钮
@property UIButton *nvOriginaSendBtn;
//返回按钮
@property UIButton *backBtn;
@end
