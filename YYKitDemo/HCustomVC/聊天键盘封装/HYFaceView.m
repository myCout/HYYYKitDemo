//
//  HYFaceView.m
//  YYKitDemo
//
//  Created by HY on 2017/3/23.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HYFaceView.h"
#import "HYEmotionMeunView.h"
#import "LXEmotionListView.h"
#import "LXEmotionManager.h"

#define bottomViewH 36.0

@interface HYFaceView ()<HYEmotionMeunViewDelegate>

@property(nonatomic,strong)HYEmotionMeunView *menuView;

@property(nonatomic,weak)LXEmotionListView *showingListView;

@property(nonatomic,strong)LXEmotionListView *emojiListView;
@property(nonatomic,strong)LXEmotionListView *customListView;
@property(nonatomic,strong)LXEmotionListView *gifListView;

@end

@implementation HYFaceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.menuView = [[HYEmotionMeunView alloc]init];
        self.menuView.delegate =self;
//        self.menuView.width = self.width;
//        self.menuView.height = bottomViewH;
//        self.menuView.x = 0;
//        self.menuView.y = self.height - self.menuView.height;
        self.menuView.backgroundColor = [UIColor randomColor];
        [self addSubview:self.menuView];
        
        self.showingListView = self.emojiListView;
//            self.showingListView.x = self.showingListView.y = 0;
//            self.showingListView.width = self.width;
//            self.showingListView.height = self.menuView.y;
        [self addSubview:self.showingListView];
        self.backgroundColor =[UIColor grayColor];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.menuView.width = self.width;
    self.menuView.height = bottomViewH;
    self.menuView.x = 0;
    self.menuView.y = self.height - self.menuView.height;
    
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.menuView.y;
    
}

#pragma mark - HYEmotionMeunViewDelegate

- (void)emotionMenu:(HYEmotionMeunView *)menu didSelectButton:(HYEmotionMenuButtonType)buttonType
{
    [self.showingListView removeFromSuperview];
    switch (buttonType) {
        case HYEmotionMenuButtonTypeEmoji:
            [self addSubview:self.emojiListView];
            break;
        case HYEmotionMenuButtonTypeCuston:
            [self addSubview:self.customListView];
            break;
        case HYEmotionMenuButtonTypeGif:
            [self addSubview:self.gifListView];
            break;
        default:
            break;
    }
    self.showingListView = [self.subviews lastObject];
    [self setNeedsLayout];
}

-(LXEmotionListView *)emojiListView{
    if (!_emojiListView) {
        _emojiListView =[[LXEmotionListView alloc]init];
        _emojiListView.emotions  = [LXEmotionManager emojiEmotion];
    }
    return _emojiListView;
}
-(LXEmotionListView *)customListView{
    if (!_customListView) {
        _customListView =[[LXEmotionListView alloc]init];
        _customListView.emotions = [LXEmotionManager customEmotion];
        
        
    }
    return _customListView;
}
-(LXEmotionListView *)gifListView{
    if (!_gifListView) {
        _gifListView =[[LXEmotionListView alloc]init];
    }
    return _gifListView;
}

@end
