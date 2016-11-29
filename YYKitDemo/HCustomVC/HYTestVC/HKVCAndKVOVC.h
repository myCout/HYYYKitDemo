//
//  HKVCAndKVOVC.h
//  YYKitDemo
//
//  Created by HY on 2016/11/25.
//  Copyright © 2016年 郝毅. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HYBaseViewController.h"

//KVC是一套方便我们用字符串来操作对象的机制，可以使得操作对象时跟操作字典一样的灵活。在字典转模型的领域中应用起来极为方便，并且
//KVC可以轻松的帮我们突破访问限制的一些问题，直接访问到私有成员。
//但是同样，
//KVC也有其缺点：例如在编码时很容易输错
//key导致问题，语法相较点语法而言也略微繁琐。但万事万物不也正如
//KVC一般既有其优点，也存在其不足之处

@interface HPerson : NSObject

@property (nonatomic, retain) NSString *hName;

@property (nonatomic) NSUInteger hAge;

@end


@interface HKVCAndKVOVC : HYBaseViewController

@end
