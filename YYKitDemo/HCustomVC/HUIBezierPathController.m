//
//  HUIBezierPathController.m
//  YYKitDemo
//
//  Created by HY on 2017/1/22.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HUIBezierPathController.h"
#import "DrawingBoard.h"

@interface HUIBezierPathController ()

@end

@implementation HUIBezierPathController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

//- (void)drawRect:(CGRect)rect{
//    UIColor *brushColor = [UIColor whiteColor];
//    //根据一个Rect 画一个矩形曲线
//    UIBezierPath *rectangular = [UIBezierPath bezierPathWithRect:CGRectMake(5, 5, 30, 30)];
//    [[UIColor redColor] set];
//    // 填充颜色
//    [rectangular fill];
//    [brushColor set];
//    // 利用当前绘图属性沿着接收器的路径绘制
//    [rectangular stroke];
//}

- (void)initUI{
    
    DrawingBoard *darwView = [DrawingBoard new];
    [self.view addSubview:darwView];
    
    darwView.sd_layout.leftSpaceToView(self.view,20)
    .topSpaceToView(self.view,20)
    .widthIs(self.view.width-20*2)
    .heightIs(300);
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
