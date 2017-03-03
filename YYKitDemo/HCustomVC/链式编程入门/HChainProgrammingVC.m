//
//  HChainProgrammingVC.m
//  YYKitDemo
//
//  Created by HY on 2017/2/23.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HChainProgrammingVC.h"
#import "HButtonChain.h"
#import "CPView.h"

@interface HChainProgrammingVC ()

@end

@implementation HChainProgrammingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    HButtonChain *hButtonChain = [HButtonChain initialization]().rect(CGRectMake(20, 20, 100, 50)).bgColor([UIColor redColor]).normalTitle(@"hello");
    [hButtonChain jk_addActionHandler:^(NSInteger tag) {
        //
    }];
    [self.view addSubview:hButtonChain];
    UIView *cpView = [UIView new];
    
    [self.view addSubview:cpView];
    // Do any additional setup after loading the view.
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
