//
//  HRacView.m
//  YYKitDemo
//
//  Created by HY on 2017/3/3.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HRacView.h"

@interface HRacView ()
@property (nonatomic, retain) UIButton *hTestBtn;
@end

@implementation HRacView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hTestBtn];
        
        self.hTestBtn.sd_layout.topSpaceToView(self,100)
        .leftSpaceToView(self,100)
        .widthIs(200)
        .heightIs(40);
    }
    return self;
}

- (void)testClick:(id)sender{
    self.centerX = 100;
}

-(UIButton *)hTestBtn{
    if (_hTestBtn == nil) {
        _hTestBtn = [UIButton new];
        _hTestBtn.backgroundColor = [UIColor randomColor];
        [_hTestBtn setTitleColor:[UIColor randomColor] forState:UIControlStateNormal];
        [_hTestBtn setTitle:@"点击" forState:UIControlStateNormal];
        [_hTestBtn setCornerRadius:_hTestBtn.height/2];
        [_hTestBtn addTarget:self action:@selector(testClick:) forControlEvents:UIControlEventTouchUpInside];
//        WS(weakSelf)
//        [_hTestBtn jk_addActionHandler:^(NSInteger tag) {
//            
//        }];
    }
    return _hTestBtn;
}


@end
