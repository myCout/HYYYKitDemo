//
//  HYEmotionMeunView.h
//  YYKitDemo
//
//  Created by HY on 2017/3/23.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HYEmotionMenuButtonTypeEmoji = 100,
    HYEmotionMenuButtonTypeCuston,
    HYEmotionMenuButtonTypeGif
    
} HYEmotionMenuButtonType;

@class HYEmotionMeunView;

@protocol HYEmotionMeunViewDelegate <NSObject>

@optional
- (void)emotionMenu:(HYEmotionMeunView *)menu
    didSelectButton:(HYEmotionMenuButtonType)buttonType;

@end

@interface HYEmotionMeunView : UIView
@property(nonatomic,weak)id<HYEmotionMeunViewDelegate>delegate;
@end
