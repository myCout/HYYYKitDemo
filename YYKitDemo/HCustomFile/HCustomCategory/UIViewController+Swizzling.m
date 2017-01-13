//
//  UIViewController+Swizzling.m
//  YYKitDemo
//
//  Created by HY on 2017/1/13.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "UIViewController+Swizzling.h"

@implementation UIViewController (Swizzling)

//为什么方法交换调用在+load方法中？
//
//在Objective-C runtime会自动调用两个类方法，分别为+load与+ initialize。+load 方法是在类被加载的时候调用的，也就是一定会被调用。而+initialize方法是在类或它的子类收到第一条消息之前被调用的，这里所指的消息包括实例方法和类方法的调用。也就是说+initialize方法是以懒加载的方式被调用的，如果程序一直没有给某个类或它的子类发送消息，那么这个类的+initialize方法是永远不会被调用的。此外+load方法还有一个非常重要的特性，那就是子类、父类和分类中的+load方法的实现是被区别对待的。换句话说在 Objective-C runtime自动调用+load方法时，分类中的+load方法并不会对主类中的+load方法造成覆盖。综上所述，+load 方法是实现 Method Swizzling 逻辑的最佳“场所”。
//为什么方法交换要在dispatch_once中执行？
//
//方法交换应该要线程安全，而且保证在任何情况下（多线程环境，或者被其他人手动再次调用+load方法）只交换一次，防止再次调用又将方法交换回来。除非只是临时交换使用，在使用完成后又交换回来。 最常用的解决方案是在+load方法中使用dispatch_once来保证交换是安全的。之前有读者反馈+load方法本身即为线程安全，为什么仍需添加dispatch_once，其原因就在于+load方法本身无法保证其中代码只被执行一次。
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillDisappear:) bySwizzledSelector:@selector(sure_viewWillDisappear:)];
    });
}

- (void)sure_viewWillDisappear:(BOOL)animated {
    [self sure_viewWillDisappear:animated];
//    [SVProgressHUD dismiss];
}

@end
