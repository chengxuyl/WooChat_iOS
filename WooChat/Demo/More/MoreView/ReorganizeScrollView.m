//
//  ReorganizeScrollView.m
//  WooChat
//
//  Created by yuling on 16/11/15.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ReorganizeScrollView.h"

@implementation ReorganizeScrollView
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
