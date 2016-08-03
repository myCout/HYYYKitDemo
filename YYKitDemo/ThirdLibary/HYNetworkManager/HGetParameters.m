//
//  HGetParameters.m
//  DailyYoga
//
//  Created by HY on 15/12/4.
//  Copyright © 2015年 HY. All rights reserved.
//

#import "HGetParameters.h"

#define YG_Version  [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]

@implementation HGetParameters
 
static NSDictionary *userDict = nil;
static NSDictionary *hostDict = nil;

+ (NSString*)getYGBaseUrl{
    return @"http://news-at.zhihu.com/api/4";//    测试用天气接口
}

+ (id)getParametersInstance{
    static HGetParameters *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


-(void)encryptAppInitParameter:(void (^)(NSMutableDictionary *dic))completionBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setObject:[_Des TripleDES:[SystemConfigUtil getDeviceType] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"device_type"];
//    [parameters setObject:[_Des TripleDES:[OpenUDID value] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"device_id"];
//    
//    NSString *macAddress=[SystemConfigUtil getMacAddress];
//    if (![macAddress isEqualToString:@"020000000000"]) {
//        [parameters setObject:[_Des TripleDES:[SystemConfigUtil getMacAddress] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"mac"];
//    }else{
//        [parameters setObject:[_Des TripleDES:@" " encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"mac"];
//    }
//    
//    [parameters setObject:[_Des TripleDES:@" " encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"imei"];
//    
//    [parameters setObject:[_Des TripleDES:[NSString stringWithFormat:@"iOS_%@",CURRENT_SYS_VERSION] encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"os"];
//    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    [parameters setObject:[_Des TripleDES:appVersion encryptOrDecrypt:kCCEncrypt key:[SystemConfigUtil calculateDefaultDESKEY] andIV:[SystemConfigUtil calculateDefaultDESIV]] forKey:@"app_version"];
    completionBlock(parameters);
}

/**
 *  底层公共参数
 *
 *  @param paraDic 不同接口需要的不同参数
 *
 *  @return 最终拼接到的所有参数
 */
+(NSMutableDictionary*)getRecommendListPara:(NSDictionary *)paraDic {
    NSMutableDictionary *parameters;
    if (paraDic != nil) {
        parameters = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    }else{
        parameters = [NSMutableDictionary new];
    }
//    if (![paraDic objectForKey:@"type"]) {
//        [parameters setObject:@(2) forKey: @"type"];
//    }
//    [parameters setObject:@(2) forKey: @"platform"];
//    [parameters setObject:YG_Version  forKey:@"version"];
//    [parameters setObject:@(2) forKey: @"lang"];
//    [parameters setObject:@(time(NULL)) forKey: @"time"];
//    [parameters setObject:@([HGetParameters timeZoneOffset]) forKey: @"timezone"];
//    [parameters setObject:@"200001" forKey: @"channels"];
//
//    NSString *serviceSignString = [NSDictionary serviceloadSignFromParametersNSDictionary:parameters];
//    NSString *signString = [NSDictionary loadSignFromParametersNSDictionary:parameters];
//    [parameters setObject:serviceSignString forKey:@"sign"];
//    [parameters setObject:signString forKey:hLocalDataKey];
    return parameters;
}

/**
 *  登录接口调用
 */
+(NSMutableDictionary*)getLogInPara:(NSDictionary *)paraDic {
    NSMutableDictionary *parameters;
    if (paraDic != nil) {
        parameters = [NSMutableDictionary dictionaryWithDictionary:paraDic];
    }else{
        parameters = [NSMutableDictionary new];
    }
//    if (![paraDic objectForKey:@"type"]) {
//        [parameters setObject:@(YGDeviceType) forKey: @"type"];
//    }
//    [parameters setObject:YG_Version  forKey:@"version"];
//    [parameters setObject:@([NSString loadLanguageCode]) forKey: @"lang"];
//    [parameters setObject:@(time(NULL)) forKey: @"time"];
//    [parameters setObject:@([NSTimeZone timeZoneOffset]) forKey: @"timezone"];
//    [parameters setObject:YG_Channels forKey: @"channels"];
//    NSString *signString = [NSDictionary loadSignFromParametersNSDictionary:parameters];
//    [parameters setObject:signString forKey:@"sign"];
    return parameters;
}

@end
