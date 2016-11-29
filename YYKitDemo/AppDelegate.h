//
//  AppDelegate.h
//  YYKitDemo
//
//  Created by HY on 16/7/13.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"
#import "ScreenShotView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;

@property (nonatomic, strong) ScreenShotView *screenshotView;

//@property (nonatomic, strong) CYLTabBarController *tabBarController;
/// func
+ (AppDelegate* )shareAppDelegate;
@end

