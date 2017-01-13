//
//  UINavigationItem+Swizzling.m
//  YYKitDemo
//
//  Created by HY on 2017/1/13.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "UINavigationItem+Swizzling.h"
static char *kCustomBackButtonKey;
@implementation UINavigationItem (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(backBarButtonItem)
                               bySwizzledSelector:@selector(sure_backBarButtonItem)];
        
    });
}

- (UIBarButtonItem*)sure_backBarButtonItem {
    UIBarButtonItem *backItem = [self sure_backBarButtonItem];
    if (backItem) {
        return backItem;
    }
    backItem = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!backItem) {
        backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, backItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backItem;
}

@end
