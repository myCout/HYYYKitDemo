//
//  HYKeyBoard.m
//  YYKitDemo
//
//  Created by HY on 2017/3/16.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HYKeyBoard.h"
#import "HYTextView.h"
#import "HYFaceView.h"
//#define kBCTextViewHeight 36 /**< 底部textView的高度 */
#define kHorizontalPadding 8 /**< 横向间隔 */
#define kVerticalPadding 5 /**< 纵向间隔 */

@interface HYKeyBoard ()<UITextViewDelegate>{
    CGFloat keyboardY;
}
@property(nonatomic,strong)UIView *topContainer;//上侧容器
@property(nonatomic,strong)UIView *bottomCotainer;//下侧容器
/** 表情按钮 */
@property(nonatomic,strong)UIButton *faceButton;

//@property(nonatomic,strong)LXChatBoxFaceView *faceView;
@property (nonatomic,strong)HYFaceView *faceView;

@property (nonatomic,strong)UIButton *faceBtn;
@property (nonatomic,strong)UIButton *moreBtn;
@property (nonatomic,strong)HYTextView  *textView;
@property (nonatomic,strong)UIImageView *backgroundImageView;

@property (nonatomic,strong)UIView *activeView;
@end

@implementation HYKeyBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.status = HYChatKBStatusNothing;
        [self.textView resignFirstResponder];
        [self setUpUI];
        [self addNotification];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setUpUI{
    [self addSubview:self.topContainer];
    [self addSubview:self.bottomCotainer];
    [self.topContainer addSubview:self.faceButton];
    [self.topContainer addSubview:self.textView];
    
    [self.bottomCotainer addSubview:self.faceView];
}


#pragma mark - 设置是否有动画 （一体键盘）
-(void)setIsDisappear:(BOOL)isDisappear{
    _isDisappear = isDisappear;
}

#pragma mark - textview -代理方法-
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.status != HYChatKBStatusShowKeyboard) {
        self.status = HYChatKBStatusShowKeyboard;
        
    }
    [self changeFrame:ceilf([textView sizeThatFits:textView.frame.size].height)];
}
-(void)textViewDidChange:(UITextView *)textView{
    [self changeFrame:ceilf([textView sizeThatFits:textView.frame.size].height)];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        if (self.textView.text.length >0) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(chatBoxSendTextMessage:)]) {
                [self.delegate chatBoxSendTextMessage:self.textView.text];
            }
        }
        self.textView.text = @"";
        self.textView.height = HEIGHT_TEXTVIEW;
        [self textViewDidChange:self.textView];
        return NO;
    }
    return YES;
}

- (void)changeFrame:(CGFloat)height{
    
    CGFloat maxH = 0;
    if (self.maxVisibleLine) {
        maxH = ceil(self.textView.font.lineHeight * (self.maxVisibleLine - 1) + self.textView.textContainerInset.top + self.textView.textContainerInset.bottom);
    }
    self.textView.scrollEnabled = height >maxH && maxH >0;
    if (self.textView.scrollEnabled) {
        height = 5+maxH;
    }else{
        height = height;
    }
    CGFloat textviewH = height;
    
    CGFloat totalH = 0;
    if (self.status == HYChatKBStatusShowFace || self.status == HYChatKBStatusShowMore) {
        totalH = height + BOXTEXTViewSPACE *2 +BOXOTHERH + 64;
        if (keyboardY ==0) {
            keyboardY = SCREEN_HEIGHT;
        }
        self.y = keyboardY - totalH;
        self.height = totalH;
        self.topContainer.height = height + BOXTEXTViewSPACE *2;
        self.bottomCotainer.y =self.topContainer.height;
        self.textView.y = BOXTEXTViewSPACE;
        self.textView.height = textviewH;
        
//        self.talkButton.frame = self.textView.frame;
//        self.moreButton.y =  self.faceButton.y = self.voiceButton.y  = totalH - BOXBTNBOTTOMSPACE- CHATBOX_BUTTON_WIDTH-BOXOTHERH;
        
    }else
    {
        totalH = height + BOXTEXTViewSPACE *2 ;
        self.y = keyboardY - totalH - 64;
        self.height = totalH;
        self.topContainer.height = totalH;
        
        self.textView.y = BOXTEXTViewSPACE;
        self.textView.height = textviewH;
        self.bottomCotainer.y =self.topContainer.height;
        
//        self.talkButton.frame = self.textView.frame;
//        self.moreButton.y =  self.faceButton.y = self.voiceButton.y  = totalH - BOXBTNBOTTOMSPACE- CHATBOX_BUTTON_WIDTH;
    }
    
    if ([self.delegate respondsToSelector:@selector(changeStatusKb:)]) {
        [self.delegate changeStatusKb:self.y];
    }
    
    [self.textView scrollRangeToVisible:NSMakeRange(0, self.textView.text.length)];
}
-(void)setMaxVisibleLine:(NSInteger)maxVisibleLine{
    _maxVisibleLine = maxVisibleLine;
    
    
}
-(void)setDelegate:(id<HYChatKeyBoardDelegate>)delegate{
    _delegate = delegate;
}

