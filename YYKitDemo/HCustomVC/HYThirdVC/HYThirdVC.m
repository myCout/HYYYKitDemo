//
//  HYThirdVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/4.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYThirdVC.h"
#import "HEmailTextField.h"

@interface HYThirdVC (){
    NSString *test;
}

@property (nonatomic, retain) HEmailTextField *hTextField;

@property (nonatomic, retain) UILabel *hFixBugLabel;

@property (nonatomic, retain) UIImageView *programImageView;

@end

@implementation HYThirdVC

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.hTextField];
    [self.view addSubview:self.hFixBugLabel];
    
    NSArray *arr = @[@"1",@"2",@"3"];
//    self.hFixBugLabel.text = arr[3];
//    if (arr.count>3) {
//        self.hFixBugLabel.text = arr[3];
//    }else{
//        self.hFixBugLabel.text = [arr lastObject];
//    }
    [self.programImageView sd_setImageWithURL:[NSURL URLWithString:@"http://st.dailyyoga.com/data/c4/e4/c4e470d066cb38c34e71711daff34623.jpeg"]];
    [self.view addSubview:_programImageView];
}
- (UIImageView *)programImageView
{
    if (_programImageView == nil) {
        _programImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250 , SCREEN_WIDTH, 124)];
        _programImageView.backgroundColor = [UIColor grayColor];
        _programImageView.contentMode = UIViewContentModeScaleAspectFill;
        _programImageView.clipsToBounds = YES;
    }
    return _programImageView;
}

- (HEmailTextField*)hTextField{
    if (_hTextField == nil) {
        _hTextField = [[HEmailTextField alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 44) InView:self.view];
        _hTextField.placeholder = @"输入用户邮箱";
        _hTextField.backgroundColor = [UIColor lightGrayColor];
    }
    return _hTextField;
}

- (UILabel*)hFixBugLabel{
    if (_hFixBugLabel == nil) {
        _hFixBugLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.hTextField.bottom + 15, SCREEN_WIDTH - 30, 44)];
        _hFixBugLabel.text = @"This is a bug";
    }
    return _hFixBugLabel;
}
@end
