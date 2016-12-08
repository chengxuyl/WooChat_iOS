//
//  UILabel+QuickLabel.m
//  MainPageSample
//
//  Created by lzhr on 14-4-24.
//  Copyright (c) 2014年 lizhongren. All rights reserved.
//

#import "UILabel+QuickLabel.h"

@implementation UILabel (QuickLabel)

+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor superView:(UIView *)superView
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    
    if (font) {
        label.font = font;
    }
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    label.textAlignment = textAlignment;
    [superView addSubview:label];
    
    return label;
}

- (void)autoSize {
    [self widthAdaptive];
    [self heightAdaptive];
}

- (void)heightAdaptive
{
    self.numberOfLines=0;
    //设置文本高自适应
    CGRect rect=[self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.size.height);
}

//宽度自适应
- (void)widthAdaptive
{
    //设置文本宽自适应
    CGRect rect=[self.text boundingRectWithSize:CGSizeMake(10000, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil] context:nil];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, self.frame.size.height);
}



@end
