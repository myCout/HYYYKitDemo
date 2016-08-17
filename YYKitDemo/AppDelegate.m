//
//  AppDelegate.m
//  YYKitDemo
//
//  Created by HY on 16/7/13.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HYFirstVC.h"
#import "HTwoVC.h"
#import "HThreeVC.h"
#import "HFourVC.h"

#import "HYTabBarControllerConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

static BOOL flagError = NO;
void UncaughtExceptionHandler(NSException *exception) {
    if (!flagError) {
        flagError = YES;
        NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
        NSString *reason = [exception reason];//非常重要，就是崩溃的原因
        NSString *name = [exception name];//异常类型
        NSDictionary *userInfo = [exception userInfo];//异常类型
        
        NSString*crashLogInfo = [NSString stringWithFormat:@"name: %@   reason : %@   arr : %@   userInfo:%@", name, reason, arr,userInfo];
        NSDictionary *dict = @{@"deadline":@"10001",@"errormsg":crashLogInfo};
//        [YGStoreObserver ipaErrorOrderLog:dict];
        NSLog(@"捕捉到异常闪退日志 ，可以上报服务器 %@",dict);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    HYTabBarControllerConfig *tabBarControllerConfig = [[HYTabBarControllerConfig alloc] init];
    [self.window setRootViewController:tabBarControllerConfig.tabBarController];
    [self.window makeKeyAndVisible];
    [self customizeInterface];
    
    return YES;
}
- (void)customizeInterface {
    [self setUpNavigationBarAppearance];
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName : [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        textAttributes = @{
                           UITextAttributeFont : [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor : [UIColor blackColor],
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
