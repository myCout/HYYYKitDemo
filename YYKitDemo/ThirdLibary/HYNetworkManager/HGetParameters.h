//
//  HGetParameters.h
//  DailyYoga
//
//  Created by HY on 15/12/4.
//  Copyright © 2015年 HY. All rights reserved.
//

#import <Foundation/Foundation.h>


#define  HYGetParameters(dict) [HGetParameters getRecommendListPara:dict]
/**
 *  登录接口调用
 */
#define  HYGetLogInParameters(dict) [HGetParameters getLogInPara:dict]


@interface HGetParameters : NSObject



+ (NSString*)getYGBaseUrl;
+ (id)getParametersInstance;

+(NSMutableDictionary*)getRecommendListPara:(NSDictionary *)paraDic;
/**
 *  登录接口调用
 */
+(NSMutableDictionary*)getLogInPara:(NSDictionary *)paraDic;

@end
