//
//  VKDebugJPExtension.m
//  VKDebugConsoleDemo
//
//  Created by Awhisper on 16/5/27.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VKDevJPExtension.h"
#import <UIKit/UIKit.h>
@implementation VKDevJPExtension

+ (void)main:(JSContext *)context
{
    context[@"getSuperView"] = ^(JSValue *viewJS) {
        UIView *viewOC = [VKJPExtension formatJSToOC:viewJS];
        UIView *superViewOC = [VKDevJPExtension getViewSuperView:viewOC];
        return [self formatOCToJS:superViewOC];
    };
    
    context[@"getParentVC"] = ^(JSValue *viewJS) {
        UIView *viewOC = [VKJPExtension formatJSToOC:viewJS];
        UIViewController *parentVCOC = [VKDevJPExtension getViewParentViewController:viewOC];
        return [self formatOCToJS:parentVCOC];
    };
    
    context[@"getTargetVC"] = ^(JSValue *viewJS) {
        UIView *target = [self getJPTarget];
        UIViewController *parentVCOC = [VKDevJPExtension getViewParentViewController:target];
        return [self formatOCToJS:parentVCOC];
    };
    
    context[@"print"] = ^(JSValue *obj) {
        id target = [VKJPExtension formatJSToOC:obj];
        [self printObject:target];
    };
    
    
    context[@"changeSelect"] = ^(){
        [self postCommand:@"changeSelect"];
    };
    
    context[@"exit"] = ^(){
        [self postCommand:@"exit"];
    };
    
    context[@"clearOutput"] = ^(){
        [self postCommand:@"clearOutput"];
    };
    context[@"clearInput"] = ^(){
        [self postCommand:@"clearInput"];
    };
}

+(UIView *)getViewSuperView:(UIView *)view;
{
    return view.superview;
}

+(UIViewController *)getViewParentViewController:(UIView *)view;
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+(void)postCommand:(NSString *)command
{
    [VKJPExtension excuteCommandHandler:command];
}

+(void)printObject:(id)obj
{
    NSString *vkPrint = @"Print:";
    [VKJPExtension excuteLogHandler:vkPrint];
    [self printClassInfo:obj];

    if ([obj isKindOfClass:[UILabel class]]) {
        UILabel * lb = (UILabel *)obj;
        NSString *text = [NSString stringWithFormat:@"Label.text = %@",lb.text];
        [VKJPExtension excuteLogHandler:text];
        return;
    }
    
    if ([obj isKindOfClass:[UIView class]]) {
        UIView * lb = (UIView *)obj;
        CGRect frame = lb.frame;
        NSString *text = [NSString stringWithFormat:@"View.frame = x:%@,y:%@,w:%@,h:%@",@(frame.origin.x),@(frame.origin.y),@(frame.size.width),@(frame.size.height)];
        [VKJPExtension excuteLogHandler:text];
        return;
    }
    
    NSString *description = [obj description];
    [VKJPExtension excuteLogHandler:description];
}

+(void)printClassInfo:(id)obj{
    Class clz = [obj class];
    NSString *clzname = NSStringFromClass(clz);
    NSString *clzlog = [NSString stringWithFormat:@"Class Name is %@",clzname];
    [VKJPExtension excuteLogHandler:clzlog];
}
@end
