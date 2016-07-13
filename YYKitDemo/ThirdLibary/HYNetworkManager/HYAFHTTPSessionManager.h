//
//  HYAFHTTPSessionManager.h
//  YYKitDemo
//
//  Created by HY on 16/7/13.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "HGetParameters.h"

#define YGBaseUrl  [HGetParameters getYGBaseUrl]

@interface HYAFHTTPSessionManager : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
