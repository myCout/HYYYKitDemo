//
//  HThreeVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/11.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HThreeVC.h"

@implementation HThreeVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"我的";    //✅sets navigation bar title.The right way to set the title of the navigation
//    self.tabBarItem.title = @"我的23333";   //❌sets tab bar title. Even the `tabBarItem.title` changed, this will be ignored in tabbar.
//    self.title = @"我的1";                //❌sets both of these. Do not do this‼️‼️ This may cause
}

@end
