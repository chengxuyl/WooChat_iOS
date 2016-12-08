//
//  DialogueView.m
//  WooChat
//
//  Created by apple on 16/8/29.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "DialogueView.h"

@implementation DialogueView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //        SCREEN_HEIGHT-SCREEN_HEIGHT/2.6
        _iconView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/13, SCREEN_WIDTH, SCREEN_HEIGHT/2.6)];
        _iconView.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, SCREEN_HEIGHT/13)];
        view1.backgroundColor = [UIColor whiteColor];
        [_iconView addSubview:view1];
        
        _changeBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/40, SCREEN_HEIGHT/70, SCREEN_WIDTH/12, SCREEN_WIDTH/12)];
        [_changeBtn1 setImage:[UIImage imageNamed:@"t_s"] forState:UIControlStateNormal];
        [_changeBtn1 setImage:[UIImage imageNamed:@"voice_s"] forState:UIControlStateSelected];
        
        [view1 addSubview:_changeBtn1];
        _changeBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8, SCREEN_HEIGHT/70, SCREEN_WIDTH/12, SCREEN_WIDTH/12)];
        [_changeBtn2 setImage:[UIImage imageNamed:@"smiley_add_bt_s"] forState:UIControlStateNormal];
        [_changeBtn2 setImage:[UIImage imageNamed:@"smiley_delete_bt_s"] forState:UIControlStateSelected];
        [view1 addSubview:_changeBtn2];
        
        UIImageView *tfImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.5, SCREEN_HEIGHT/150, SCREEN_WIDTH/1.7, SCREEN_HEIGHT/15.5)];
        [tfImageView setImage:[UIImage imageNamed:@"text"]];
        [view1 addSubview:tfImageView];
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.2, SCREEN_HEIGHT/150+2, SCREEN_WIDTH/1.8, SCREEN_HEIGHT/15.5-4)];
//        _textField.placeholder = @"输入消息";
        _textView.font = [UIFont systemFontOfSize:23];
        [view1 addSubview:_textView];
        
        _SendBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.21, SCREEN_HEIGHT/150, SCREEN_WIDTH/6.5, SCREEN_HEIGHT/15.5)];
        [_SendBtn setBackgroundImage:[UIImage imageNamed:@"enter"] forState:UIControlStateNormal];
        [_SendBtn setTitle:@"发送" forState:UIControlStateNormal];
//        _SendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_SendBtn setTintColor:[UIColor whiteColor]];
        [view1 addSubview:_SendBtn];
        
        //语音输入按钮
        _voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4.5, SCREEN_HEIGHT/150, SCREEN_WIDTH/1.3, SCREEN_HEIGHT/15.5)];
        [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"pressspeak"] forState:UIControlStateNormal];
        [_voiceBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        _voiceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _voiceBtn.tintColor = [UIColor whiteColor];
        [view1 addSubview:_voiceBtn];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT/13 + 2, SCREEN_WIDTH, _iconView.bounds.size.height - SCREEN_HEIGHT/13 - 2)];
        view2.backgroundColor = [UIColor whiteColor];
        [_iconView addSubview:view2];
        
#pragma mark - 语音输入状态图
        //语音输入状态图
        _stateView = [[UIImageView alloc]init];
        [_stateView setImage:[UIImage imageNamed:@"speak_tab"]];
        //语音输入取消图片
        _cancleView = [[UIImageView alloc]init];
        [_cancleView setImage:[UIImage imageNamed:@"speak_cancle"]];
        //语音输入失败图片
        _tooshotView = [[UIImageView alloc]init];
        [_tooshotView setImage:[UIImage imageNamed:@"speak_tooshot"]];
        //语音正在输入图片
        _microView = [[UIImageView alloc]init];
        [_microView setImage:[UIImage imageNamed:@"microphone"]];
        //音量图片
        _volumeView = [[UIImageView alloc]init];
        [_volumeView setImage:[UIImage imageNamed:@"volume_1"]];
