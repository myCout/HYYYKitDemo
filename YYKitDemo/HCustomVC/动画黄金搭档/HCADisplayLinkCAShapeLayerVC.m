//
//  HCADisplayLinkCAShapeLayerVC.m
//  YYKitDemo
//
//  Created by HY on 2016/12/6.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HCADisplayLinkCAShapeLayerVC.h"

@interface HCADisplayLinkCAShapeLayerVC ()
// 积分 view
@property (nonatomic, strong) UIButton *integralView;
// 卡券 view
@property (nonatomic, strong) UIButton *cartCenterView;
// 签到 view
@property (nonatomic, strong) UIButton *signInView;
@end

@implementation HCADisplayLinkCAShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initTest];
    [self TestCABasicAnimation];
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

//CABasicAnimation
- (void)TestCABasicAnimation{
    [self.view addSubview:self.signInView];
    [self.view addSubview:self.cartCenterView];
    [self.view addSubview:self.integralView];
    
    self.signInView.sd_layout.leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .widthIs(self.view.width)
    .heightIs(100);
    
    self.cartCenterView.sd_layout.leftSpaceToView(self.view,0)
    .topSpaceToView(self.signInView,20)
    .widthIs(self.signInView.width/2)
    .heightIs(self.signInView.height);
}
#pragma mark - event response
// 点击 事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self springAnimation];
//    [self basicAnimationOfPosition];
//    [self groupAnimation];
//    [self transitionAni];
//    [self positionKeyFrameAnimation];
//     [self rotationKeyFrameAnimation];
//    [self ellipsePathKeyframeAnimation];
//    [self sinPathKeyframeAnimation];
//    [self transFormLikeRotationKeyframeAnimation];
//    [self transformKeyFrameAnimation];
//    [self basicAnimationOfShadowoffset];
//    [self basicAnimationOfBorderWidth];
//    [self basicAnimationOfBackgroundColor];
//    [self basicAnimationOfSize];
    [self basicAnimationOfTransformGroup];
//    [self rotationKeyFrameAnimation];
//    [self rotationKeyFrameAnimation];
//    [self rotationKeyFrameAnimation];
//    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    //    [self rotationKeyFrameAnimation];
    
}
#pragma mark -  CASpringAnimation-弹簧 动画
// 弹簧 动画
- (void)springAnimation {
    CASpringAnimation * ani = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    ani.mass = 10.0; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    ani.stiffness = 500; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    ani.damping = 100.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    ani.initialVelocity = 30.f;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    ani.duration = ani.settlingDuration;
    ani.toValue = [NSNumber numberWithFloat:1.5];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cartCenterView.layer addAnimation:ani forKey:@"boundsAni"];
}
#pragma mark - 基本 动画
// position 基本 动画
- (void)basicAnimationOfPosition {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position"];
    ani.toValue = [NSValue valueWithCGPoint:self.signInView.center];
    ani.duration = 1.0f;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cartCenterView.layer addAnimation:ani forKey:@"PositionAni"];
}
#pragma mark -  CAAnimationGroup-组 动画
// 组 动画
- (void)groupAnimation {
    /* 动画1（位置 动画） */
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 80)];

    /* 动画2（绕X轴中心旋转） */
    CABasicAnimation *animation2 =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation2.toValue = [NSNumber numberWithFloat:2*M_PI];

    /* 动画3（缩放动画） */
    CABasicAnimation * animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation3.toValue = [NSNumber numberWithFloat:0.5];

    /* 动画4（透明动画） */
    CABasicAnimation * animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation4.toValue = [NSNumber numberWithFloat:0.5];

    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 3.0;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = [NSArray arrayWithObjects:animation1, animation2, animation3, animation4, nil];
    [self.signInView.layer addAnimation:group forKey:@"transformGoup"];
}


#pragma mark - 转场 动画 CATransition
// 转场 动画
- (void)transitionAni {
    CATransition *ani = [CATransition animation];
    ani.type = kCATransitionFade;
    ani.subtype = kCATransitionFromLeft;
    ani.duration = 3.0f;
    [self.signInView setImage:[UIImage imageNamed:@"f_static_016"] forState:UIControlStateNormal];
    [self.signInView.layer addAnimation:ani forKey:@"transitionAni"];
}

