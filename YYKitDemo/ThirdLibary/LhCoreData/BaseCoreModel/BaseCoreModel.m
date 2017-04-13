//
//  CoreModel.m
//  4s
//
//  Created by muxi on 15/3/11.
//  Copyright (c) 2015年 muxi. All rights reserved.
//
#import <Foundation/NSArray.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSOrderedSet.h>
#import <Foundation/NSSet.h>
#import "BaseCoreModel.h"
#import "MJProperty.h"
#import "MJPropertyType.h"
#import "NSObject+MJProperty.h"
#import "CoreFMDB.h"
#import "NSObject+SBJson.h"

#define AllTimeStyle @"yyyy-MM-dd HH:mm:ss"

@implementation BaseCoreModel

/*****************************数据库与表****************************************/
+(void)initialize{
    __weak __typeof(self)weakSelf = self;
    if (![DBMangeShare sharedDBMange].tableDict[[self modelName]]) {
        [[DBMangeShare sharedDBMange].tableDict setObject: [NSMutableDictionary dictionary] forKey: [self modelName]];
        //自动创表
        [weakSelf tableCreate];
    }
}

+(NSString *)modelName{
    return [NSStringFromClass(self) componentsSeparatedByString:@"."].lastObject;
}

/** 封装 */
+(void)enumNSObjectProperties:(void(^)(MJProperty *property, BOOL *stop))properties{
    [self mj_enumerateProperties:^(MJProperty *p, BOOL *stop) {
        properties(p,stop);
    }];
}

