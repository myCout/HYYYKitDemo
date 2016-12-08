//
//  HBulletManager.h
//  YYKitDemo
//
//  Created by HY on 2016/12/7.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HBulletView;

typedef void(^HGenerateViewBlock)(HBulletView *view);



@interface HBulletManager : NSObject

@property (nonatomic) HGenerateViewBlock hGenerateViewBlock;


//弹幕开始执行
- (void)start;
//弹幕停止执行
- (void)stop;

@end
