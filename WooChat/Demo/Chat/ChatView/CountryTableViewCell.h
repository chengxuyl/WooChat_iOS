//
//  CountryTableViewCell.h
//  WooChat
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *countryImageView;
@property (nonatomic, strong) UILabel *countryNameLabel;
@property (nonatomic, strong) UIImageView *voiceImage;

+(NSString *)cellIdentifier;
@end
