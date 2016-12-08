//
//  HBulletVC.m
//  YYKitDemo
//
//  Created by HY on 2016/12/7.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HBulletVC.h"
#import "HBulletView.h"
#import "HBulletManager.h"

@interface HBulletVC ()

@property (nonatomic, retain) HBulletManager *hManager;

@end

@implementation HBulletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hManager = [HBulletManager new];
    __weak typeof(self) mySelf = self;
    self.hManager.hGenerateViewBlock = ^(HBulletView *view){
        [mySelf addBulletView:view];
    };
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"Start" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn jk_addActionHandler:^(NSInteger tag) {
        [self.hManager start];
    }];
    [self.view addSubview:btn];
}

- (void)addBulletView:(HBulletView *)view{
    view.frame = CGRectMake(SCREEN_WIDTH, 300 +view.trajectory*40, view.width, view.height);
    [self.view addSubview:view];
    [view startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
