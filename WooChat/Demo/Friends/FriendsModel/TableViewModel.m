//
//  TableViewModel.m
//  WooChat
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "TableViewModel.h"

@implementation TableViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sectionTitles = [[NSArray alloc]initWithObjects:@"↑",@"☆",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"T",@"Z",@"#", nil];
        _contentsArray = [[NSArray alloc] initWithObjects:
                          @"阿伟",@"阿姨",@"阿三",
                          @"蔡芯",@"成龙",@"陈鑫",@"陈丹",@"成名",
                          @"芳仔",@"房祖名",@"方大同",@"芳芳",@"范伟",
                          @"郭靖",@"郭美美",@"过儿",@"过山车",
                          @"何仙姑",@"和珅",@"郝歌",@"好人",
                          @"妈妈",@"毛主席",
                          @"孙中山",@"沈冰",@"婶婶",
                          @"涛涛",@"淘宝",@"套娃",
                          @"小二",@"夏紫薇",@"许巍",@"许晴",
                          @"周恩来",@"周杰伦",@"张柏芝",@"张大仙",nil];
    }
    return self;
}
@end
