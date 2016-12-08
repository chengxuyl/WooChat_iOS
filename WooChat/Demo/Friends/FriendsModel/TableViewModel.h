//
//  TableViewModel.h
//  WooChat
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewModel : NSObject
//分区标题;
@property (nonatomic ,copy) NSArray *sectionTitles;
//好友列表;
@property (nonatomic ,copy) NSArray *contentsArray;
@end
