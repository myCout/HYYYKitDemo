//
//  CPView.m
//  YYKitDemo
//
//  Created by HY on 2017/2/24.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "CPView.h"

@implementation CPView

+(CPView *(^)(void))initialization {
    return ^id(void) {
        return [[CPView alloc] init];
    };
}

-(CPView *(^)(CGRect))rect {
    return ^id(CGRect rect) {
        return [self addRect:rect];
    };
}

-(CPView *(^)(UIColor *))bgColor{
    return ^id(UIColor *color){
        return [self addBgColor:color];
    };
}

//-(HButtonChain *(^)(UIColor *))bgColor {
//    return ^id(UIColor * color) {
//        return [self addBgColor:color];
//    };
//}
/*-------------------------分割线----------------------------*/
-(CPView *)addRect:(CGRect)rect {
    self.frame = rect;
    return self;
}

-(CPView *)addBgColor:(UIColor *)bgColor {
    self.backgroundColor = bgColor;
    return self;
}

@end