#pragma mark - 键盘通知
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    NSLog(@"%@",NSStringFromCGRect(keyboardF));
    keyboardY = keyboardF.origin.y;
    //因为在 切换视图的时候，点击了表情按钮，或者更多按钮，输入框是，键盘弹出在textViewDidBeginEditing 这个方法调用之前就会调用，
    //        self.height = self.textView.height + 2 *BOXTEXTViewSPACE;
    if (self.status == HYChatKBStatusShowMore ||self.status == HYChatKBStatusShowFace) {
        return;
    }
    
    // 执行动画
    if (!_isDisappear) {
        [UIView animateWithDuration:duration animations:^{
            // 工具条的Y值 == 键盘的Y值 - 工具条的高度
            
            if (keyboardF.origin.y > SCREEN_HEIGHT) {
                self.y = SCREEN_HEIGHT - self.height - 64;
            }else
            {
                self.y = keyboardF.origin.y - self.height - 64;
            }
        }];
        if ([self.delegate respondsToSelector:@selector(changeStatusKb:)]) {
            [self.delegate changeStatusKb:self.y];
        }
        
    }
}

-(void)keyboardDidChangeFrame:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    //    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    NSLog(@"%@",NSStringFromCGRect(keyboardF));
    // 工具条的Y值 == 键盘的Y值 - 工具条的高度
    
    if (_isDisappear) {
        if (keyboardF.origin.y > SCREEN_HEIGHT) {
            self.y = SCREEN_HEIGHT - self.height - 64;
        }else
        {
            self.y = keyboardF.origin.y - self.height - 64;
        }
                NSLog(@"2 %f",self.y);
    }
}
#pragma mark - 添加通知
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:LXEmotionDidSelectNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBtnClicked) name:LXEmotionDidDeleteNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessage) name:LXEmotionDidSendNotification object:nil];
}


