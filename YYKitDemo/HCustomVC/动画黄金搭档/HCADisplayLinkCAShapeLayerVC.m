//
//  HCADisplayLinkCAShapeLayerVC.m
//  YYKitDemo
//
//  Created by HY on 2016/12/6.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HCADisplayLinkCAShapeLayerVC.h"

@interface HCADisplayLinkCAShapeLayerVC ()

@end

@implementation HCADisplayLinkCAShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTest];
}

/**
 *示例代码是通过UIBezierPath和CAShapeLayer来创建一个简单的火柴人。
 *用UIBezierPath来创建任何你想要的路径，使用CAShapeLayer的属性path配合UIBezierPath创建的路径，就可以呈现出我们想要的形状。
 *这个形状不一定要闭合，图层路径也不一定是连续不断的，你可以在CAShapeLayer的图层上绘制好几个不同的形状，但是你只有一次机会去设置它的path、lineWith、lineCap等属性，如果你想同时设置几个不同颜色的多个形状，你就需要为每个形状准备一个图层。
 *
 *
 */
- (void)initTest{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor colorWithRed:147/255.0 green:231/255.0 blue:182/255.0 alpha:1].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.view.layer addSublayer:shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
