//
//  ChatBackGroundCollectionViewCell.h
//  WooChat
//
//  Created by qiubo on 2016/11/30.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatBackGroundCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *imageName;
- (void)showChoose:(BOOL)isSelect;
+ (NSString *)cellIdentifier;
@end
