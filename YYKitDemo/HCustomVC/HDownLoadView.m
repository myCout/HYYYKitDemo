//
//  HDownLoadView.m
//  YYKitDemo
//
//  Created by HY on 2017/1/22.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HDownLoadView.h"
/*  animation key  */

static NSString  * kLineToPointUpAnimationKey = @"kLineToPointUpAnimationKey";

static NSString  * kArrowToLineAnimationKey = @"kArrowToLineAnimationKey";

static NSString  * kProgressAnimationKey = @"kProgressAnimationKey";

static NSString  * kSuccessAnimationKey = @"kSuccessAnimationKey";
/*************     animationWithKeyPath     **************/
//比例转化
static  NSString *keyPath_Scale = @"transform.scale";
//宽的比例
static  NSString *keyPath_ScaleX = @"transform.scale.x";
///高的比例
static  NSString *keyPath_ScaleY = @"transform.scale.y";
//围绕x轴旋转
static  NSString *keyPath_RotationX = @"transform.rotation.x";
//围绕y轴旋转
static  NSString *keyPath_RotationY = @"transform.rotation.y";
//围绕z轴旋转
static  NSString *keyPath_RotationZ = @"transform.rotation.z";
//圆角的设置
static  NSString *keyPath_Radius = @"cornerRadius";
//
static  NSString *keyPath_bgColor = @"backgroundColor";
//
static  NSString *keyPath_Bounds = @"bounds";
//
static  NSString *keyPath_Position = @"position";

static  NSString *keyPath_PositionX = @"position.x";

static  NSString *keyPath_PositionY = @"position.y";

static  NSString *keyPath_Path = @"path";

static  NSString *keyPath_Contents = @"contents";

static  NSString *keyPath_Opacity = @"opacity";

static  NSString *keyPath_ContentW = @"contentsRect.size.width";

@interface HDownLoadView ()<CAAnimationDelegate>
@property (nonatomic, retain) CAShapeLayer *arrowLayer;
@property (nonatomic, retain) CAShapeLayer *verticalLineLayer;

@property (nonatomic, retain) CAShapeLayer *maskCircleLayer;

@property (nonatomic, retain) UIBezierPath *verticalLineStartPath;
@property (nonatomic, retain) UIBezierPath *verticalLineEndPath;

/**    关键帧    **/
@property (nonatomic, strong) UIBezierPath *arrowStartPath;
@property (nonatomic, strong) UIBezierPath *arrowDownPath;
@property (nonatomic, strong) UIBezierPath *arrowMidtPath;
@property (nonatomic, strong) UIBezierPath *arrowEndPath;

@end
@implementation HDownLoadView

- (void)drawRect:(CGRect)rect {
    UIColor *brushColor = [UIColor whiteColor];
    
//    // 根据一个Rect 画一个矩形曲线
//    UIBezierPath *rectangular = [UIBezierPath bezierPathWithRect:self.bounds];
//    [rectangular fill];
//    [[UIColor whiteColor] set];
//    [rectangular stroke];
     [self.layer addSublayer:self.maskCircleLayer];
    
    [self.layer addSublayer:self.verticalLineLayer];
    
    self.backgroundColor = brushColor;
   
    //箭头开始
    self.arrowLayer.path = self.arrowStartPath.CGPath;
    
    
    UIBezierPath *verticalLinePath = [UIBezierPath bezierPath];
    [verticalLinePath moveToPoint:CGPointMake(100, 33)];
    [verticalLinePath addLineToPoint:CGPointMake(100, 180)];
//    [verticalLinePath moveToPoint:CGPointMake(100, 180)];
//    [verticalLinePath addLineToPoint:CGPointMake(50,33)];
    _verticalLineStartPath = verticalLinePath;
    self.verticalLineLayer.path = _verticalLineStartPath.CGPath;
    
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self startAnimation];
}

- (void)startAnimation{
    CAAnimationGroup *lineAnimation = [self getLineToPointUpAnimationWithValues:@[(__bridge id)self.verticalLineStartPath.CGPath,
                                                                                          (__bridge id)self.verticalLineEndPath.CGPath
                                                                                          ]];
    
    lineAnimation.delegate  = self;
    [self.verticalLineLayer addAnimation:lineAnimation forKey:kLineToPointUpAnimationKey];
    CAAnimationGroup*arrowGroup = [self getArrowToLineAnimationWithValues:@[
                                                                                    (__bridge id)self.arrowStartPath.CGPath,
                                                                                    (__bridge id)self.arrowDownPath.CGPath,
                                                                                   
                                                                                    
                                                                                    ]];// (__bridge id)self.arrowMidtPath.CGPath,(__bridge id)self.arrowEndPath.CGPath
    arrowGroup.delegate  = self;
    [self.arrowLayer addAnimation:arrowGroup forKey:kArrowToLineAnimationKey];

    
}



