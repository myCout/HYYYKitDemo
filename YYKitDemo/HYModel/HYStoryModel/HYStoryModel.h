//
//  HYStoryModel.h
//  YYKitDemo
//
//  Created by HY on 16/7/29.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYStoryModel : NSObject

+ (instancetype)sharedInstance;
@property (nonatomic)NSUInteger gaPrefix;
@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)NSArray *images;
//@property (assign,nonatomic)NSInteger type;
@property (strong,nonatomic)NSString *storyID;
@property (assign,nonatomic)BOOL multipic;
@property (strong,nonatomic)NSString *image;

@end
