//
//  HYSecondVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/3.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYSecondVC.h"
#import "UIScrollView+HeaderScaleImage.h"
#import <objc/runtime.h>
#import <objc/message.h>
static const void*CallBtnKey = &CallBtnKey;

@interface HYSecondVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, retain) UITableView *hTableView;
@property (nonatomic, retain) NSArray *hDataSourceArray;
@property (nonatomic, retain) UIView *hTableHeadView;
@property (nonatomic, retain) UIButton *hDontReClickBtn;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *job;//
@property (nonatomic, retain) NSString *native;//籍贯
@property (nonatomic, retain) NSString *education;//学历

- (void) eat;
- (void) sleep;
- (void) work;

@end

@implementation HYSecondVC

+(void)load{
    Method method1 = class_getClassMethod(self, @selector(fun1));
    Method method2 = class_getClassMethod(self, @selector(fun2));
    
    method_exchangeImplementations(method1, method2);
}

- (void)fun1{
    NSLog(@"我是 fun1");
}

- (void)fun2{
    NSLog(@"我是 fun2");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}

- (void)initUI{
    self.title = @"Runtime学习";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.hidesBarsOnSwipe = YES;
    _hDataSourceArray = @[@"获取属性列表",@"获取变量列表",@"获取实例方法列表",@"获取类方法列表",@"获取协议列表",@"我是动态修改字体 hello world",@"动态绑定对象传参:点击拨打 : 10000",@"替换ViewController生命周期方法",@"解决获取索引、添加、删除元素越界崩溃问题",@"防止按钮重复暴力点击",@"全局修改导航栏后退（返回）按钮"];
    
    
    // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住

    [self.hDontReClickBtn tapWithEvent:UIControlEventTouchUpInside withBlock:^(UIButton *sender) {
        //
    }];
    _hTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    _hTableView.height -= 64;
    _hTableView.delegate = self;
    _hTableView.dataSource = self;
    _hTableView.tableHeaderView = self.hTableHeadView;
    _hTableView.tableFooterView = [UIView new];
    [self.view addSubview:_hTableView];
//    WS(weakSelf)
//    UIImageView *imagV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
//    [imagV sd_setImageWithURL:[NSURL URLWithString:@"http://st1.dailyyoga.com/data/6a/bf/6abf1d3bee236eff6341a10f2fff0602.jpeg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//    }];
    // 设置tableView头部缩放图片
    self.hTableView.yz_headerScaleImage = [UIImage imageNamed:@"10"];
//    [self.hTableHeadView addSubview:imagV];
//    1、动态绑定传参；
//    2、UIButton的一个category ，用block代替点击事件；
//    3、看不到源代码，可以给类添加get和set方法，同时添加N个属性
//    4、obj 消息机制 objc_msgSend(self,@selector(setBackground:),[UIColor brownColor])
//    5、exchangeImp
    
    
//    @"解决UIButton多次点击(重复点击)",
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _hDataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger row = indexPath.row;
    if (row == _hDataSourceArray.count) {
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH - 30, 60 - 10 *2)];
        testLabel.text = _hDataSourceArray[indexPath.row];
        [cell.contentView addSubview:testLabel];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_hDataSourceArray[indexPath.row]];
    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            [self getPropertyList];
        }
            break;
        case 1:
        {
            [self getIvarList];
        }
            break;
        case 2:
        {
            [self getMethodList];
        }
            break;
        case 3:
        {
            [self getClassMethod];
        }
            break;
        case 4:
        {
            [self getProtocolList];
        }
            break;
            
        case 6:
        {
            [self callPhone];
        }
            break;
        case 7:
        {
            NSLog(@"UIViewController (Swizzling)");
        }
        break;
        
        case 8:
        {
            NSLog(@"NSMutableArray+Swizzling");
            NSMutableArray * arr = [NSMutableArray arrayWithObject:@"0"];
            [arr removeObjectAtIndex:2];
            NSLog(@"NSMutableArray+Swizzling = %@",arr);
        }
        break;
        case 9:
        {
            NSLog(@"UIViewController (Swizzling)");
        }
        break;
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}

/**
 *  获取属性列表
 */
- (void)getPropertyList{
    NSLog(@"----------获取属性列表----------");
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        const char * name = property_getName(propertyList[i]);
        NSLog(@"%@",[NSString stringWithUTF8String:name]);
    }
}

-(void)getIvarList
{
    NSLog(@"----------获取变量列表----------");
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        const char * name = ivar_getName(ivarList[i]);
        NSLog(@"%@",[NSString stringWithUTF8String:name]);
    }
}

-(void)getMethodList
{
    NSLog(@"----------获取实例方法列表----------");
    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        SEL name = method_getName(methodList[i]);
        NSLog(@"%@",NSStringFromSelector(name));
    }
}

-(void)getClassMethod
{
    NSLog(@"----------获取类方法列表----------");
    unsigned int count;
    Method *methodList = class_copyMethodList(objc_getMetaClass(class_getName([self class])), &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        SEL name = method_getName(methodList[i]);
        NSLog(@"%@",NSStringFromSelector(name));
    }
}

-(void)getProtocolList
{
    NSLog(@"----------获取协议列表----------");
    unsigned int count;
    Protocol * __unsafe_unretained * protocolList =class_copyProtocolList([super class], &count);
    
    for (NSInteger i = 0 ; i < count; i ++) {
        const char* name = protocol_getName(protocolList[i]);
        NSLog(@"%@",[NSString stringWithUTF8String:name]);
    }
}

-(void)callPhone
{
    NSLog(@"----------拨打电话----------");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"拨打电话" message:@"10000" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    [alertView show];
    //#import <objc/runtime.h>头文件
    //objc_setAssociatedObject需要四个参数：源对象，关键字，关联的对象和一个关联策略。
    
    //1 源对象alert
    //2 关键字 唯一静态变量CallBtnKey
    //3 关联的对象 @"10000"
    //4 关键策略  OBJC_ASSOCIATION_RETAIN_NONATOMIC
    objc_setAssociatedObject(alertView, CallBtnKey, @"10000", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
//    objc_setAssociatedObject(alertView, @"msgstr", message,OBJC_ASSOCIATION_ASSIGN);
//    //把alert和message字符串关联起来，作为alertview的一部分，关键词就是msgstr，之后可以使用objc_getAssociatedObject从alertview中获取到所关联的对象，便可以访问message或者btn了
//    //    即实现了关联传值
//    objc_setAssociatedObject(alertView, @"btn property",sender,OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - alertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        NSString *telStr = objc_getAssociatedObject(alertView, CallBtnKey);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telStr]]];
    }
}
-(void)hDontReClickBtnClicked
{
    NSLog(@"----------按钮禁止重复点击----------");
    
}

- (void) eat{
    
}
- (void) sleep{
    
}
- (void) work{
    
}

#pragma mark - UI
- (UIView*)hTableHeadView{
    if (!_hTableHeadView) {
        _hTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _hTableHeadView.backgroundColor = [UIColor clearColor];
    }
    return _hTableHeadView;
}

- (UIButton *)hDontReClickBtn{
    if (!_hDontReClickBtn) {
        _hDontReClickBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 44)];
        [_hDontReClickBtn setTitle:@"按钮禁止重复点击" forState:UIControlStateNormal];
        [_hDontReClickBtn addTarget:self action:@selector(hDontReClickBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hDontReClickBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
