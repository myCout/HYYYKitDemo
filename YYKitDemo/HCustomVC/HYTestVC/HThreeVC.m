//
//  HThreeVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/11.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HThreeVC.h"
#import "ViewController.h"
@implementation HThreeVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"我的";    //✅sets navigation bar title.The right way to set the title of the navigation
//    self.tabBarItem.title = @"我的23333";   //❌sets tab bar title. Even the `tabBarItem.title` changed, this will be ignored in tabbar.
//    self.title = @"我的1";                //❌sets both of these. Do not do this‼️‼️ This may cause
    
//    self.view.backgroundColor = [UIColor randomColor];
//    self.navigationController.navigationBarHidden = YES;
    // 模仿网络延迟，0.2秒后，才知道有多少标题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 移除之前所有子控制器
        [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
        
        // 把对应标题保存到控制器中，并且成为子控制器，才能刷新
        // 添加所有新的子控制器
        [self setUpAllViewController];
        
        // 注意：必须先确定子控制器
        [self refreshDisplay];
        
    });
    
//    /*  设置标题渐变：标题填充模式 */
//    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
//        // 标题填充模式
//        *titleColorGradientStyle = YZTitleColorGradientStyleRGB;
//    }];
    /*************************************/
    // 推荐方式（设置下标） 下划线方式
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        // 标题填充模式
        *underLineColor = [UIColor redColor];
    }];
    /*************************************/
    
//    /*************************************/
//    // 标题渐变
//    // *推荐方式(设置标题渐变) + 下划线
//    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
//        
//    }];
//    
//    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
//        //        *isUnderLineDelayScroll = YES;
//        *isUnderLineEqualTitleWidth = YES;
//    }];
//    /*************************************/
    // 还有一种腾讯视频样式，参考原版demo
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 段子
    ViewController *wordVc1 = [[ViewController alloc] init];
    wordVc1.title = @"小码哥吖了个峥吖了个峥吖了个峥";
    [self addChildViewController:wordVc1];
    
    // 段子
    ViewController *wordVc2 = [[ViewController alloc] init];
    wordVc2.title = @"M了个J吖了个峥吖了个峥";
    [self addChildViewController:wordVc2];
    
    // 段子
    ViewController *wordVc3 = [[ViewController alloc] init];
    wordVc3.title = @"啊峥吖了个峥";
    [self addChildViewController:wordVc3];
    
//    ViewController *wordVc4 = [[ViewController alloc] init];
//    wordVc4.title = @"吖了个峥";
//    [self addChildViewController:wordVc4];
//    
//    ViewController *wordVc5 = [[ViewController alloc] init];
//    wordVc5.title = @"吖了个峥";
//    [self addChildViewController:wordVc5];
//    
//    ViewController *wordVc6 = [[ViewController alloc] init];
//    wordVc6.title = @"吖了个峥";
//    [self addChildViewController:wordVc6];
}
@end
