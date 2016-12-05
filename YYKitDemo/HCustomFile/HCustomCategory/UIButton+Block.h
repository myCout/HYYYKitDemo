//
//  UIButton+Block.h
//  YYKitDemo
//
//  Created by HY on 2016/12/5.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^TapBlock)(UIButton *sender);

@interface UIButton (Block)

- (void)tapWithEvent:(UIControlEvents)controEvent withBlock:(TapBlock)tapBlock;

@end