#pragma mark -  CAKeyframeAnimation
/***********************************  position info 动画  **********************************/
// position  动画
- (void)positionKeyFrameAnimation {
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.duration = 5.0f;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(150, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(150, 100)];
    ani.values = @[value1, value2, value3, value4, value5];
    
    ani.keyTimes = [NSArray arrayWithObjects:
                    [NSNumber numberWithFloat:0.0],
                    [NSNumber numberWithFloat:0.2],
                    [NSNumber numberWithFloat:0.3],
                    [NSNumber numberWithFloat:0.6],
                    [NSNumber numberWithFloat:1.0],
                    nil];
    [self.signInView.layer addAnimation:ani forKey:@"PositionKeyFrameAni"];
}

/***********************************  rotation info 动画  **********************************/
// rotation 动画
- (void)rotationKeyFrameAnimation {
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    ani.duration = 5.0f;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    NSValue *value1 = [NSNumber numberWithFloat:0 * M_PI];
    NSValue *value2 = [NSNumber numberWithFloat:0.5 * M_PI];
    NSValue *value3 = [NSNumber numberWithFloat:1 * M_PI];
    NSValue *value4 = [NSNumber numberWithFloat:1.5 * M_PI];
    NSValue *value5 = [NSNumber numberWithFloat:2 * M_PI];
    
    ani.values = @[value1, value2, value3, value4, value5];
    
    [self.signInView.layer addAnimation:ani forKey:nil];
}
/***********************************  path info 动画  **********************************/

// path 圆圈 动画
- (void)ellipsePathKeyframeAnimation {
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 80, 100, 100));
    [ani setPath:path];
    [ani setDuration:3.0];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    CFRelease(path);
    
    [self.signInView.layer addAnimation:ani forKey:@"path"];
}

// path 波浪线 动画
- (void)sinPathKeyframeAnimation {
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50.0, 120.0);
    CGPathAddCurveToPoint(path, NULL, 50.0, 275.0, 150.0, 275.0, 150.0, 120.0);
    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,250.0,120.0);
    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,350.0,120.0);
    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,450.0,120.0);
    
    
    [anim setPath:path];
    [anim setDuration:3.0];
    [anim setAutoreverses:YES];
    CFRelease(path);
    [self.signInView.layer addAnimation:anim forKey:@"sinPathAni"];
}

/***********************************  transform info 动画  **********************************/

// transform 模仿 rotation 动画
- (void)transFormLikeRotationKeyframeAnimation {
    
    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D rotation1 = CATransform3DMakeRotation(30 * M_PI/180, 0, 0, -1);
    CATransform3D rotation2 = CATransform3DMakeRotation(60 * M_PI/180, 0, 0, -1);
    CATransform3D rotation3 = CATransform3DMakeRotation(90 * M_PI/180, 0, 0, -1);
    CATransform3D rotation4 = CATransform3DMakeRotation(120 * M_PI/180, 0, 0, -1);
    CATransform3D rotation5 = CATransform3DMakeRotation(150 * M_PI/180, 0, 0, -1);
    CATransform3D rotation6 = CATransform3DMakeRotation(180 * M_PI/180, 0, 0, -1);
    
    [keyAnim setValues:[NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:rotation1],
                        [NSValue valueWithCATransform3D:rotation2],
                        [NSValue valueWithCATransform3D:rotation3],
                        [NSValue valueWithCATransform3D:rotation4],
                        [NSValue valueWithCATransform3D:rotation5],
                        [NSValue valueWithCATransform3D:rotation6],
                        nil]];
    
    [keyAnim setKeyTimes:[NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:0.2f],
                          [NSNumber numberWithFloat:0.4f],
                          [NSNumber numberWithFloat:0.6f],
                          [NSNumber numberWithFloat:0.8f],
                          [NSNumber numberWithFloat:1.0f],
                          nil]];
    [keyAnim setDuration:4];
    [keyAnim setFillMode:kCAFillModeForwards];
    [keyAnim setRemovedOnCompletion:NO];
    [self.signInView.layer addAnimation:keyAnim forKey:nil];
}


// transform 动画
- (void)transformKeyFrameAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.3],
                           [NSNumber numberWithFloat:0.7],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 2.0f;
    
    [self.signInView.layer addAnimation:animation forKey:@"transformAni"];
}


#pragma mark -  CABasicAnimation
/***********************************  shadow info 动画  **********************************/
// shadowOffset 基本 动画
- (void)basicAnimationOfShadowoffset {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    ani.fromValue = [NSValue valueWithCGSize:CGSizeMake(3,4)];
    ani.toValue = [NSValue valueWithCGSize:CGSizeMake(13, 10)];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"ShadowOffsetAni"];
}


