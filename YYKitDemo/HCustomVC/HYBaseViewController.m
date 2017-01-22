//
//  HYBaseViewController.m
//  YYKitDemo
//
//  Created by HY on 16/7/28.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYBaseViewController.h"

@implementation HYBaseViewController
- (void) viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"viewDidLoad: %@",[self class]);
//    NSLog(@"parentViewController%@",self.parentViewController.class);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