- (CAAnimationGroup *)getLineToPointUpAnimationWithValues:(NSArray *)values{
    
    CAKeyframeAnimation *lineAnimation = [CAKeyframeAnimation animationWithKeyPath:keyPath_Path];
    lineAnimation.values = values;
    lineAnimation.keyTimes = @[@0,@.15];
    lineAnimation.beginTime= 0.0;
    
    CASpringAnimation *lineUpAnimation = [CASpringAnimation animationWithKeyPath: keyPath_PositionY];
    lineUpAnimation.toValue = @6;
    lineUpAnimation.damping = 10;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    lineUpAnimation.mass = 1;//质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    lineUpAnimation.initialVelocity = 0;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    
    //    lineUpAnimation.duration = lineUpAnimation.settlingDuration;
    lineUpAnimation.beginTime= 0.50;
    lineUpAnimation.removedOnCompletion = NO;
    lineUpAnimation.fillMode = kCAFillModeForwards;
    // 线->点 and 上弹
    CAAnimationGroup *lineGroup = [CAAnimationGroup animation];
    lineGroup.delegate = self;
    lineGroup.animations = @[lineAnimation,lineUpAnimation];//,lineUpAnimation
    lineGroup.duration = 1.5;
    lineGroup.repeatCount = 1;
    lineGroup.removedOnCompletion = NO;
    lineGroup.fillMode = kCAFillModeForwards;
    lineGroup.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return lineGroup;
}

- (CAAnimationGroup *)getArrowToLineAnimationWithValues:(NSArray *)values{
    
    CAKeyframeAnimation *arrowChangeAnimation = [CAKeyframeAnimation animationWithKeyPath:keyPath_Path];
    arrowChangeAnimation.values = values;
    arrowChangeAnimation.keyTimes = @[@0,@.15,@.25,@.28];
    //箭头形变直线
    CAAnimationGroup *arrowGroup = [CAAnimationGroup animation];
    arrowGroup.delegate  = self;
    arrowGroup.animations = @[arrowChangeAnimation];
    arrowGroup.duration  = 2;
    arrowGroup.repeatCount  = 1;
    arrowGroup.timingFunction  = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return arrowGroup;
}


- (CAShapeLayer *)getOriginLayer{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = [self bounds];
    layer.lineWidth = 4;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    return layer;
}

- (CAShapeLayer *)maskCircleLayer{
    
    if (!_maskCircleLayer) {
        _maskCircleLayer = [self getOriginLayer];
        _maskCircleLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:[self bounds]];
        _maskCircleLayer.path = path.CGPath;
        
    }
    return _maskCircleLayer;
}


- (CAShapeLayer *)arrowLayer{
    
    if (!_arrowLayer) {
        _arrowLayer = [CAShapeLayer layer];
        _arrowLayer.frame = [self bounds];
        _arrowLayer.strokeColor = [UIColor  greenColor].CGColor;
        _arrowLayer.lineCap = kCALineCapRound;
        _arrowLayer.lineWidth = 3;//self.progressWidth-1;
        _arrowLayer.fillColor = [UIColor clearColor].CGColor;
        _arrowLayer.lineJoin = kCALineJoinRound;
        [self.layer addSublayer:self.arrowLayer];
    }
    return _arrowLayer;
}

- (CAShapeLayer *)verticalLineLayer{
    
    if (!_verticalLineLayer) {
        _verticalLineLayer = [CAShapeLayer layer];
        _verticalLineLayer.frame = [self bounds];
        _verticalLineLayer.strokeColor = [UIColor whiteColor].CGColor;
        _verticalLineLayer.lineCap = kCALineCapRound;
        _verticalLineLayer.lineWidth = 3;
        _verticalLineLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:self.verticalLineLayer];
        
    }
    return _verticalLineLayer;
}

- (UIBezierPath *)verticalLineEndPath{
    if (!_verticalLineEndPath) {
        _verticalLineEndPath = [UIBezierPath bezierPath];
        [_verticalLineEndPath moveToPoint:CGPointMake(100, 100)];
        [_verticalLineEndPath addLineToPoint:CGPointMake(100, 99.5)];
    }
    
    return _verticalLineEndPath;
}

//箭头开始
- (UIBezierPath *)arrowStartPath{
    _arrowStartPath = [UIBezierPath bezierPath];
    [_arrowStartPath moveToPoint:CGPointMake(100, 180)];
    [_arrowStartPath addLineToPoint:CGPointMake(150,133)];
    [_arrowStartPath moveToPoint:CGPointMake(100, 180)];
    [_arrowStartPath addLineToPoint:CGPointMake(50,133)];
    return _arrowStartPath;
}
//箭头开始
- (UIBezierPath *)arrowDownPath{
    _arrowDownPath = [UIBezierPath bezierPath];
    [_arrowDownPath moveToPoint:CGPointMake(100, 180)];
    [_arrowDownPath addLineToPoint:CGPointMake(100,133)];
//    [_arrowDownPath addLineToPoint:CGPointMake(110, 133)];
    return _arrowDownPath;
}
//箭头开始
- (UIBezierPath *)arrowMidtPath{
    
    _arrowMidtPath = [UIBezierPath bezierPath];
//    [_arrowMidtPath moveToPoint:CGPointMake(midPointX, halfSquare)];
//    [_arrowMidtPath addLineToPoint:CGPointMake(midPointX+lineW/2,halfSquare-kSpacing*2)];
//    [_arrowMidtPath addLineToPoint:CGPointMake(midPointX+lineW, halfSquare)];
    return _arrowMidtPath;
}


@end
