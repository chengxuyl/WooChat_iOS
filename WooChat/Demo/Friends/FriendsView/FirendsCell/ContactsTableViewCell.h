//
//  ContactsTableViewCell.h
//  WooChat
//
//  Created by qiubo on 2016/11/23.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CellType){
    CellTypeIsAdd = 1,//已添加
    CellTypeAdd = 2,//添加
    CellTypeInvite = 3,//邀请
};
@class AddressBookModel;
@class ContactsTableViewCell;
@protocol ContactsTableViewCellDelegate <NSObject>

- (void)typeBtnClickedBtn:(UIButton *)btn tableViewCell:(ContactsTableViewCell *)tableViewCell;

@end
@interface ContactsTableViewCell : UITableViewCell
@property (nonatomic, assign) CellType celltype;
@property (nonatomic, strong) AddressBookModel *mod;
@property (nonatomic, assign) id<ContactsTableViewCellDelegate> delegate;
+ (NSString *)cellIdentifier;
@end
