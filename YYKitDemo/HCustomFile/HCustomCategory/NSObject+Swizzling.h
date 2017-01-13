//
//  NSObject+Swizzling.h
//  ProjectRefactoring
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;
//用法
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
//                               bySwizzledSelector:@selector(sure_reloadData)];
//    });
//}


//SEL、Method、IMP的含义及区别
//
//在运行时，类（Class）维护了一个消息分发列表来解决消息的正确发送。每一个消息列表的入口是一个方法（Method），这个方法映射了一对键值对，其中键是这个方法的名字（SEL），值是指向这个方法实现的函数指针 implementation（IMP）。
//伪代码表示：
//
//Class {
//    MethodList (
//                Method{
//                    SEL:IMP；
//                }
//                Method{
//                    SEL:IMP；
//                }
//                );
//};
//Method Swizzling就是改变类的消息分发列表来让消息解析时从一个选择器（SEL）对应到另外一个的实现（IMP），同时将原始的方法实现混淆到一个新的选择器（SEL）。
@end
