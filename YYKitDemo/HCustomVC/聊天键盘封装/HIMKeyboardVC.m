//
//  HIMKeyboardVC.m
//  YYKitDemo
//
//  Created by HY on 2017/3/16.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HIMKeyboardVC.h"
#import "HYKeyBoard.h"

@interface HIMKeyboardVC ()
@property (nonatomic, retain) HYKeyBoard *hKeyboard;
@end

@implementation HIMKeyboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"SCREEN_HEIGHT = %f",SCREEN_HEIGHT);
    HYKeyBoard *kb = [[HYKeyBoard alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - HEIGHT_TABBAR, SCREEN_WIDTH,HEIGHT_TABBAR)];
    kb.backgroundColor = [UIColor clearColor];
    _hKeyboard = kb;
    [self.view addSubview:kb];
//    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    self.hKeyboard.status = HYChatKBStatusNothing;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
