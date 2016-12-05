//
//  UIButton+Block.m
//  YYKitDemo
//
//  Created by HY on 2016/12/5.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "UIButton+Block.h"
static const void *ButtonKey = &ButtonKey;
@implementation UIButton (Block)

- (void)tapWithEvent:(UIControlEvents)controEvent withBlock:(TapBlock)tapBlock{
    objc_setAssociatedObject(self, ButtonKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnClick:) forControlEvents:controEvent];
}

- (void)btnClick:(UIButton *)sender{
    TapBlock tapBlock = objc_getAssociatedObject(sender, ButtonKey);
    if (tapBlock) {
        tapBlock(sender);
    }
}
@end
