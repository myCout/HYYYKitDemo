//
//  ViewController.m
//  YYKitDemo
//
//  Created by HY on 16/7/13.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "ViewController.h"
#import "YYKit.h"
#import "HYNetworkManager.h"
@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self btnInit];
}


-(void)btnInit{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 0, 100, 100)];
    //    btn.titleLabel.text = @"TTTT";
    [btn setTitle:@"测试按钮" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(ttttClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)ttttClick{
    [[HYNetworkManager sharedInstance] httpGetRequest:@"/data/sk/101010100.html" params:nil onCompletionBlock:^(NSString *error, NSDictionary *resposeData) {
        if (!error) {
            NSLog(@"resposeData = %@",resposeData);
        }else{
            NSLog(@"error = %@",error);
        }
    }];
}
#pragma mark - CustomDelegate

#pragma mark - Event response

#pragma mark - Private methods

#pragma mark - Getters and setters
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
