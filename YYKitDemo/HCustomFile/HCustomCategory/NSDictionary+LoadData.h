//
//  NSDictionary+LoadData.h
//  YYKitDemo
//
//  Created by HY on 2017/4/13.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LoadData)

- (NSString*)strValueDeleteSpace:(NSString*)path;
- (float)floatValue:(NSString*)path;
- (NSInteger)intValue:(NSString*)path;
- (NSString*)strValue:(NSString*)path;
- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue;
- (float)floatValue:(NSString*)path default:(float)defValue;
- (NSString*)strValue:(NSString*)path default:(NSString*)defValue;
- (NSString*)strValueDeleteAllReturn:(NSString*)path;
- (NSString*)strValueDeleteReturn:(NSString*)path;
- (NSDictionary *)dictValueDeleteReturn;

- (NSDate *)dateValue:(NSString *)path;
- (NSDate *)dateValue:(NSString *)path default:(NSDate *)defValue;

-(NSMutableDictionary *)dictmuValue:(NSString *)path;
-(NSMutableDictionary *)dictmuValue:(NSString *)path default:(NSMutableDictionary *)defValue;

-(NSDictionary *)dictValue:(NSString *)path;
-(NSDictionary *)dictValue:(NSString *)path default:(NSDictionary *)defValue;

-(NSArray *)arrayValue:(NSString *)path;
-(NSArray *)arrayValue:(NSString *)path default:(NSArray *)defValue;

-(NSMutableArray *)arraymuValue:(NSString *)path;
-(NSMutableArray *)arraymuValue:(NSString *)path default:(NSMutableArray *)defValue;

@end