+(void)tableCreate{
    
    CoreFMDB*tmp =  [[CoreFMDB alloc]init];//读表TableClassName
    tmp = nil;
    NSString *modelName = [self modelName];
    if([modelName isEqualToString:@"BaseCoreModel"]) {
        return;
    }
    
    BOOL flag = YES;
    NSMutableDictionary*dictTableClass = [[DBMangeShare sharedDBMange].tableDict objectForKey:TableClassName];
    if (dictTableClass && [dictTableClass objectForKey:modelName]) {
        flag = NO;
    }
    NSMutableString *sql=[NSMutableString string];
    [sql appendFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL DEFAULT 0,",modelName];
    NSMutableArray *ivarsM=[NSMutableArray array];
    __weak __typeof(self)weakSelf = self;
    [weakSelf enumNSObjectProperties:^(MJProperty *property, BOOL *stop) {
        if (flag) {
            NSString *sql_field = [weakSelf fieldSql:property];
            BOOL skip=[weakSelf skipField:property];
            if(![sql_field isEqualToString:EmptyString] && !skip){
                [sql appendString:sql_field];
                [ivarsM addObject:property];
            }
        }else{
            BOOL skip=[weakSelf skipField:property];
            if (!skip) {
                [ivarsM addObject:property];
            }
            
        }
    }];

    if (flag) {
        NSString *subSql = [weakSelf deleteLastChar:sql];
        NSString *sql_Create = [NSString stringWithFormat:@"%@);",subSql];
        BOOL createRes = [CoreFMDB executeUpdate:sql_Create];
        if(!createRes){
            NSLog(@"创表:%@",sql);
            NSLog(@"创表失败:%@ ",modelName);
            return;
        }
    }else{
        [weakSelf fieldsCheck:modelName ivars:ivarsM];
    }
}

+(NSString *)deleteLastChar:(NSString *)str{
    if(str.length == 0) return @"";
    return [str substringToIndex:str.length - 1];
}
#pragma mark 修改与检查表字段
+(void)fieldsCheck:(NSString *)table ivars:(NSArray *)ivars{
    NSLog(@"%@:字段检查:",table);
    NSArray *columns=[CoreFMDB executeQueryColumnsInTable:table];
    NSMutableArray *columnsM=[NSMutableArray arrayWithArray:columns];
    for (MJProperty *ivar in ivars) {
        
        if([columnsM containsObject:ivar.name]) continue;
        
        NSMutableString *sql_addM=[NSMutableString stringWithFormat:@"ALTER TABLE '%@' ADD COLUMN %@",table,[self fieldSql:ivar]];
        NSString *sql_add=[self deleteLastChar:sql_addM];
        
        NSString *sql=[NSString stringWithFormat:@"%@;",sql_add];
        
        BOOL addRes = [CoreFMDB executeUpdate:sql];
        
        if(!addRes){
            NSLog(@"模型%@字段新增失败！ %@",table,sql);
            return;
        }
        NSLog(@"注意：模型 %@ 有新增加的字段 %@,已经实时添加到数据库中！",table,ivar.name);
    }
}


#pragma mark 字段sql合成
+(NSString *)fieldSql:(MJProperty *)ivar{
    
    NSString *fieldName = ivar.name;
    
    NSString *fieldType = ivar.type.code;
    
    NSString *sqliteTye=[self sqliteType:fieldType];
    
    NSString*UNIQUE=@"";
    if ([fieldName isEqualToString:@"hostID"]) {
        UNIQUE=@"UNIQUE";
    }
    
    if([sqliteTye isEqualToString:EmptyString]){
        return [NSString stringWithFormat:@"%@ %@ %@,",fieldName,INTEGER_TYPE,UNIQUE];
    }
    NSString *fieldSql=[NSString stringWithFormat:@"%@ %@ %@,",fieldName,sqliteTye,UNIQUE];
    
    return fieldSql;
}
#pragma mark 跳过字段判断
+(BOOL)skipField:(MJProperty *)ivar{
    NSArray *ignoredPropertyNames = @[@"hash",@"superclass",@"description",@"debugDescription"];
    BOOL skip=ignoredPropertyNames!=nil && [ignoredPropertyNames containsObject:ivar.name];
    
    return skip;
}


#pragma mark 根据类型找出对应的sql
+(NSString *)sqliteType:(NSString *)fieldType{
    NSDictionary *map=@{
                        INTEGER_TYPE:@[CoreNSUInteger,CoreNSInteger,Corelong,Coreshort,CoreUNShort,Corechar,CoreUNchar,BLOB_TYPE],
                        TEXT_TYPE:@[CoreNSString,CoreNSArray,CoreNSMutableArray,CoreNSDictionary,CoreNSMutableDictionary,CoreNSData],//字符串 数组  字典 nsdata
                        DATETIME_TYPE:@[CoreNSDate],
                        REAL_TYPE:@[CoreCGFloat,Coredouble]
                        };
    
    __block NSString *sqliteType=EmptyString;
    if([fieldType isEqualToString:@"i"] || [fieldType isEqualToString:@"q"] || [fieldType isEqualToString:@"I"] || [fieldType isEqualToString:@"Q"] ){
        return INTEGER_TYPE;
    }
    [map enumerateKeysAndObjectsUsingBlock:^(NSString *blockSqliteType, NSArray *blockFieldTypes, BOOL *stop2) {
        
        [blockFieldTypes enumerateObjectsUsingBlock:^(NSString *typeStringConst, NSUInteger idx, BOOL *stop1) {
            
            if(fieldType.length >= 5){
                if ([typeStringConst isEqualToString:fieldType]) {
                    sqliteType = blockSqliteType;
                    *stop1 = YES;
                    *stop2 = YES;
                }
            }else{
                NSRange range = [typeStringConst rangeOfString:fieldType];
                if(range.length>0){
                    sqliteType = blockSqliteType;
                    *stop1 = YES;
                    *stop2 = YES;
                }
            }
        }];
    }];
    
    return sqliteType;
}


#pragma mark 找出返回类型
+(NSString *)sqliteDataType:(NSString *)fieldType{
    NSDictionary *map=@{
                        typeNumber:@[CoreNSUInteger,CoreNSInteger,Corelong,Coreshort,CoreUNShort,Corechar,CoreUNchar,BLOB_TYPE],
                        typeStr:@[CoreNSString],//字符串 数组
                        typeNsDataGetStr:@[CoreNSArray,CoreNSMutableArray,CoreNSDictionary,CoreNSMutableDictionary,CoreNSData],//字符串 数组 字典 nsdata
                        typeStrDate:@[CoreNSDate],
                        typeNumberFloat:@[CoreCGFloat,Coredouble]
                        };
    
    __block NSString *sqliteType=nil;
    
    
    

    [map enumerateKeysAndObjectsUsingBlock:^(NSString *blockSqliteType, NSArray *blockFieldTypes, BOOL *stop1) {
        
        [blockFieldTypes enumerateObjectsUsingBlock:^(NSString *typeStringConst, NSUInteger idx, BOOL *stop2) {
            
            if(fieldType.length >= 5){
                if ([typeStringConst isEqualToString:fieldType]) {
                    sqliteType = blockSqliteType;
                    *stop1 = YES;
                    *stop2 = YES;
                }
            }else{
                NSRange range = [typeStringConst rangeOfString:fieldType];
                if(range.length>0){
                    sqliteType = blockSqliteType;
                     *stop1 = YES;
                     *stop2 = YES;
                }
            }
            
        }];
    }];
    
    return sqliteType;
}


/******************************数据操作*************************************/
+(void)save:(id)model resBlock:(void(^)(BOOL res))resBlock{
    if (model) {
        [self save:model resBlock:resBlock needThread:YES];
    }
}

+(void)save:(id)model resBlock:(void(^)(BOOL res))resBlock needThread:(BOOL)needThread{
    if (needThread) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self saveAction:model resBlock:resBlock];
        });
    }else{
        [self saveAction:model resBlock:resBlock];
    }
}



