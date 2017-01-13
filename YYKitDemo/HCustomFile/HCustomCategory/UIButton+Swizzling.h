//
//  UIButton+Swizzling.h
//  YYKitDemo
//
//  Created by HY on 2017/1/13.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import <UIKit/UIKit.h>

//默认时间间隔
#define defaultInterval 1

@interface UIButton (Swizzling)
//点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook
@property (nonatomic, assign) BOOL isIgnore;
@end
