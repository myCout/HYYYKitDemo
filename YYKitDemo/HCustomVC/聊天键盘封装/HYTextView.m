//
//  HYTextView.m
//  YYKitDemo
//
//  Created by HY on 2017/3/16.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "HYTextView.h"

@implementation HYTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:nil];
        self.autoresizesSubviews = NO;
        //默认字和颜色
        self.placeholder = @"";
        self.placeholderColor = [UIColor lightGrayColor];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //内容为空时才绘制placeholder
    if ([self.text isEqualToString:@""]) {
        CGRect placeholderRect;
        placeholderRect.origin.y = 8;
        placeholderRect.size.height = CGRectGetHeight(self.frame)-8;
        
        placeholderRect.origin.x = 5;
        placeholderRect.size.width = CGRectGetWidth(self.frame)-5;
        
        [self.placeholderColor set];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = self.textAlignment;
        
        UIFont *font = [UIFont boldSystemFontOfSize:10];
        NSDictionary *dic = @{NSFontAttributeName : font,
                  NSForegroundColorAttributeName : self.placeholderColor,
                  NSParagraphStyleAttributeName : paragraphStyle };
        
        [self.placeholder drawInRect:placeholderRect withAttributes:dic];
    }
}
- (void)textChanged:(NSNotification *)not
{
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
@end
