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

//objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
//id object                     :表示关联者，是一个对象，变量名理所当然也是object
//const void *key               :获取被关联者的索引key
//id value                      :被关联者，这里是一个block
//objc_AssociationPolicy policy : 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC

- (void)tapWithEvent:(UIControlEvents)controEvent withBlock:(TapBlock)tapBlock{
    objc_setAssociatedObject(self, ButtonKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(btnClick:) forControlEvents:controEvent];
}

- (void)btnClick:(UIButton *)sender{
    //通过key获取被关联对象
    //objc_getAssociatedObject(id object, const void *key)
    TapBlock tapBlock = objc_getAssociatedObject(sender, ButtonKey);
    if (tapBlock) {
        tapBlock(sender);
    }
}
@end
