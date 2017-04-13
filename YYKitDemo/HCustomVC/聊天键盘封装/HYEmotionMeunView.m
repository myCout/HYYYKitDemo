//
//  HYEmotionMeunView.m
//  YYKitDemo
//
//  Created by HY on 2017/3/23.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HYEmotionMeunView.h"
#import "NSString+Extension.h"
@interface HYEmotionMeunView()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *sendButton;
@property(nonatomic,strong)UIButton *selectedBtn;
@end

@implementation HYEmotionMeunView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupBtn:[@"0x1f603" emoji] buttonType:HYEmotionMenuButtonTypeEmoji];
        [self setupBtn:@"Custom" buttonType:HYEmotionMenuButtonTypeCuston];
    }
    return self;
}

/**
 *  创建按钮
 *
 *  @param title      按钮文字
 *  @param buttonType 类型
 *
 *  @return 按钮
 */
- (UIButton *)setupBtn:(NSString *)title
                       buttonType:(HYEmotionMenuButtonType)buttonType
{
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    btn.tag                  = buttonType; // 不要把0作为tag值
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    btn.titleLabel.font  = [UIFont systemFontOfSize:15];
//    [btn setBackgroundImage:[UIImage] forState:UIControlStateNormal];
//    [btn setBackgroundImage: forState:UIControlStateSelected];
    if ([title isEqualToString:@"Custom"]) {
        [btn setImage:[UIImage imageNamed:@"[吓]"] forState:UIControlStateNormal];
    } else {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:26.5];
        btn.selected = YES;
        self.selectedBtn = btn;
    }
    btn.backgroundColor = [UIColor randomColor];
    [self.scrollView addSubview:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count      = self.scrollView.subviews.count;
    //    CGFloat btnW          = self.width/(count+1);
    CGFloat btnW          = 60;
    self.scrollView.frame = CGRectMake(0, 0, self.width-btnW, self.height);
    self.sendButton.frame    = CGRectMake(self.width-btnW, 0, btnW, self.height);
    CGFloat btnH          = self.height;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = self.scrollView.subviews[i];
        btn.y                    = 0;
        btn.width                = (int)btnW;// 去除小缝隙
        btn.height               = btnH;
        btn.x                    = (int)btnW * i;
    }
}

-(void)setDelegate:(id<HYEmotionMeunViewDelegate>)delegate{
    _delegate = delegate;
}

#pragma mark - 发送  menu 菜单的发送按钮
- (void)sendBtnClicked:(UIButton *)sendBtn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HYEmotionDidSendNotification" object:nil];
}

- (void)btnClicked:(UIButton *)button
{
    self.selectedBtn.selected = NO;
    button.selected           = YES;
    self.selectedBtn         = button;
    if ([self.delegate respondsToSelector:@selector(emotionMenu:didSelectButton:)]) {
        [self.delegate emotionMenu:self didSelectButton:(int)button.tag];
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setScrollsToTop:NO];
        [self addSubview:_scrollView];
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
    }
    return _scrollView;
}

@end
