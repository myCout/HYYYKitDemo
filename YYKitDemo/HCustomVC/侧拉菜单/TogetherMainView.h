//
//  TogetherMainView.h
//  UIView的生命周期
//
//  Created by HY on 2017/3/1.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LEFTVIEWWIDTH 280

@interface TogetherMainView : UIView

@property (nonatomic, assign) float centerX;
@property (nonatomic, assign) float centerY;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong) UIButton *leftBtn;

@end
