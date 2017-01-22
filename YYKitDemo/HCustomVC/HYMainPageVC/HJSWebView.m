//
//  HJSWebView.m
//  YYKitDemo
//
//  Created by HY on 2016/11/23.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HJSWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface HJSWebView ()<UIWebViewDelegate>
{
    
}


@property (nonatomic, retain) UIWebView *hWebView;
@end

@implementation HJSWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWeb];
}

- (void)initWeb{
    self.hWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.hWebView.delegate = self;
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    //    NSURL *htmlURL = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    
    // 如果不想要webView 的回弹效果
    self.hWebView.scrollView.bounces = NO;
    // UIWebView 滚动的比较慢，这里设置为正常速度
    self.hWebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.hWebView loadRequest:request];
    [self.view addSubview:self.hWebView];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self addCustomActions];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}
#pragma mark - private method
#pragma mark - private method
- (void)addCustomActions
{
    JSContext *context = [self.hWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self addShareWithContext:context];
}

/**
 JS调用OC

 @param context 当前运行环境
 */
- (void)addShareWithContext:(JSContext *)context
{
    __weak typeof(self) weakSelf = self;
    //执行完JS方法后用回调执行OC方法
    context[@"share"] = ^() {
        NSArray *args = [JSContext currentArguments];
        if (args.count < 3) {
            return ;
        }
        NSString *title = [args[0] toString];
        NSString *content = [args[1] toString];
        NSString *url = [args[2] toString];
        // 在这里执行分享的操作...
        
        //OC调用JS方法：
        //方式1  使用JSContext的方法-evaluateScript，可以实现OC调用JS方法。将分享结果返回给js---
//        NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
//        [[JSContext currentContext] evaluateScript:jsStr];
        //方式2
        //使用JSValue的方法-callWithArguments，也可以实现OC调用JS方法。
        [[JSContext currentContext][@"shareResult"] callWithArguments:@[title,content,url]];
    };
}
@end
