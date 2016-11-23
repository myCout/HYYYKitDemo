//
//  HWKWebView.m
//  YYKitDemo
//
//  Created by HY on 2016/11/23.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HWKWebView.h"
#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HLAudioPlayer.h"

@interface HWKWebView ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, retain) WKWebView *hWKWebView;

@end

@implementation HWKWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
}

- (void)initWKWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    [configuration.userContentController addScriptMessageHandler:self name:@"ScanAction"];
    [configuration.userContentController addScriptMessageHandler:self name:@"Location"];
    [configuration.userContentController addScriptMessageHandler:self name:@"Share"];
    [configuration.userContentController addScriptMessageHandler:self name:@"Color"];
    [configuration.userContentController addScriptMessageHandler:self name:@"Pay"];
    [configuration.userContentController addScriptMessageHandler:self name:@"Shake"];
    [configuration.userContentController addScriptMessageHandler:self name:@"GoBack"];
    [configuration.userContentController addScriptMessageHandler:self name:@"PlaySound"];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    
    self.hWKWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
//    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index2.html" withExtension:nil];
//    [self.hWKWebView loadFileURL:htmlURL allowingReadAccessToURL:htmlURL];
 
    NSString *htmlURL = [[NSBundle mainBundle] pathForResource:@"index2.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:htmlURL];
    [self.hWKWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    self.hWKWebView.navigationDelegate = self;
    self.hWKWebView.UIDelegate = self;
    
    // 2.创建请求
//    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/mddblog/"]];
//    // 3.加载网页
//    [self.hWKWebView loadRequest:request];
    
    // 最后将webView添加到界面
    [self.view addSubview:self.hWKWebView];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
//    WKScriptMessage有两个关键属性name 和 body;根据name 来区分执行不同的方法。body 中存着JS 要给OC 传的参数,body 可以当字典来处理
    if ([message.name isEqualToString:@"ScanAction"]) {
        NSLog(@"扫一扫");
    } else if ([message.name isEqualToString:@"Location"]) {
        [self getLocation];
    } else if ([message.name isEqualToString:@"Share"]) {
        [self shareWithParams:message.body];
    } else if ([message.name isEqualToString:@"Color"]) {
        [self changeBGColor:message.body];
    } else if ([message.name isEqualToString:@"Pay"]) {
        [self payWithParams:message.body];
    } else if ([message.name isEqualToString:@"Shake"]) {
        [self shakeAction];
    } else if ([message.name isEqualToString:@"GoBack"]) {
        [self goBack];
    } else if ([message.name isEqualToString:@"PlaySound"]) {
        [self playSound:  message.body];
    }
}

#pragma mark - private method
- (void)goBack
{
    [self.hWKWebView goBack];
}

- (void)getLocation
{
    // 获取位置信息
    
    // 将结果返回给js
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"广东省深圳市南山区学府路XXXX号"];
    [self.hWKWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
    
}

- (void)shareWithParams:(NSDictionary *)tempDic
{
    if (![tempDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *title = [tempDic objectForKey:@"title"];
    NSString *content = [tempDic objectForKey:@"content"];
    NSString *url = [tempDic objectForKey:@"url"];
    // 在这里执行分享的操作
    
    // 将分享结果返回给js
    NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
    [self.hWKWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
}

- (void)changeBGColor:(NSArray *)params
{
    if (![params isKindOfClass:[NSArray class]]) {
        return;
    }
    
    if (params.count < 4) {
        return;
    }
    
    CGFloat r = [params[0] floatValue];
    CGFloat g = [params[1] floatValue];
    CGFloat b = [params[2] floatValue];
    CGFloat a = [params[3] floatValue];
    
    self.view.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

- (void)payWithParams:(NSDictionary *)tempDic
{
    if (![tempDic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *orderNo = [tempDic objectForKey:@"order_no"];
    long long amount = [[tempDic objectForKey:@"amount"] longLongValue];
    NSString *subject = [tempDic objectForKey:@"subject"];
    NSString *channel = [tempDic objectForKey:@"channel"];
    NSLog(@"%@---%lld---%@---%@",orderNo,amount,subject,channel);
    
    // 支付操作
    
    // 将支付结果返回给js
    NSString *jsStr = [NSString stringWithFormat:@"payResult('%@')",@"支付成功"];
    [self.hWKWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
}

- (void)shakeAction
{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    [HLAudioPlayer playMusic:@"shake_sound_male.wav"];
}


- (void)playSound:(NSString *)fileName
{
    if (![fileName isKindOfClass:[NSString class]]) {
        return;
    }
    
    [HLAudioPlayer playMusic:fileName];
}


#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
