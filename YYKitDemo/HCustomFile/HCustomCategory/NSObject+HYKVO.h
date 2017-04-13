//
//  NSObject+HYKVO.h
//  YYKitDemo
//
//  Created by HY on 2017/4/13.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import <Foundation/Foundation.h>

//用法:常用的为对frame大小变化的观测
//[XXX LHaddObserver:@"frame" withBlock:^{
//    XXX 逻辑操作
//}];


typedef void (^HYHandler) ();

@interface NSObject (HYKVO)

- (void)LHaddObserver: (NSString *)key withBlock: (HYHandler)observedHandler;

- (void)HYRemoveAllObserver;

@end
