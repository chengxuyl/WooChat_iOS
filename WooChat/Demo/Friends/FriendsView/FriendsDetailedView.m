//
//  FriendsDetailedView.m
//  WooChat
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "FriendsDetailedView.h"

@implementation FriendsDetailedView

- (instancetype)initWithName:(NSString *)name With:(NSString *)Signature With:(NSString *) telephoneNomber With:(NSString *)region
{
    self = [super init];
    if (self) {
        //背景
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2.6)];
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:_backgroundView.frame];
        backgroundImageView.backgroundColor = [UIColor redColor];
        [_backgroundView addSubview:backgroundImageView];
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/20, SCREEN_HEIGHT/2.6 - SCREEN_WIDTH/6/2, SCREEN_WIDTH/6, SCREEN_WIDTH/6)];
        headView.backgroundColor = [UIColor whiteColor];
        headView.layer.cornerRadius = SCREEN_WIDTH/6/2.0;
        [backgroundImageView addSubview:headView];
        
        //头像
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(1,1,headView.bounds.size.width-2,headView.bounds.size.height-2)];
        headImageView.layer.cornerRadius = (headView.bounds.size.width-2)/2.0;
        headImageView.backgroundColor = [UIColor blueColor];
        [headView addSubview:headImageView];
        
        //名字
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/2.55, SCREEN_WIDTH/3, 25)];
        nameLabel.text = name;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [_backgroundView addSubview:nameLabel];
        
        //备注
        UILabel *remarksLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/2.35, SCREEN_WIDTH/3, 25)];
        remarksLabel.text = name;
        remarksLabel.textAlignment = NSTextAlignmentLeft;
        remarksLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        remarksLabel.font = [UIFont systemFontOfSize:16];
        [_backgroundView addSubview:remarksLabel];
        
        //按钮条
        UIView *BtnView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/5, SCREEN_WIDTH, SCREEN_HEIGHT/5)];
        BtnView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [_backgroundView addSubview:BtnView];
        
        //线
        UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/5, SCREEN_WIDTH, 1)];
        line5.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [_backgroundView addSubview:line5];
        
        UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/5 - SCREEN_HEIGHT/12, SCREEN_WIDTH, 1)];
        line4.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [_backgroundView addSubview:line4];
        
        UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/5 - SCREEN_HEIGHT/12*2, SCREEN_WIDTH, 1)];
        line3.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [_backgroundView addSubview:line3];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/5 - SCREEN_HEIGHT/12*3, SCREEN_WIDTH, 1)];
        line2.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [_backgroundView addSubview:line2];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - SCREEN_HEIGHT/5 - SCREEN_HEIGHT/12*4, SCREEN_WIDTH, 1)];
        line1.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [_backgroundView addSubview:line1];
        
        //更多
        UILabel *Label1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/14, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12*4, SCREEN_WIDTH/4.5, 25)];
        Label1.text = @"个性签名";
        Label1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [_backgroundView addSubview:Label1];
        
        UILabel *Label1R = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12*4, SCREEN_WIDTH/2, 25)];
        Label1R.text = Signature;
        Label1R.textColor = [UIColor blackColor];
        [_backgroundView addSubview:Label1R];
        
        //电话号码
        UILabel *Label2 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/14, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12*3, SCREEN_WIDTH/4.5, 25)];
        Label2.text = @"电话号码";
        Label2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [_backgroundView addSubview:Label2];
        
        UILabel *Label2R = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12*3, SCREEN_WIDTH/2, 25)];
        Label2R.text = telephoneNomber;
        Label2R.textColor = [UIColor blackColor];
        [_backgroundView addSubview:Label2R];
        //地区
        UILabel *Label3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/14, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12*2, SCREEN_WIDTH/4.5, 25)];
        Label3.text = @"地区";
        Label3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [_backgroundView addSubview:Label3];
        
        UILabel *Label3R = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12*2, SCREEN_WIDTH/2, 25)];
        Label3R.text = region;
        Label3R.textColor = [UIColor blackColor];
        [_backgroundView addSubview:Label3R];
        //更多
        UILabel *Label4 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/14, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12, SCREEN_WIDTH/4.5, 25)];
        Label4.text = @"更多";
        Label4.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        [_backgroundView addSubview:Label4];
        
        UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/1.18, SCREEN_HEIGHT - SCREEN_HEIGHT/5.7 - SCREEN_HEIGHT/12, SCREEN_WIDTH/11, SCREEN_HEIGHT/32)];
        [imageView4 setImage:[UIImage imageNamed:@"more"]];
        [_backgroundView addSubview:imageView4];
        
//        _btn1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/15, SCREEN_HEIGHT/50, SCREEN_WIDTH/6, SCREEN_WIDTH/6)];
//        btn1 setImage:[UIImage imageNamed:<#(nonnull NSString *)#>];
    }
    return self;
}
@end
