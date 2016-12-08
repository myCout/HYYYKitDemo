//
//  HBulletView.h
//  YYKitDemo
//
//  Created by HY on 2016/12/7.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,MoveStatus) {
    Start,
    Enter,
    End
};

typedef void(^HMoveStatusBlock)(MoveStatus status);
@interface HBulletView : UIView

@property (nonatomic) NSUInteger trajectory;//弹道

@property (nonatomic) HMoveStatusBlock hMoveStatusBlock;

- (instancetype)initWithComment:(NSString *)comment;

- (void)startAnimation;

- (void)stopAnimation;

@end
