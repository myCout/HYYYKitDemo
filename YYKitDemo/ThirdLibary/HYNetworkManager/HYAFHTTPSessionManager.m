//
//  HYAFHTTPSessionManager.m
//  YYKitDemo
//
//  Created by HY on 16/7/13.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYAFHTTPSessionManager.h"

@implementation HYAFHTTPSessionManager
/**
 *  BaseUrl 管理
 *
 *  @return AFHTTPSessionManager
 */
+ (instancetype) sharedClient{
    static HYAFHTTPSessionManager *_sharedClient = Nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HYAFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:YGBaseUrl]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
        //超时时间
        _sharedClient.requestSerializer.timeoutInterval=30;
    });
    return _sharedClient;
}
@end
