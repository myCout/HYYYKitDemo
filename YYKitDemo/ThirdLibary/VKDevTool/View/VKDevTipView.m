//
//  VKTipView.m
//
//  Created by Awhisper on 16/8/7.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "VKDevTipView.h"

@implementation VKDevTipView

-(instancetype)initWithMsg:(NSString*)msg{
    BOOL statusBarShow = [UIApplication sharedApplication].isStatusBarHidden;
    
    
    self = [super initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,statusBarShow?20:40)];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(0, statusBarShow?0:20, self.bounds.size.width, 20)];
        tip.textColor = [UIColor whiteColor];
        tip.font = [UIFont systemFontOfSize:18];
        tip.textAlignment = NSTextAlignmentCenter;
        tip.text = msg;
        [self addSubview:tip];
    }
    return self;
}

+(void)showVKDevTip:(NSString *)msg
{
    [self showVKDevTip:msg autoHide:YES];
}

+(void)hideVKDevTip
{
    [UIView animateWithDuration:1.0f animations:^{
        UIView *window = [UIApplication sharedApplication].keyWindow;
        for (UIView *sub in window.subviews) {
            if ([sub isKindOfClass:[VKDevTipView class]]) {
                [sub removeFromSuperview];
            }
        }
    }];
}

+(void)showVKDevTip:(NSString *)msg autoHide:(BOOL)hide
{
    VKDevTipView *tip = [[VKDevTipView alloc]initWithMsg:msg];
    UIView *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:tip];
    
    if (hide) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                tip.alpha = 0;
            } completion:^(BOOL finished) {
                [tip removeFromSuperview];
            }];
        });
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
