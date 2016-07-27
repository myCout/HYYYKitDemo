//
//  HDownLoadImgInstance.h
//  YYKitDemo
//
//  Created by HY on 16/7/27.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HDownLoadImgInstance : NSObject

@property (nonatomic) BOOL saveSuccess;

+ (instancetype)sharedInstance;

- (void)downLoadImgWith:(NSString *)imgUrlStr;

- (UIImage *)getYGShareImage;
@end
