//
//  HButtonChain.m
//  YYKitDemo
//
//  Created by HY on 2017/2/23.
//  Copyright © 2017年 郝毅. All rights reserved.
//

//@property (nonatomic, copy, readonly) Person *(^name)(NSString *);
//
//-(Person *(^)(CGFloat))height;
//-(Person *(^)(NSUInteger))age;
//- (Person *(^)(NSString *))name {
//    return ^(NSString *value) {
//        NSLog(@"您的名字是：%@", value);
//        return self;
//    };
//}
//
//-(Person *(^)(CGFloat))height {
//    return ^(CGFloat value) {
//        NSLog(@"您的身高是：%.2f", value);
//        return self;
//    };
//}

#import "HButtonChain.h"

@implementation HButtonChain

+(HButtonChain *(^)(void))initialization {
    return ^id(void) {
        return [HButtonChain buttonWithType:UIButtonTypeCustom];
    };
}

-(HButtonChain *(^)(CGRect))rect {
    return ^id(CGRect rect) {
        return [self addRect:rect];
    };
}

-(HButtonChain *(^)(UIColor *))bgColor {
    return ^id(UIColor * color) {
        return [self addBgColor:color];
    };
}

-(HButtonChain *(^)(NSString *))normalTitle {
    return ^id(NSString * title) {
        return [self addNormalTitle:title];
    };
}

-(HButtonChain *(^)(NSString *))selectTitle {
    return ^id(NSString * title) {
        return [self addSelectTitle:title];
    };
}

-(HButtonChain *(^)(id, SEL))action {
    return ^id(id object, SEL method) {
        return [self addTarget:object action:method];
    };
}

/*-------------------------分割线----------------------------*/
-(HButtonChain *)addRect:(CGRect)rect {
    self.frame = rect;
    return self;
}

-(HButtonChain *)addBgColor:(UIColor *)bgColor {
    self.backgroundColor = bgColor;
    return self;
}

-(HButtonChain *)addNormalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    return self;
}

-(HButtonChain *)addSelectTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateSelected];
    return self;
}

-(HButtonChain *)addTarget:(id)object action:(SEL)action {
    [self addTarget:object action:action forControlEvents:UIControlEventTouchUpInside];
    return self;
}

@end
