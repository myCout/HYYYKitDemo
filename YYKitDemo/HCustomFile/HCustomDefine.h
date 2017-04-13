//
//  HCustomDefine.h
//  YYKitDemo
//
//  Created by HY on 2016/10/9.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#ifndef HCustomDefine_h
#define HCustomDefine_h

#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


#define HEIGHT_TABBAR       49      // 就是chatBox的高度
#define CHATBOX_BUTTON_WIDTH        36/**<按钮大小 > */

#define  HEIGHT_TEXTVIEW   36

#define  BOXBTNSPACE 4
#define  BOXOTHERH 215
#define  BOXTOTALH   (HEIGHT_TABBAR+BOXOTHERH)
#define  BOXBTNBOTTOMSPACE    6
#define  BOXTEXTViewSPACE 6.5

#endif /* HCustomDefine_h */