+(void)checkUsage:(id)model{
    NSAssert([NSStringFromClass(self) isEqualToString:NSStringFromClass([model class])], @"错误：请使用模型%@所属类（而不是%@类）的静态方法来执行您的操作",NSStringFromClass([model class]),NSStringFromClass(self));
}

+(void)saveAction:(BaseCoreModel*)model resBlock:(void(^)(BOOL res))resBlock{
    
    [self checkUsage:model];
    NSString *modelName = [self modelName];
    if(![[DBMangeShare sharedDBMange].tableDict objectForKey:modelName]){
        NSLog(@"注意：你操作的模型%@在数据库中没有对应的数据表",modelName);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self saveAction:model resBlock:resBlock];
        });
        
        return;
    }
    NSMutableString *fields=[NSMutableString string];
    NSMutableString *values=[NSMutableString string];
    __weak __typeof(self)weakSelf = self;
    [weakSelf enumNSObjectProperties:^(MJProperty *property, BOOL *stop) {
        
        BOOL skip=[weakSelf skipField:property];
        if(!skip){
            NSString*type = [self sqliteDataType:property.type.code];
            
            id value =[model valueForKeyPath:property.name];
            if (value == nil) {
                return ;
            }
            if (type) {
                [fields appendFormat:@"%@,",property.name];
                if ([type isEqualToString:typeNumber] || [type isEqualToString:typeNumberFloat]) {
                    [values appendFormat:@"'%@',",value];
                }else if ([type isEqualToString:typeStr]){
                    if(value == nil) {
                        value=@"";
                    }else{
                        value=[NSString stringWithFormat:@"%@",value];
                    }
                    NSString*t = [Base64Str base64StringFromText:value];
                    #ifdef DEBUG
                    NSString* v = [Base64Str textFromBase64String:t];
                    if (![v isEqualToString:value]) {
                        NSLog(@"error ************Base64Str ************  error");
                    }
                    #else
                    #endif
                    [values appendFormat:@"'%@',",t];
                }else if ([type isEqualToString:typeNsDataGetStr]){
                    value=[NSString stringWithFormat:@"%@",[value JSONRepresentation]];
                    
                    NSString*t = [Base64Str base64StringFromText:value];
                    #ifdef DEBUG
                    NSString* v = [Base64Str textFromBase64String:t];
                    if (![v isEqualToString:value]) {
                        NSLog(@"error ************Base64Str ************  error");
                    }
                    #else
                    #endif
                    [values appendFormat:@"'%@',",t];
                }else if ([type isEqualToString:typeStrDate]){
//                    value = [Utility stringFromDate:value key:AllTimeStyle];//时间格式化
                    [values appendFormat:@"'%@',",value];
                }

            }else{
                if (value) {
                    BaseCoreModel*t = (BaseCoreModel*)value;
                    Class Cls = [t class];
                    NSString*table = [NSString stringWithFormat:@"%@",Cls];
                    
                    if ([[DBMangeShare sharedDBMange].tableDict objectForKey:table] || [value isMemberOfClass:[BaseCoreModel class]]) {
                        NSString*thost = [Base64Str base64StringFromText:t.hostID];
                        [values appendFormat:@"'%@',",thost];
                        [fields appendFormat:@"'%@',",property.name];
                        [Cls save:value resBlock:nil];
                    }
                }
                
            }
        }
    }];
    
    NSString *fields_sub=[self deleteLastChar:fields];
    NSString *values_sub=[self deleteLastChar:values];
    NSString *sql=[NSString stringWithFormat:@"replace into  %@ (%@) VALUES (%@);",[self modelName],fields_sub,values_sub];
    BOOL insertRes = [CoreFMDB executeUpdate:sql];
    if(!insertRes){
        NSLog(@"错误：添加对象失败%@  %@",model,sql);
    }
    TriggerBlock(resBlock, insertRes)
}



