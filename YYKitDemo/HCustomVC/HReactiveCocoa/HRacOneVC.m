//
//  HRacOneVC.m
//  YYKitDemo
//
//  Created by HY on 2017/3/2.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HRacOneVC.h"

@interface HRacOneVC ()
@property (nonatomic, retain) UIButton *hTestBtn;
@end

@implementation HRacOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}



- (void)initUI{
    [self.view addSubview:self.hTestBtn];
    self.hTestBtn.sd_layout.leftSpaceToView(self.view,100)
    .topSpaceToView(self.view,100)
    .widthIs(100)
    .heightIs(34);
}


-(UIButton *)hTestBtn{
    if (_hTestBtn == nil) {
        _hTestBtn = [UIButton new];
        _hTestBtn.backgroundColor = [UIColor randomColor];
        [_hTestBtn setTitleColor:[UIColor randomColor] forState:UIControlStateNormal];
        [_hTestBtn setTitle:@"点击" forState:UIControlStateNormal];
        WS(weakSelf)
        [_hTestBtn jk_addActionHandler:^(NSInteger tag) {
            if (weakSelf.delegateSignal) {
                [weakSelf.delegateSignal sendNext:nil];
            }
        }];
    }
    return _hTestBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
