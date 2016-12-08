//
//  HBulletView.m
//  YYKitDemo
//
//  Created by HY on 2016/12/7.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HBulletView.h"

#define Padding 10

@interface HBulletView ()
@property (nonatomic, retain) UILabel *hCommentLab;
@end

@implementation HBulletView

- (instancetype)initWithComment:(NSString *)comment{
    if (self == [super init]) {
        CGFloat width = [comment widthForFont:self.hCommentLab.font];
        self.bounds = CGRectMake(0, 0, width + 2 *Padding, 30);
        self.hCommentLab.text = comment;
        self.hCommentLab.frame = CGRectMake(Padding, 0, width, 30);
        [self addSubview:self.hCommentLab];
    }
    return self;
}

- (void)startAnimation{
    //根据弹幕长度执行动画效果
    //更加 v = s/t ，时间相同情况下，距离越长，速度就越快
    CGFloat duration = 4.0f;
    CGFloat wholeWidth = SCREEN_WIDTH + self.width;
    __block CGRect frame = self.frame;
    //弹幕开始
    if (self.hMoveStatusBlock) {
        self.hMoveStatusBlock(Start);
    }
    //t = s/v
    CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = self.width/speed;
    [self performSelector:@selector(EnterScreen) withObject:nil afterDelay:enterDuration];
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];//暂停当前对象上面的延迟函数？
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.hMoveStatusBlock) {
            self.hMoveStatusBlock(End);
        }
    }];
}

- (void)stopAnimation{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//暂停当前对象上面的延迟函数？
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)EnterScreen{
    if (self.hMoveStatusBlock) {
        self.hMoveStatusBlock(Enter);
    }
}

- (UILabel *)hCommentLab{
    if(!_hCommentLab){
        _hCommentLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _hCommentLab.font = [UIFont systemFontOfSize:14];
        _hCommentLab.textAlignment = NSTextAlignmentCenter;
        _hCommentLab.textColor = [UIColor whiteColor];
        _hCommentLab.backgroundColor = [UIColor redColor];
    }
    return _hCommentLab;
}
@end
