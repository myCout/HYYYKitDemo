//
//  HYStoryModel.m
//  YYKitDemo
//
//  Created by HY on 16/7/29.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYStoryModel.h"

@implementation HYStoryModel

+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"gaPrefix" : @"ga_prefix",
             @"storyID" : @"id"};
}

@end