// shadowColor 基本 动画
- (void)basicAnimationOfShadowColor {
    self.signInView.layer.shadowOpacity = 1.0f;
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"shadowColor"];
    ani.fromValue = (id)[UIColor blackColor].CGColor;
    ani.toValue = (id)[UIColor greenColor].CGColor;
    ani.removedOnCompletion = NO;
    ani.duration = 3.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"ShadowColorAni"];
}


// shadowOpacity 基本 动画
- (void)basicAnimationOfShadowOpacity {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    ani.fromValue = [NSNumber numberWithFloat:1.0f];
    ani.toValue = [NSNumber numberWithFloat:0.3];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"ShadowOpacityAni"];
}

#pragma mark - shadowRadius 基本 动画
// shadowRadius 基本 动画
- (void)basicAnimationOfShadowRadius {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    ani.fromValue = [NSNumber numberWithFloat:1.0f];
    ani.toValue = [NSNumber numberWithFloat:20.0f];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"ShadowRadiusAni"];
}
#pragma mark - contents 动画
/***********************************  contents 动画  **********************************/
// contents 基本 动画
- (void)basicAnimationOfContents {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"contents"];
    ani.toValue = (id)[UIImage imageNamed:@"serviceActivity.png"].CGImage;
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.imageView.layer addAnimation:ani forKey:@"ContentsAni"];
}


#pragma mark -  border info 动画
/***********************************  border info 动画  **********************************/
// borderWidth 基本 动画
- (void)basicAnimationOfBorderWidth {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    ani.toValue = [NSNumber numberWithFloat:10];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"BorderWidthAni"];
}


// borderColor 基本 动画
- (void)basicAnimationOfBordeColor {
    self.signInView.backgroundColor = [UIColor greenColor];
    [self.signInView setImage:nil forState:UIControlStateNormal];
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    ani.toValue = (id)[UIColor blueColor].CGColor;
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"BorderColorAni"];
}


// cornerRadius 基本 动画
- (void)basicAnimationOfCornerRadius {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    ani.toValue = [NSNumber numberWithFloat:30];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"CornerRadiusAni"];
}

#pragma mark - backgroundColor 动画
/***********************************  backgroundColor 动画  **********************************/
// backgroundColor 基本 动画
- (void)basicAnimationOfBackgroundColor {
    [self.signInView setImage:nil forState:UIControlStateNormal];
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    ani.toValue = (id)[UIColor greenColor].CGColor;
    ani.removedOnCompletion = NO;
    ani.duration = 3.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"BackgroundColorAni"];
}

#pragma mark - opacity 动画
/***********************************  opacity 动画  **********************************/
// opacity 基本 动画
- (void)basicAnimationOfOpacity {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
    ani.toValue = [NSNumber numberWithFloat:0];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"OpacityAni"];
}


#pragma mark - size 动画
/***********************************  size 动画  **********************************/
// size 基本 动画
- (void)basicAnimationOfSize {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    ani.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 50)];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"SizeAni"];
}


// sizeW 基本 动画
- (void)basicAnimationOfSizeW {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    ani.toValue = [NSNumber numberWithFloat:450];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"SizeWAni"];
}

// sizeH 基本 动画
- (void)basicAnimationOfSizeH {
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    ani.toValue = [NSNumber numberWithFloat:150];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"SizeWAni"];
}
#pragma mark - bound 动画
/***********************************  bound 动画  **********************************/
// bound 基本 动画
- (void)basicAnimationOfBounds {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"bounds"];
    ani.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 50)];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"BoundsAni"];
}
#pragma mark - translation 组合 动画
/***********************************  transform 组合 动画  **********************************/

// transform 组合 动画
- (void)basicAnimationOfTransformGroup {
    /* 动画1（在X轴方向移动） */
    CABasicAnimation *animation1 =
    [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(100, -100)];
    
    
    /* 动画2（绕X轴中心旋转） */
    CABasicAnimation *animation2 =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation2.toValue = [NSNumber numberWithFloat:2*M_PI];
    
    
    /* 动画3（缩放动画） */
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation3.toValue = [NSNumber numberWithFloat:0.5];
    
    /* 动画3（缩放动画） */
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation3.toValue = [NSNumber numberWithFloat:0.5];
    
    
    /* 动画组 */
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.0;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations = [NSArray arrayWithObjects:animation2, animation1, animation3, nil];
    [self.signInView.layer addAnimation:group forKey:@"transformGoup"];
}
#pragma mark - translation
/***********************************translation**********************************/
// translationX 基本 动画
- (void)basicAnimationOfTranslation {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    ani.toValue = [NSNumber numberWithFloat:60];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"TranslationAni"];
}


