//
//  PopView.h
//  Moatong
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopView : UIView
//popView父视图
@property UIView *popView;
//发起群聊按钮
@property UIButton *groupChatBtn;
//添加朋友按钮
@property UIButton *addFriendsBtn;
//按条件查找按钮
@property UIButton *searchConditionBtn;
//扫一扫按钮
@property UIButton *RichScanBtn;
//拍照分享按钮
@property UIButton *photographBtn;
@end
