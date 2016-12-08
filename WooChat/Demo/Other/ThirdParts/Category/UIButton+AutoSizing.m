//
//  UIButton+AutoSizing.m
//  采购师_iOS
//
//  Created by Selfmaking on 16/1/2.
//  Copyright © 2016年 cgs. All rights reserved.
//

#import "UIButton+AutoSizing.h"

@implementation UIButton (AutoSizing)
- (void)autoSize {
    [self widthAdaptive];
    [self heightAdaptive];
}

- (void)heightAdaptive
{
    //设置文本高自适应
    CGRect rect=[self.currentTitle boundingRectWithSize:CGSizeMake(self.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName, nil] context:nil];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.size.height+10);
}

//宽度自适应
- (void)widthAdaptive
{
    //设置文本宽自适应
    CGRect rect=[self.currentTitle boundingRectWithSize:CGSizeMake(10000, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName, nil] context:nil];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width+10, self.frame.size.height);
}


@end
