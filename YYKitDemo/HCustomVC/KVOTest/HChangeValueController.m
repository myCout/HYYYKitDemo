//
//  HChangeValueController.m
//  YYKitDemo
//
//  Created by HY on 2017/1/17.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HChangeValueController.h"

@interface HChangeValueController ()

@end

@implementation HChangeValueController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GCDQueue executeInMainQueue:^{
        _model.title = @"1111";
    } afterDelaySecs:2];
    
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
