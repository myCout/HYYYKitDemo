//
//  NSObject+HYKVO.m
//  YYKitDemo
//
//  Created by HY on 2017/4/13.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "NSObject+HYKVO.h"
#import <objc/runtime.h>

#define objectAdress  ([NSString stringWithFormat:@"%ld",(long)((NSInteger)self)])

@interface NSObjectHYKVOManage:NSObject

@property (nonatomic, strong) NSMutableDictionary *kvoMumdict;

+ (instancetype)sharedManager;

@end




@implementation NSObjectHYKVOManage

+ (instancetype)sharedManager
{
    static NSObjectHYKVOManage *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[[self class] alloc] init];
        _sharedManager.kvoMumdict = [NSMutableDictionary dictionary];
    });
    return _sharedManager;
}
@end

@implementation NSObject (HYKVO)
+ (void)load{
    NSLog(@"load:%@",[self class]);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"dealloc"];
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"sd_" stringByAppendingString:selString];
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

-(void)LHaddObserver: (NSString *)key withBlock: (HYHandler)observedHandler{
    @synchronized(self){
        NSMutableDictionary*dict =  [[NSObjectHYKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
        if (!dict) {
            dict = [NSMutableDictionary new];
        }else{
            if ([dict objectForKey:key]) {
                [self LHRemoveObserver:key];
            }
        }
        @weakify(self);
        @strongify(self);
        [dict setObject:observedHandler forKey:key];
        [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        [[NSObjectHYKVOManage sharedManager].kvoMumdict setObject:dict forKey:objectAdress];
    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSMutableDictionary*dict =  [[NSObjectHYKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
    if (dict) {
        HYHandler hander = [dict objectForKey:keyPath];
        if(hander){
            hander();
        }
    }
}

- (void)LHRemoveObserver: (NSString *)key{
    @try {
        
        NSMutableDictionary*dict =  [[NSObjectHYKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
        [dict removeObjectForKey:key];
        [self removeObserver:self forKeyPath:key];
    }
    @catch (NSException *exception) {
        NSLog(@"多次删除了");
    }
    
}

- (void)HYRemoveAllObserver{
    NSMutableDictionary*dict =  [[NSObjectHYKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
    if (dict) {
        NSArray*keys = [dict allKeys];
        for (NSString*key in keys) {
            [self LHRemoveObserver:key];
            NSLog(@"dealloc_key:%@",key);
        }
    }
    [[NSObjectHYKVOManage sharedManager].kvoMumdict  removeObjectForKey:objectAdress];
}
-(void)sd_dealloc{
    NSMutableDictionary*dict =  [[NSObjectHYKVOManage sharedManager].kvoMumdict objectForKey:objectAdress];
    if (dict) {
        [[NSObjectHYKVOManage sharedManager].kvoMumdict  removeObjectForKey:objectAdress];
        @synchronized(self){
            NSArray*keys = [dict allKeys];
            for (NSString*key in keys) {
                [self LHRemoveObserver:key];
                //                NSLog(@"dealloc_key:%@",key);
            }
        }
    }
    [self sd_dealloc];
}


@end
