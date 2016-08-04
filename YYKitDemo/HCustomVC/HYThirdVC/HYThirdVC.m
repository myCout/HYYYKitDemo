//
//  HYThirdVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/4.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYThirdVC.h"
#import "HEmailTextField.h"

@interface HYThirdVC ()

@property (nonatomic, retain) HEmailTextField *hTextField;

@end

@implementation HYThirdVC

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.hTextField];
}


- (HEmailTextField*)hTextField{
    if (_hTextField == nil) {
        _hTextField = [[HEmailTextField alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 44) InView:self.view];
        _hTextField.placeholder = @"输入用户邮箱";
        _hTextField.backgroundColor = [UIColor lightGrayColor];
    }
    return _hTextField;
}
@end