-(void)faceButtonDown:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        self.status = HYChatKBStatusShowFace;
    }else{
        self.status = HYChatKBStatusShowKeyboard;
    }
}
#pragma mark - 键盘状态
-(void)setStatus:(HYChatKeyBoardStatus)status{
    if (_status == status) {
        return;
    }
    _status = status;
    switch (_status) {
        case HYChatKBStatusNothing:
        {
//            self.voiceButton.selected = YES;
            self.faceButton.selected= NO;
            self.faceView.hidden = YES;
            [self.textView resignFirstResponder];
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = CGRectMake(0, SCREEN_HEIGHT - self.textView.height - 2 *BOXTEXTViewSPACE - 64, SCREEN_WIDTH, self.textView.height + 2 *BOXTEXTViewSPACE);
            }];
        }

            break;
        case HYChatKBStatusShowKeyboard:
        {
            self.faceView.hidden = YES;
            
            self.textView.hidden = NO;
            self.faceButton.selected= NO;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = CGRectMake(0, self.y, SCREEN_WIDTH, self.textView.height + 2 *BOXTEXTViewSPACE);
                
            }];
            [self.textView becomeFirstResponder];
        }
            break;
        case HYChatKBStatusShowVoLXe:
        {
//            self.faceView.hidden = self.moreView.hidden = YES;
//            
//            [self.textView resignFirstResponder];
//            self.voiceButton.selected = NO;
//            self.talkButton.hidden = NO;
//            self.textView.hidden = YES;
//            [UIView animateWithDuration:0.3 animations:^{
//                [self voiceResetFrame];
//            }];
            
        }
            
            break;
        case HYChatKBStatusShowFace:
        {
            if (self.textView.isFirstResponder) {
                [self.textView resignFirstResponder];
            }

            self.faceView.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.height = self.textView.height+2 *BOXTEXTViewSPACE + BOXOTHERH+64;
                self.y = SCREEN_HEIGHT - self.height;
                self.bottomCotainer.y = self.textView.height + 2 *BOXTEXTViewSPACE;
            }];
        }
            
            break;
        case HYChatKBStatusShowMore:
        {
            
            
//            if (self.textView.isFirstResponder) {
//                [self.textView resignFirstResponder];
//            }
//            
//            self.voiceButton.selected = YES;
//            self.moreView.hidden = NO;
//            self.faceView.hidden = YES;
//            
//            self.height = self.textView.height+2 *BOXTEXTViewSPACE + BOXOTHERH;
//            self.y = KScreenH - self.height;
//            self.bottomCotainer.y = self.textView.height + 2 *BOXTEXTViewSPACE;
        }
        default:
            break;
    }
//    if ([self.delegate respondsToSelector:@selector(changeStatusChat:)]) {
//        [self.delegate changeStatusChat:self.y];
//    }
}

#pragma mark - UI

-(UIView *)topContainer{
    if (!_topContainer) {
        _topContainer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_TABBAR)];
        _topContainer.backgroundColor = [UIColor grayColor];
        
    }
    return _topContainer;
}

-(UIView *)bottomCotainer{
    if (!_bottomCotainer) {
        _bottomCotainer =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_TABBAR, SCREEN_WIDTH, BOXOTHERH)];
        _bottomCotainer.backgroundColor = [UIColor redColor];
    }
    return _bottomCotainer;
}

-(HYTextView *)textView{
    if (!_textView) {
        _textView =[[HYTextView alloc]initWithFrame:CGRectMake(BOXBTNSPACE, (HEIGHT_TABBAR - HEIGHT_TEXTVIEW)/2, SCREEN_WIDTH -  CHATBOX_BUTTON_WIDTH - 2*BOXBTNSPACE, HEIGHT_TEXTVIEW)];
//        _textView.font = Font(16);
        [_textView createBordersWithColor:RGB(165, 165, 165) withCornerRadius:4 andWidth:.5];
        _textView.scrollsToTop = NO;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.delegate = self;
    }
    return _textView;
}


-(UIButton *)faceButton{
    if (!_faceButton) {
        _faceButton =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - CHATBOX_BUTTON_WIDTH, (HEIGHT_TABBAR - CHATBOX_BUTTON_WIDTH)/2, CHATBOX_BUTTON_WIDTH, CHATBOX_BUTTON_WIDTH)];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewKeyboard"] forState:UIControlStateSelected];
        [_faceButton setImage:[UIImage imageNamed:@"ToolViewEmotionHL"] forState:UIControlStateHighlighted];
        [_faceButton addTarget:self action:@selector(faceButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceButton;
}

-(HYFaceView *)faceView{
    if (!_faceView ) {
        _faceView =[[HYFaceView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BOXOTHERH)];
        _faceView.backgroundColor =[UIColor brownColor];
        
    }
    return _faceView;
}

@end
