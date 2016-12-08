//
//  OriginalPhoView.h
//  WooChat
//
//  Created by apple on 16/9/19.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OriginalPhoView : UIView
//下方按钮条
@property UIView *toolView;
//原图选择图片
@property UIImageView *picImageView;
//原图大小label
@property UILabel *picSize;
//原图按钮
@property UIButton *picBtn;
//选择按钮
@property UIButton *selectedBtn;
//选择图片
@property UIImageView *selectedImageView;
@end
