//
//  CPView.h
//  YYKitDemo
//
//  Created by HY on 2017/2/24.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPView : UIView


//初始化方法
+(CPView *(^)(void))initialization;

//自定义frame
-(CPView *(^)(CGRect rect))rect;

//自定义backgroundColor
-(CPView *(^)(UIColor * color))bgColor;
//
////自定义title
//-(HButtonChain *(^)(NSString * title))normalTitle;
//
////自定义selectTitle
//-(HButtonChain *(^)(NSString * title))selectTitle;
//
////自定义target action
//-(HButtonChain *(^)(id object, SEL method))action;

@end
