//
//  CoreModel.h
//  4s
//
//  Created by muxi on 15/3/11.
//  Copyright (c) 2015年 muxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreStatusDefine.h"
#import "DBMangeShare.h"
#import "Base64Str.h"
@interface BaseCoreModel : NSObject

/** 服务器数据的ID */
@property (nonatomic,retain) NSString* className;
@property (nonatomic,retain) NSString* hostID;

+(NSString *)modelName;
+(void)save:(BaseCoreModel*)model resBlock:(void(^)(BOOL res))resBlock;
+(void)saveModels:(NSArray *)models resBlock:(void(^)(BOOL res))resBlock;
+(void)saveAction:(BaseCoreModel*)model resBlock:(void(^)(BOOL res))resBlock;
+(void)deleteWhere:(NSString *)where resBlock:(void(^)(BOOL res))resBlock;
+(void)deleteWhereAction:(NSString *)where resBlock:(void(^)(BOOL res))resBlock;
+(void)deletehostID:(NSString*)hostID resBlock:(void(^)(BOOL res))resBlock;


+(void)selectWhere:(NSString *)where groupBy:(NSString *)groupBy orderBy:(NSString *)orderBy limit:(NSString *)limit selectResultsBlock:(void(^)(NSArray *selectResults))selectResultsBlock;
+(void)find:(NSString*)hostID selectResultBlock:(void(^)(id selectResult))selectResultBlock;


+(void)findAction:(NSString*)hostID selectResultBlock:(void(^)(id selectResult))selectResultBlock;

+(void)selectWhereAction:(NSString *)where groupBy:(NSString *)groupBy orderBy:(NSString *)orderBy limit:(NSString *)limit selectResultsBlock:(void(^)(NSArray *selectResults))selectResultsBlock;
@end
