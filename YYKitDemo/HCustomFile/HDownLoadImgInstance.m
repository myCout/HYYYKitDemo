//
//  HDownLoadImgInstance.m
//  YYKitDemo
//
//  Created by HY on 16/7/27.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HDownLoadImgInstance.h"
#define hSaveImgDocumentName                @"YGShareImage"
@interface HDownLoadImgInstance (){
    NSMutableData *_imageData;
    float _length;
}

@end

@implementation HDownLoadImgInstance

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)downLoadImgWith:(NSString *)imgUrlStr{
    //初始化图片数据
    _imageData = [[NSMutableData alloc] init];
    
    //请求
    NSURL *url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D2048/sign=91c1063e1f950a7b753549c43ee963d9/f31fbe096b63f624b6a9640b8544ebf81b4ca3c6.jpg"];
    url = [NSURL URLWithString:imgUrlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //连接
    [NSURLConnection connectionWithRequest:request delegate:self];
}

//响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //清空图片数据
    [_imageData setLength:0];
    //强制转换
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    _length = [[resp.allHeaderFields objectForKey:@"Content-Length"] floatValue];
    //设置状态栏接收数据状态
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//响应体
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_imageData appendData:data];//拼接响应数据
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //    UIImage* image = [UIImage imageWithData:_imageData];
    //    NSLog(@"===========");
    //    //设置状态栏
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *saveDiretory = [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject],hSaveImgDocumentName];
    //判断文件夹是否存在
    BOOL isDirectory ;
    BOOL isExist = [fm fileExistsAtPath:saveDiretory isDirectory:&isDirectory];
    if (!isExist) {
        NSLog(@"所在路径不存在,创建路径后写入图片...");
        [fm createDirectoryAtPath:saveDiretory withIntermediateDirectories:NO attributes:nil error:nil];
    }else{
        NSLog(@"路径存在,直接写入图片...");
    }
    
    //写入图片
    NSString *savePath =[NSString stringWithFormat: @"%@/%@.jpg",saveDiretory,hSaveImgDocumentName];
    _saveSuccess = [_imageData writeToFile:savePath atomically:YES];
    if (_saveSuccess) {
        NSLog(@"YGShareImage saveSuccess = %@",savePath);
    }
}

- (UIImage *)getYGShareImage{
    NSString *saveDiretory = [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject],hSaveImgDocumentName];
    NSString *savePath =[NSString stringWithFormat: @"%@/%@.jpg",saveDiretory,hSaveImgDocumentName];
    NSFileManager *fm = [NSFileManager defaultManager];
    //判断文件是否存在
    BOOL isDirectory ;
    BOOL isExist = [fm fileExistsAtPath:savePath isDirectory:&isDirectory];
    UIImage * result;
    if (isExist) {
        result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.jpg", savePath,hSaveImgDocumentName]];
    }else{
        NSString *imgName = @"默认图片的名字";
        result = [UIImage imageNamed:imgName];
    }

    return result;
}

-(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}

-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    return result;
}

@end
