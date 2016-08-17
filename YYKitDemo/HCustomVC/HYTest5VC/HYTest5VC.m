//
//  HYTest5VC.m
//  YYKitDemo
//
//  Created by HY on 16/8/15.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYTest5VC.h"
#import "ChatKeyBoard.h"

#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"
//#import "YTKeyBoardView.h"

@interface HYTest5VC ()<ChatKeyBoardDelegate, ChatKeyBoardDataSource>
//@property (nonatomic, strong) YTKeyBoardView *keyBoard;
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@end

@implementation HYTest5VC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
    
    self.chatKeyBoard.delegate = self;
    self.chatKeyBoard.dataSource = self;
    self.chatKeyBoard.allowVoice = NO;
    self.chatKeyBoard.allowFace = NO;
    self.chatKeyBoard.allowMore = NO;
    self.chatKeyBoard.keyBoardStyle = KeyBoardStyleChat;
    self.chatKeyBoard.placeHolder = @"请输入消息";
    [self.view addSubview:self.chatKeyBoard];
}


//#pragma mark - key board delegate
//- (void)keyBoardView:(YTKeyBoardView *)keyBoard ChangeDuration:(CGFloat)durtaion{
//    
//}
//
//- (void)keyBoardView:(YTKeyBoardView *)keyBoard audioRuning:(UILongPressGestureRecognizer *)longPress{
//    NSLog(@"录音 -> 在此处理");
//    if (longPress.state == UIGestureRecognizerStateEnded) {
//        [self keyBoardView:keyBoard sendResous:@"录音"];
//    }
//}
//
//- (void)keyBoardView:(YTKeyBoardView *)keyBoard otherType:(YTMoreViewTypeAction)type{
//    NSLog(@"相机 相册 -> 在此处理");
//    NSString * m;
//    if (type == YTMoreViewTypeActionCamera) {
//        m = @"相机";
//    }else{
//        m = @"相册";
//    }
//    [self keyBoardView:keyBoard sendResous:m];
//}
//
//- (void)keyBoardView:(YTKeyBoardView *)keyBoard sendResous:(id)resous{
//    if (!resous) return;
//}

- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"图片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍照"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9];
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
    
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
    
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}
@end
