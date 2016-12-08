//
//  SearchConditionViewController.m
//  WooChat
//
//  Created by qiubo on 2016/11/18.
//  Copyright © 2016年 Qubeon. All rights reserved.
//

#import "SearchConditionViewController.h"
#import "ReorganizeScrollView.h"
@interface SearchConditionViewController ()
@property (nonatomic, strong) ReorganizeScrollView *scrollView;
@end

@implementation SearchConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"按条件查找";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    
    UILabel *contryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5, 98.0f/750.0f*SCREEN_WIDTH)];
}


#pragma mark - setters and getters 
- (ReorganizeScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[ReorganizeScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(0, 300);
    }
    return _scrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
