//
//  TogetherMainView.m
//  UIView的生命周期
//
//  Created by HY on 2017/3/1.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import "TogetherMainView.h"

@implementation TogetherMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect screen = [[UIScreen mainScreen] bounds];
        self.centerX = screen.size.width / 2;
        self.centerY = screen.size.height / 2;
        
        self.backgroundColor = [UIColor greenColor];
        
        [self addSubview:self.leftBtn];
        [self addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}
//当我们在View界面中拖动时就会进入这个方法，我们先设一个CGPoint来获取每次得到的移动距离translation，然后float x就表示当前屏幕中心点的位置（原来的位置加上移动量）。
//由于我写的是一个左侧的菜单，所以中心页应该是不能左移的，假如我们左移，就会造成x < _centerX，那样的话旧把x设成原来的中心点centerX就行了，这样就能阻止中心页左移。（如果想阻止右移把小于改成大于就行了。
//然后就是在拖动效果结束（松开鼠标）时做一个判定，这里为了看起来平滑一点用了一个动画效果，如果拖动距离超过侧边页的一半旧显示出侧边页，否则还原。
//最后还要将recognizer置位零。因为拖动时会多次执行这个方法，如果不置零可能出错。
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer 	translationInView:self];
    float x = self.center.x + translation.x;
    
    if (x < _centerX) {
        x = _centerX;
    }
    self.center = CGPointMake(x, _centerY);
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^(void){
            if (x > (self.centerX + LEFTVIEWWIDTH/2)) {
                self.center = CGPointMake(self.centerX + LEFTVIEWWIDTH, _centerY);
            }else{
                self.center = CGPointMake(_centerX, _centerY);
            }
        }];
    }
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)leftViewAppear
{
    [UIView animateWithDuration:0.2 animations:^(void){
        if (self.center.x == self.centerX) {
            self.center = CGPointMake(self.centerX + LEFTVIEWWIDTH, self.centerY);
        }else if (self.center.x == self.centerX + LEFTVIEWWIDTH) {
            self.center = CGPointMake(self.centerX, self.centerY);
        }
    }];
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (_panGestureRecognizer == nil) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    }
    return _panGestureRecognizer;
}


- (UIButton *)leftBtn
{
    if (_leftBtn == nil) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 120, 40)];
        [_leftBtn setTitle:@"点我弹出菜单" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftViewAppear) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}


@end