+(void)saveModels:(NSArray *)models resBlock:(void(^)(BOOL res))resBlock{
    if(models==nil || models.count==0) {
        if (resBlock !=nil)
            resBlock(NO);
        return;
    };
    NSOperationQueue *queue = [DBMangeShare sharedDBMange].queue;
    [models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            Class Cls = [obj class];
            NSString*table = [NSString stringWithFormat:@"%@",Cls];
            if ([[DBMangeShare sharedDBMange].tableDict objectForKey:table] || [obj isMemberOfClass:[BaseCoreModel class]]) {
                [Cls save:obj resBlock:resBlock needThread:NO];
            }
        }];
        [queue addOperation:op];
    }];
}

/********************删除**************************/
+(void)deleteWhere:(NSString *)where resBlock:(void(^)(BOOL res))resBlock{
    [self deleteWhere:where resBlock:resBlock needThread:YES];
}

+(void)deleteWhere:(NSString *)where resBlock:(void(^)(BOOL res))resBlock needThread:(BOOL)needThread{
    
    if(needThread){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self deleteWhereAction:where resBlock:resBlock];
        });
    }else{
        [self deleteWhereAction:where resBlock:resBlock];
    }
}


+(void)deleteWhereAction:(NSString *)where resBlock:(void(^)(BOOL res))resBlock{
    if (where) {
        NSString *sql=[NSString stringWithFormat:@"DELETE FROM %@",[self modelName]];
        sql = [NSString stringWithFormat:@"%@ WHERE %@",sql,where];
        BOOL res =  [CoreFMDB executeUpdate:sql];
        if(!res) {
            NSLog(@"错误：执行删除失败，sql语句为：%@",sql);
        }
        TriggerBlock(resBlock, res)

    }else{
        TriggerBlock(resBlock, NO);
    }
    
}



+(void)deletehostID:(NSString*)hostID resBlock:(void(^)(BOOL res))resBlock{
    NSString *where=[NSString stringWithFormat:@"hostID='%@'",[Base64Str base64StringFromText:hostID]];
    [self deleteWhere:where resBlock:resBlock needThread:YES];
}

/*********************查询************************/
+(void)selectWhere:(NSString *)where groupBy:(NSString *)groupBy orderBy:(NSString *)orderBy limit:(NSString *)limit selectResultsBlock:(void(^)(NSArray *selectResults))selectResultsBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self selectWhereAction:where groupBy:groupBy orderBy:orderBy limit:limit selectResultsBlock:selectResultsBlock];
    });
}

