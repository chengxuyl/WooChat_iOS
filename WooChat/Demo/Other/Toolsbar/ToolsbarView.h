//
//  ToolsbarView.h
//  WooChat
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolsbarView : UIView
/**
 *  初始化方法 参数:第几页
 */
- (instancetype)initWithNum:(int)num;
//页面工具条视图
@property UIView *toolsbar;
//好友按钮
@property UIButton *FriendsBtn;
//聊天按钮
@property UIButton *chatBtn;
//广告按钮
@property UIButton *adBtn;
//朋友圈按钮
@property UIButton *FCBtn;
//更多按钮
@property UIButton *moreBtn;
@end