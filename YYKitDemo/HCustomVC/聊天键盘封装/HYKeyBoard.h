//
//  HYKeyBoard.h
//  YYKitDemo
//
//  Created by HY on 2017/3/16.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HYChatKeyBoardStatus) {
    HYChatKBStatusNothing,     // 默认状态
    HYChatKBStatusShowVoLXe,   // 录音状态
    HYChatKBStatusShowFace,    // 输入表情状态
    HYChatKBStatusShowMore,    // 显示“更多”页面状态
    HYChatKBStatusShowKeyboard,// 正常键盘
    HYChatKBStatusShowVideo    // 录制视频
};
@protocol HYChatKeyBoardDelegate <NSObject>

-(void)changeStatusKb:(CGFloat)chatBoxY;
-(void)chatBoxSendTextMessage:(NSString *)message;

@end

@interface HYKeyBoard : UIView

@property(nonatomic,assign)HYChatKeyBoardStatus status;
@property(nonatomic,assign)BOOL isDisappear;
@property(nonatomic,assign)NSInteger maxVisibleLine;
@property(nonatomic,weak)id<HYChatKeyBoardDelegate>delegate;
@end
