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
#import "UIImageView+WebCache.h"
#import "YYFPSLabel.h"
@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    YYFPSLabel *fps = [YYFPSLabel new];
    fps.top = 64;
    [self.view addSubview:fps];
    
    [self btnInit];
}


-(void)btnInit{
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 0, 100, 100)];
//    //    btn.titleLabel.text = @"TTTT";
//    [btn setTitle:@"测试按钮" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor greenColor];
//    [btn addTarget:self action:@selector(ttttClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    NSString *imgUrl = @"https://git.oschina.net/haonie/HYImg/raw/master/111.jpeg";
//
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
//    imgV.contentMode = UIViewContentModeScaleAspectFill;
//    [imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
    [imgV setImageWithURL:[NSURL URLWithString:imgUrl] placeholder:nil];
    [self.view addSubview:imgV];
//
    NSString *imgUrl2 = @"https://git.oschina.net/haonie/HYImg/raw/master/112.jpeg";
    UIImageView *imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(imgV.right + 10, 20, 100, 100)];
//    imgV2.contentMode = UIViewContentModeScaleAspectFill;
    [imgV2 setImageWithURL:[NSURL URLWithString:imgUrl2] placeholder:nil];
    [self.view addSubview:imgV2];
//
//    NSString *imgUrl3 = @"https://git.oschina.net/haonie/HYImg/raw/master/113.jpeg";
//    UIImageView *imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(imgV2.right + 10, 20, 100, 100)];
////    imgV3.contentMode = UIViewContentModeScaleAspectFill;
//    [imgV3 setImageWithURL:[NSURL URLWithString:imgUrl3] placeholder:nil];
//    [self.view addSubview:imgV3];
//    
//    NSString *imgUrl4 = @"https://git.oschina.net/haonie/HYImg/raw/master/114.jpeg";
//    UIImageView *imgV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 250 + 20, 300, 200)];
//    //    imgV3.contentMode = UIViewContentModeScaleAspectFill;
//    [imgV4 setImageWithURL:[NSURL URLWithString:imgUrl4] placeholder:nil];
//    [self.view addSubview:imgV4];
    
    
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
