//
//  OriginalPhoViewController.h
//  WooChat
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^returnBlock)(NSArray *picArr);
@interface OriginalPhoViewController : UIViewController
@property NSMutableArray *picArr;
@property (nonatomic, copy) returnBlock returnPicBlock;
- (void)returnPicArr:(returnBlock)block;
@end
