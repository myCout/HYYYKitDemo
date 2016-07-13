//
//  HYNetworkManager.h
//  YYKitDemo
//
//  Created by HY on 16/7/13.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYAFHTTPSessionManager.h"
//连接可自己替换
#define urlStr @"http://www.weather.com.cn/data/sk/101010100.html"

/**
 *  weakSelf 宏定义
 *
 *  @param weakSelf 代码中的名字
 */
#define WS(weakSelf)                        __weak __typeof(&*self)weakSelf = self;


typedef void (^onResposeBlock) (NSString *error ,NSDictionary *resposeData);

@interface HYNetworkManager : NSObject

-(instancetype)initWithDelegate:(id)requestDelegate bindTag:(NSString *)bindTag needToken:(NSInteger)needToken;

@property (nonatomic,assign)  id requestDelegate;
@property (nonatomic,copy)  NSString *bindTag;
@property (nonatomic,assign)  NSInteger needToken;

@property (nonatomic,copy)  onResposeBlock resposeBlock;

+ (instancetype)sharedInstance;




#pragma mark - Get方法(默认方法)
//不带缓存
-(void)httpGetRequest:(NSString *)api params:(NSMutableDictionary *)params onCompletionBlock:(void (^)(NSString *error ,NSDictionary *resposeData))completionBlock;
//-(void)httpGetRequest:(NSString *)api params:(NSMutableDictionary *)params;
//-(void)httpGetCacheRequest:(NSString *)api params:(NSMutableDictionary *)params;
-(void)httpGetCacheRequest:(NSString *)api params:(NSMutableDictionary *)params onCompletionBlock:(void (^)(NSString *error ,NSDictionary *resposeData))completionBlock;
#pragma mark - Post方法
//不带缓存
-(void)httpPostRequest:(NSString *)api params:(NSMutableDictionary *)params onCompletionBlock:(void (^)(NSString *error ,NSDictionary *resposeData))completionBlock;
-(void)httpPostCacheRequest:(NSString *)api params:(NSMutableDictionary *)params onCompletionBlock:(void (^)(NSString *error ,NSDictionary *resposeData))completionBlock;

#pragma mark - 上传文件方法
//上传单张图片
-(void)upLoadDataWithUrlStr:(NSString *)api params:(NSMutableDictionary *)params imageKey:(NSString *)name withData:(NSData *)data onCompletionBlock:(void (^)(NSString *error ,NSDictionary *resposeData))completionBlock;
//上传多张图片
-(void)upLoadDataWithUrlStr:(NSString *)api params:(NSMutableDictionary *)params  withDataArray:(NSArray *)dataArray onCompletionBlock:(void (^)(NSString *error ,NSDictionary *resposeData))completionBlock;

@end
