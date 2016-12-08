//
//  PhoCollectionViewCell.h
//  WooChat
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property BOOL select;
@end
