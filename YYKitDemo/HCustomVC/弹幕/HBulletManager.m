//
//  HBulletManager.m
//  YYKitDemo
//
//  Created by HY on 2016/12/7.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HBulletManager.h"
#import "HBulletView.h"

@interface HBulletManager ()
//弹幕数据来源
@property (nonatomic, retain) NSMutableArray *dataSource;
//弹幕使用过程中的数组变量
@property (nonatomic, retain) NSMutableArray *bulletComments;
//存储弹幕view的数组变量
@property (nonatomic, retain) NSMutableArray *bulletViews;

@property (nonatomic) BOOL hStopAnimation;
@end

@implementation HBulletManager

- (instancetype)init{
    if (self = [super init]) {
        self.hStopAnimation = YES;
    }
    return self;
}

- (void)stop{
    if (self.hStopAnimation) {
        return;
    }
    self.hStopAnimation = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HBulletView *view = obj;
        [view stopAnimation];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}

- (void)start{
    if (!self.hStopAnimation) {
        return;
    }
    self.hStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];
    [self initBulletComment];
}

- (void)initBulletComment{
    //弹道
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for (int i = 0; i < 3; i++) {
        if (self.bulletComments.count > 0) {
            //随机数获取到弹幕的轨迹
            NSUInteger index = arc4random()%trajectorys.count;
            int trajectory = [trajectorys[index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            //从弹幕数组中逐一取出弹幕数据
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            //创建弹幕view
            [self creatBulletView:comment trajectory:trajectory];
        }
    }
}


- (void)creatBulletView:(NSString*)comment trajectory:(int)trajectroy{
    if (self.hStopAnimation) {
        return;
    }
    HBulletView *view = [[HBulletView alloc] initWithComment:comment];
    view.trajectory = trajectroy;
    [self.bulletViews addObject:view];
    
    __weak typeof (view) weakView = view;
    __weak typeof (self) mySelf = self;
    view.hMoveStatusBlock = ^(MoveStatus status){
        if (self.hStopAnimation) {
            return;
        }
        switch (status) {
            case Start:
            {
                //弹幕开始进入屏幕，将View加入到弹幕管理的变量中bulletView
                [mySelf.bulletViews addObject:weakView];
            }
                break;
            case Enter:
            {
                //弹幕完全进入屏幕，判断是否还有其他内容，如果有则在该弹幕轨迹中创建一个新弹幕
                NSString *comment = [mySelf nextComment];
                if (comment) {
                    [mySelf creatBulletView:comment trajectory:trajectroy];
                }
            }
                break;
            case End:
            {
                //弹幕废除屏幕后从bulletViews中删除，释放资源
                if ([mySelf.bulletViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [mySelf.bulletViews removeObject:weakView];
                }
                if (mySelf.bulletViews.count == 0) {
                    //说明屏幕上一斤更没有弹幕了，开始循环滚动
                    self.hStopAnimation = YES;
                    [mySelf start];
                }
            }
                break;
                
            default:
                break;
        }
        
//        //移除屏幕后销毁病释放资源
//        [weakView stopAnimation];
//        [mySelf.bulletViews removeObject:weakView];
    };
    if (self.hGenerateViewBlock) {
        self.hGenerateViewBlock(view);
    }
}

- (NSString *)nextComment{
    if (self.bulletComments.count == 0) {
        return nil;
    }
    
    NSString *comment = [self.bulletComments firstObject];
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"弹幕1~~~~~~",@"弹幕2~~",@"弹幕3~~~",@"弹幕1~~~~~~",@"弹幕2~~",@"弹幕3~~~",@"弹幕1~~~~~~",@"弹幕2~~",@"弹幕3~~~",@"弹幕1~~~~~~",@"弹幕2~~",@"弹幕3~~~",@"弹幕1~~~~~~",@"弹幕2~~",@"弹幕3~~~"]];
    }
    return _dataSource;
}
- (NSMutableArray *)bulletComments{
    if (!_bulletComments) {
        _bulletComments = [NSMutableArray new];
    }
    return _bulletComments;
}
- (NSMutableArray *)bulletViews{
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray new];
    }
    return _bulletViews;
}
@end
