//
//  HSidePullMenuVC.m
//  YYKitDemo
//
//  Created by HY on 2017/3/1.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HSidePullMenuVC.h"

@implementation HSidePullMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.leftView];
    [GCDQueue executeInMainQueue:^{
        self.leftView.hidden = NO;
    } afterDelaySecs:.5];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (TogetherMainView *)mainView
{
    if (_mainView == nil) {
        _mainView = [[TogetherMainView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _mainView;
}

- (TogetherLeftView *)leftView
{
    if (_leftView == nil) {
        _leftView = [[TogetherLeftView alloc] initWithFrame:CGRectMake(-LEFTVIEWWIDTH, 0, LEFTVIEWWIDTH, [UIScreen mainScreen].bounds.size.height)];
        _leftView.hidden = YES;
    }
    return _leftView;
}
@end
