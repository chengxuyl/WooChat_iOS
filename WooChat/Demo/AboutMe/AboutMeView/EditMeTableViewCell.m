//
//  EditMeTableViewCell.m
//  WooChat
//
//  Created by yuling on 16/11/14.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "EditMeTableViewCell.h"

@interface EditMeTableViewCell ()
@property (nonatomic, strong) UIImageView *picImageView;
@end
@implementation EditMeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.descripLabel];
        [self.contentView addSubview:self.picImageView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.titleLabel.frame = CGRectMake(20, 0, self.contentView.width/2-20, 50);
    self.titleLabel.centerY = self.contentView.centerY;
    
    self.descripLabel.frame = CGRectMake(self.contentView.width/2, self.titleLabel.y, self.contentView.width - self.titleLabel.right -20, self.titleLabel.height);
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.height - 0.5, self.contentView.width, 0.5)];
    line.backgroundColor = MYCOLOR_Line;
    [self.contentView addSubview:line];
    
    
    //cell类型
    if ([self.cellType isEqualToString:@"pic"]) {
        
        self.descripLabel.hidden = YES;
        self.picImageView.hidden = NO;
        self.picImageView.frame = CGRectMake(self.contentView.width - 20 -self.contentView.height + 30, 15, self.contentView.height - 30, self.contentView.height - 30);
        self.picImageView.image = [UIImage imageNamed:@"icon_wo_qrcode"];
    }else if ([self.cellType isEqualToString:@"icon"]){
        self.picImageView.frame = CGRectMake(self.contentView.width - 20 -self.contentView.height + 40, 20, self.contentView.height - 40, self.contentView.height - 40);
        self.picImageView.layer.cornerRadius = self.picImageView.width /2;
        self.picImageView.layer.masksToBounds = YES;
        self.descripLabel.hidden = YES;
        self.picImageView.hidden = NO;
        self.picImageView.backgroundColor = [UIColor redColor];
    }else{
        self.descripLabel.hidden = NO;
        self.picImageView.hidden = YES;
    }
}

#pragma mark - setters and getters
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)descripLabel{
    if (!_descripLabel) {
        _descripLabel = [UILabel new];
        _descripLabel.textColor = MYCOLOR_GRAY;
        _descripLabel.text = @"未填写";
        _descripLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descripLabel;
}

- (UIImageView *)picImageView{
    if (!_picImageView) {
        _picImageView = [UIImageView new];
    }
    return _picImageView;
}

+ (NSString *)cellIdentifier{
    return @"EditMeTableViewCell";
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