+(void)selectWhereAction:(NSString *)where groupBy:(NSString *)groupBy orderBy:(NSString *)orderBy limit:(NSString *)limit selectResultsBlock:(void(^)(NSArray *selectResults))selectResultsBlock{
    
    
    NSMutableString *sqlM=[NSMutableString stringWithFormat:@"SELECT * FROM %@",[self modelName]];
    
    if(where != nil) [sqlM appendFormat:@" WHERE %@",where];
    
    if(groupBy != nil) [sqlM appendFormat:@" GROUP BY %@",groupBy];
    
    if(orderBy != nil) [sqlM appendFormat:@" ORDER BY %@",orderBy];
    
    if(limit != nil) [sqlM appendFormat:@" LIMIT %@",limit];
    
    NSString *sql=[NSString stringWithFormat:@"%@;",sqlM];
    
    NSMutableArray *resultsM=[NSMutableArray array];
    NSMutableArray *tmpM=[NSMutableArray array];
    WS(weakSelf)
    [CoreFMDB executeQuery:sql queryResBlock:^(FMResultSet *set) {
        
        while ([set next]) {
            BaseCoreModel *model=[[weakSelf alloc] init];
            [weakSelf enumNSObjectProperties:^(MJProperty *property, BOOL *stop) {
                
                BOOL skip=[weakSelf skipField:property];
                
                if(!skip){
                    NSString *value=[set stringForColumn:property.name];
                    
                    NSString*type =[self sqliteDataType:property.type.code];
                    if (type) {
                        if ([type isEqualToString:typeNumberFloat]) {
                            NSNumber*ttt=[NSNumber numberWithFloat:[value floatValue]];
                            [model setValue:ttt forKey:property.name];
                        }else  if ([type isEqualToString:typeNumber]) {
                            NSNumber*ttt=[NSNumber numberWithInteger:[value integerValue]];
                            [model setValue:ttt forKey:property.name];
                        }else if ([type isEqualToString:typeStr]){
                            NSString* v = [Base64Str textFromBase64String:value];
                            [model setValue:v forKey:property.name];
                        }else if ([type isEqualToString:typeNsDataGetStr]){
                            if (value.length ) {
                                NSString* v = [Base64Str textFromBase64String:value];
                                id data = [v JSONValue];
                                if(data) {
                                    [model setValue:data forKey:property.name];
                                }
                            }
                        }else if ([type isEqualToString:typeStrDate]){
                            if (value.length ) {
                                NSDate*date = [NSDate jk_dateFromRFC822String:AllTimeStyle];
                                if(date){
                                    [model setValue:date forKey:property.name];
                                }
                            }
                        }

                    }else{
                        if (value && value.length > 0) {
                            NSDictionary*dict = @{@"model":model,@"value":value,@"name":property.name,@"code":property.type.code};
                            [tmpM addObject:dict];
                        }

                    }
                    
                }
                
            }];
            
            [resultsM addObject:model];
        }
    }];
    
    for (NSDictionary*dict in tmpM) {
        BaseCoreModel *model = [dict objectForKey:@"model"];
        Class clas = NSClassFromString([dict objectForKey:@"code"]);
        if (!clas) {
            clas = NSClassFromString(model.className);
        }
        [clas selectWhereAction:[NSString stringWithFormat:@"hostID='%@'",[dict objectForKey:@"value"]] groupBy:nil orderBy:nil limit:nil selectResultsBlock:^(NSArray *selectResults) {
            if (selectResults.count) {
                [model setValue:selectResults[0] forKey:[dict objectForKey:@"name"]];
            }
            
        }];
    }
//    NSLog(@" result:%@",resultsM);
    if(selectResultsBlock != nil) {
        selectResultsBlock(resultsM);
    }
}




+(void)find:(NSString*)hostID selectResultBlock:(void(^)(id selectResult))selectResultBlock{
    
    NSString *where=[NSString stringWithFormat:@"hostID='%@'",[Base64Str base64StringFromText:hostID]];
    
    NSString *limit=@"1";
    
    [self selectWhere:where groupBy:nil orderBy:nil limit:limit selectResultsBlock:^(NSArray *selectResults) {
        
        if (selectResultBlock != nil) {
            selectResultBlock(selectResults.count>0 ?selectResults.firstObject:nil);
        }
        
    }];
    
}

+(void)findAction:(NSString*)hostID selectResultBlock:(void(^)(id selectResult))selectResultBlock{
    NSString *where=[NSString stringWithFormat:@"hostID='%@'",[Base64Str base64StringFromText:hostID]];
    
    NSString *limit=@"1";
    [self selectWhereAction:where groupBy:nil orderBy:nil limit:limit selectResultsBlock:^(NSArray *selectResults) {
        
        if (selectResultBlock != nil) {
            selectResultBlock(selectResults.count>0 ?selectResults.firstObject:nil);
        }
        
    }];
}

@end
