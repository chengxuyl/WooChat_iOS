//
//  DialogueView.h
//  WooChat
//
//  Created by apple on 16/8/29.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogueView : UIView
//整个下方视图
@property UIView *iconView;
//输入消息
@property UITextView *textView;
//语音&键盘按钮
@property UIButton *changeBtn1;
//+号&-号按钮
@property UIButton *changeBtn2;
//语音输入按钮
@property UIButton *voiceBtn;
//发送按钮
@property UIButton *SendBtn;

//语音输入状态图片
@property UIImageView *stateView;
//语音输入取消图片
@property UIImageView *cancleView;
//语音输入失败图片
@property UIImageView *tooshotView;
//语音正在输入图片
@property UIImageView *microView;
//音量图片
@property UIImageView *volumeView;

//图片按钮
@property UIButton *PicBtn;
//拍照按钮
@property UIButton *takePicBtn;
//表情按钮
@property UIButton *expressionBtn;
//地理位置按钮
@property UIButton *LocationBtn;
//名片按钮
@property UIButton *visitingCBtn;
//我的收藏按钮
@property UIButton *collectionBtn;
//语音电话按钮
@property UIButton *voiceCallBtn;
//视频通话按钮
@property UIButton *videoPhoneBtn;
@end
