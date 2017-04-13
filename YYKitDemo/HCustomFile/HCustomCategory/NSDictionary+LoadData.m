//
//  NSDictionary+LoadData.m
//  YYKitDemo
//
//  Created by HY on 2017/4/13.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "NSDictionary+LoadData.h"

@implementation NSDictionary (LoadData)


- (NSString*)strValueDeleteSpace:(NSString*)path{
    NSString*msg = [self strValue:path];
    NSString *trimmedString = [msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (NSString*)strValueDeleteReturn:(NSString*)path{
    NSString*msg = [self objectForKey:path];
    if(!msg){
        return @"";
    }
    if ([msg respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]) {
        msg = [msg stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    }
    return msg;
}
- (NSString*)strValueDeleteAllReturn:(NSString*)path{
    NSString*msg = [self objectForKey:path];
    if(!msg){
        return @"";
    }
    if([msg respondsToSelector:@selector(stringByReplacingOccurrencesOfString:withString:)]){
        msg = [msg stringByReplacingOccurrencesOfString:@"<br />\r\n" withString:@""];
    }
    return msg;
}
- (NSDictionary *)dictValueDeleteReturn{
    
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self];
    [tmpDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSString class]]) {
            obj = [obj stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
            [tmpDict setObject:obj forKey:key];
        }
    }];
    return tmpDict;
}

- (float)floatValue:(NSString *)path {
    return [self floatValue:path default:0.0];
}

- (NSInteger)intValue:(NSString*)path {
    return [self intValue:path default:0];
}

- (NSString*)strValue:(NSString*)path {
    return [self strValue:path default:@""];
}


- (float)floatValue:(NSString*)path default:(float)defValue{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj floatValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj floatValue];
    else
        return defValue;
}


- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj intValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj intValue];
    else
        return defValue;
}

- (NSString*)strValue:(NSString*)path default:(NSString*)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj stringValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj length] <= 0 ? defValue : (NSString*)obj;
    else
        return defValue;
}

- (NSDate *)dateValue:(NSString *)path{
    
    return [self dateValue:path default:nil];
}
- (NSDate *)dateValue:(NSString *)path default:(NSDate *)defValue{
    NSObject *obj = [self valueForKey:path];
    if ([obj isKindOfClass:[NSDate class]]) {
        return (NSDate *)obj;
    }
    else
        return defValue;
}
/**
 dict 提取 NSDictionary
 
 @param path 对应的key
 
 @return NSDictionary
 */
-(NSDictionary *)dictValue:(NSString *)path{
    return [self dictValue:path default:[NSDictionary dictionary]];
}
/**
 dict 提取 NSDictionary
 
 @param path 对应的key
 @param defValue 默认空的NSDictionary
 
 @return NSDictionary
 */
-(NSDictionary *)dictValue:(NSString *)path default:(NSDictionary *)defValue{
    
    NSObject *obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }else
        return defValue;
}
/**
 dict 提取 NSMutableDictionary
 
 @param path 对应的key
 
 @return NSMutableDictionary
 */
-(NSMutableDictionary *)dictmuValue:(NSString *)path{
    return [self dictmuValue:path default:[NSMutableDictionary dictionary]];
}
/**
 dict 提取 NSMutableDictionary
 
 @param path 对应的key
 @param defValue 默认空的NSMutableDictionary
 
 @return NSMutableDictionary
 */
-(NSMutableDictionary *)dictmuValue:(NSString *)path default:(NSMutableDictionary *)defValue{
    NSObject *obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSMutableDictionary class]]) {
        return (NSMutableDictionary *)obj;
    }else if([obj isKindOfClass:[NSDictionary class]]) {
        return [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
    }else{
        return defValue;
    }
    
}
/**
 dict 提取 NSArray
 
 @param path 对应的key
 
 @return NSArray
 */
-(NSArray *)arrayValue:(NSString *)path{
    return [self arrayValue:path default: [NSArray array]];
}
/**
 dict 提取 NSArray
 
 @param path 对应的key
 @param defValue 默认空的NSArray
 
 @return NSArray
 */
-(NSArray *)arrayValue:(NSString *)path default:(NSArray *)defValue{
    NSObject *obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSArray class]]) {
        return (NSArray *)obj;
    }else
        return defValue;
    
}
/**
 dict 提取 NSMutableArray
 
 @param path 对应的key
 
 @return NSMutableArray
 */
-(NSMutableArray *)arraymuValue:(NSString *)path{
    return [self arraymuValue:path default: [NSMutableArray array]];
}

/**
 dict 提取 NSMutableArray
 
 @param path 对应的key
 @param defValue 默认空的NSMutableArray
 
 @return NSMutableArray
 */
-(NSMutableArray *)arraymuValue:(NSString *)path default:(NSMutableArray *)defValue{
    NSObject *obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSMutableArray class]]) {
        return (NSMutableArray *)obj;
    }else if ([obj isKindOfClass:[NSArray class]]) {
        return [NSMutableArray arrayWithArray:(NSArray *)obj];
    }else{
        return defValue;
    }
    
}

@end