// translationY 基本 动画
- (void)basicAnimationOfTranslationY {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    ani.toValue = [NSNumber numberWithFloat:-60];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"TranslationAniY"];
}


// translationX 基本 动画
- (void)basicAnimationOfTranslationX {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    ani.toValue = [NSNumber numberWithFloat:60];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"TranslationAniX"];
}

#pragma mark - scale
/***********************************  scale  **********************************/

// scale 基本 动画
- (void)basicAnimationOfScale {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani.toValue = [NSNumber numberWithFloat:0.8];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"ScaleAni"];
}

// scaleX 基本 动画
- (void)basicAnimationOfScaleX {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    ani.toValue = [NSNumber numberWithFloat:1.5];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"ScaleXAni"];
}

// scaleY 基本 动画
- (void)basicAnimationOfScaleY {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    ani.toValue = [NSNumber numberWithFloat:1.5];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"ScaleYAni"];
}

/***********************************  position  **********************************/

// position.x 基本 动画
- (void)basicAnimationOfPositionX {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position.x"];
    ani.toValue = [NSNumber numberWithFloat:self.signInView.center.x];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cartCenterView.layer addAnimation:ani forKey:@"PositionXAni"];
}

// position.y 基本 动画
- (void)basicAnimationOfPositionY {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position.y"];
    ani.toValue = [NSNumber numberWithFloat:self.signInView.center.y];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.cartCenterView.layer addAnimation:ani forKey:@"PositionYAni"];
}

/***********************************  rotation  **********************************/

// rotation 基本 动画
- (void)basicAnimationOfRotation {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}

// rotationX 基本 动画
- (void)basicAnimationOfRotationX {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}

// rotationY 基本 动画
- (void)basicAnimationOfRotationY {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}

// rotationZ 基本 动画
- (void)basicAnimationOfRotationZ {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}
#pragma mark - getter and setter
// 签到 view
- (UIButton *)signInView {
    if (!_signInView) {
//        CGFloat signInViewX = 60;
//        CGFloat signInViewY = 120;
//        CGFloat signInViewWidth = self.view.frame.size.width - (2 * signInViewX);
//        CGFloat signInViewHeight = 100.0f;
        _signInView = [UIButton new];
//        _signInView = [[UIButton alloc] initWithFrame:CGRectMake(signInViewX, signInViewY, signInViewWidth, signInViewHeight)];
        _signInView.clipsToBounds = YES;
        [_signInView setImage: [UIImage imageNamed:@"f_static_017"] forState:UIControlStateNormal];
//        [_signInView setTitle:@"签到有礼" forState:UIControlStateNormal];
        _signInView.backgroundColor = [UIColor randomColor];
        [_signInView jk_addActionHandler:^(NSInteger tag) {
            [self basicAnimationOfPosition];
        }];
    }
    return _signInView;
}

// 卡券 view
- (UIButton *)cartCenterView {
    if (!_cartCenterView) {
        
//        CGFloat cartCenterViewX = CGRectGetMinX(self.signInView.frame);
//        CGFloat cartCenterViewY = CGRectGetMaxY(self.signInView.frame) + 10;
//        CGFloat cartCenterViewWidth = self.signInView.frame.size.width/2.0;
//        CGFloat cartCenterViewHeight = 60.0f;
        _cartCenterView = [UIButton new];
//        _cartCenterView = [[UIButton alloc] initWithFrame:CGRectMake(cartCenterViewX, cartCenterViewY, cartCenterViewWidth, cartCenterViewHeight)];
        _cartCenterView.clipsToBounds = YES;
        [_cartCenterView setImage: [UIImage imageNamed:@"f_static_016"] forState:UIControlStateNormal];
        _cartCenterView.backgroundColor = [UIColor randomColor];
    }
    return _cartCenterView;
}

// 积分
- (UIButton *)integralView {
    if (!_integralView) {
        CGFloat integralViewX = CGRectGetMaxX(self.cartCenterView.frame);
        CGFloat integralViewY = CGRectGetMinY(self.cartCenterView.frame);
        CGFloat integralViewWidth = self.signInView.frame.size.width/2.0;
        CGFloat integralViewHeight = self.cartCenterView.frame.size.height;
        
        _integralView = [[UIButton alloc] initWithFrame:CGRectMake(integralViewX, integralViewY, integralViewWidth, integralViewHeight)];
        _integralView = [UIButton new];
        _integralView.clipsToBounds = YES;
        _integralView.backgroundColor = [UIColor randomColor];
        [_integralView setImage: [UIImage imageNamed:@"home_dingdan.png"] forState:UIControlStateNormal];
    }
    return _integralView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
