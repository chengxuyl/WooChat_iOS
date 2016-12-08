//
//  FriendsDetailedView.h
//  WooChat
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsDetailedView : UIView
- (instancetype)initWithName:(NSString *)name With:(NSString *)Signature With:(NSString *) telephoneNomber With:(NSString *)region;
@property UIView *backgroundView;
@property UIImageView *btn1;
@property UIImageView *btn2;
@property UIImageView *btn3;
@end
