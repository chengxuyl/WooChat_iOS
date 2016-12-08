//
//  ContactsTableViewCell.m
//  WooChat
//
//  Created by qiubo on 2016/11/23.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "ContactsTableViewCell.h"
#import "AddressBookModel.h"
@interface ContactsTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *typeBtn;
@end
@implementation ContactsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.typeBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(20, 10, self.contentView.height - 20, self.contentView.height - 20);
    self.iconImageView.layer.cornerRadius = (self.contentView.height - 20)/2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor = [UIColor redColor];
    
    self.nameLabel.frame = CGRectMake(self.iconImageView.right +20, 0, SCREEN_WIDTH/2, 30);
    self.nameLabel.centerY = self.contentView.centerY;
    
    self.typeBtn.frame = CGRectMake(SCREEN_WIDTH - 70, 0, 50, 30);
    self.typeBtn.centerY = self.contentView.centerY;
    self.typeBtn.layer.cornerRadius = 5;
    self.typeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.typeBtn addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - private method
- (void)btnClicked:(UIButton *)btn{
    [self.delegate typeBtnClickedBtn:btn tableViewCell:self];
}
#pragma mark - setters and getters
- (void)setMod:(AddressBookModel *)mod{
    if (_mod != mod) {
        _mod = mod;
        self.nameLabel.text = self.mod.name;
    }
}
- (void)setCelltype:(CellType )celltype{
    //CellTypeIsAdd = 1,//已添加
//    CellTypeAdd = 2,//添加
//    CellTypeInvite = 3,//邀请
    if (_celltype != celltype) {
        _celltype = celltype;
        switch (celltype) {
            case CellTypeIsAdd:
                self.typeBtn.backgroundColor = [UIColor whiteColor];
                [self.typeBtn setTitle:@"已添加" forState:(UIControlStateNormal)];
                [self.typeBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
//                self.typeBtn.backgroundColor = MYCOLOR_BLUE;
//                [self.typeBtn setTitle:@"聊天" forState:(UIControlStateNormal)];
//                [self.typeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                break;
            case CellTypeAdd:
                self.typeBtn.backgroundColor = MYCOLOR_BLUE;
                [self.typeBtn setTitle:@"添加" forState:(UIControlStateNormal)];
                [self.typeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                break;
            case CellTypeInvite:
                self.typeBtn.backgroundColor = MYCOLOR_BLUE;
                [self.typeBtn setTitle:@"邀请" forState:(UIControlStateNormal)];
                [self.typeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
                break;
                
            default:
                break;
        }
    }
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}

- (UIButton *)typeBtn{
    if (!_typeBtn) {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _typeBtn;
}

+ (NSString *)cellIdentifier{
    return @"ContactsTableViewCell";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
