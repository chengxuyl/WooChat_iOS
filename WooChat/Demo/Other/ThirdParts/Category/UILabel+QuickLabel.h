//
//  UILabel+QuickLabel.h
//  MainPageSample
//
//  Created by lzhr on 14-4-24.
//  Copyright (c) 2014年 lizhongren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (QuickLabel)


+ (UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor superView:(UIView *)superView;


//高度自适应
- (void)heightAdaptive;

//宽度自适应
- (void)widthAdaptive;

//宽高自适应
- (void)autoSize;


@end