#pragma mark - 下方按钮
        //图片按钮
        _PicBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/12.5, SCREEN_HEIGHT/40, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_PicBtn setImage:[UIImage imageNamed:@"gallery_n"] forState:UIControlStateNormal];
        [view2 addSubview:_PicBtn];
       [view2 addSubview:[self labelInitWithName:@"图片" With:CGRectMake(SCREEN_WIDTH/12.5-15, SCREEN_HEIGHT/10, SCREEN_WIDTH/8+30, 25)]];
        
        //拍照按钮
        _takePicBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3.15, SCREEN_HEIGHT/40, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_takePicBtn setImage:[UIImage imageNamed:@"camera_n"] forState:UIControlStateNormal];
        [view2 addSubview:_takePicBtn];
        [view2 addSubview:[self labelInitWithName:@"拍照" With:CGRectMake(SCREEN_WIDTH/3.15-15, SCREEN_HEIGHT/10, SCREEN_WIDTH/8+30, 25)]];
        
        //表情按钮
        _expressionBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.8, SCREEN_HEIGHT/40, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_expressionBtn setImage:[UIImage imageNamed:@"emotion_n"] forState:UIControlStateNormal];
        [view2 addSubview:_expressionBtn];
        [view2 addSubview:[self labelInitWithName:@"表情" With:CGRectMake(SCREEN_WIDTH/1.8-15, SCREEN_HEIGHT/10, SCREEN_WIDTH/8+30, 25)]];
        
        //地理位置按钮
        _LocationBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.25, SCREEN_HEIGHT/40, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_LocationBtn setImage:[UIImage imageNamed:@"location_n"] forState:UIControlStateNormal];
        [view2 addSubview:_LocationBtn];
        [view2 addSubview:[self labelInitWithName:@"地理位置" With:CGRectMake(SCREEN_WIDTH/1.25-15, SCREEN_HEIGHT/10, SCREEN_WIDTH/8+30, 25)]];
        
        //名片按钮
        _visitingCBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/12.5, view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_visitingCBtn setImage:[UIImage imageNamed:@"user_card_n"] forState:UIControlStateNormal];
        [view2 addSubview:_visitingCBtn];
        [view2 addSubview:[self labelInitWithName:@"名片" With:CGRectMake(SCREEN_WIDTH/12.5-15,view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2 + SCREEN_HEIGHT/13.5, SCREEN_WIDTH/8+30, 25)]];
        
        //我的收藏按钮
        _collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3.15, view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_collectionBtn setImage:[UIImage imageNamed:@"import_msg_n"] forState:UIControlStateNormal];
        [view2 addSubview:_collectionBtn];
        [view2 addSubview:[self labelInitWithName:@"我的收藏" With:CGRectMake(SCREEN_WIDTH/3.15-15,view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2 + SCREEN_HEIGHT/13.5, SCREEN_WIDTH/8+30, 25)]];
        
        //语音电话按钮
        _voiceCallBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.8, view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_voiceCallBtn setImage:[UIImage imageNamed:@"chat_voice_call_normal"] forState:UIControlStateNormal];
        [view2 addSubview:_voiceCallBtn];
        [view2 addSubview:[self labelInitWithName:@"语音电话" With:CGRectMake(SCREEN_WIDTH/1.8-15,view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2 + SCREEN_HEIGHT/13.5, SCREEN_WIDTH/8+30, 25)]];
        
        //视频通话按钮
        _videoPhoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.25, view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
        [_videoPhoneBtn setImage:[UIImage imageNamed:@"chat_video_call_normal"] forState:UIControlStateNormal];
        [view2 addSubview:_videoPhoneBtn];
        [view2 addSubview:[self labelInitWithName:@"视频通话" With:CGRectMake(SCREEN_WIDTH/1.25-15,view2.bounds.size.height/2 + SCREEN_HEIGHT/40/2 + SCREEN_HEIGHT/13.5, SCREEN_WIDTH/8+30, 25)]];
    }
    return self;
}
-(UILabel *)labelInitWithName:(NSString *)name With:(CGRect)rect{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.text = name;
//    label.backgroundColor = [UIColor cyanColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
