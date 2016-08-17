//
//  HYSecondVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/3.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYSecondVC.h"
#import <objc/runtime.h>


@interface HYSecondVC ()<UITableViewDataSource,UITableViewDelegate>
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}

- (void)initUI{
    self.title = @"Runtime学习";
    self.view.backgroundColor = [UIColor whiteColor];
    _hDataSourceArray = @[@"获取属性列表",@"获取变量列表",@"获取实例方法列表",@"获取类方法列表",@"获取协议列表",@"我是动态修改字体 hello world"];
    
//    [self.hTableHeadView addSubview:self.hDontReClickBtn];
    
    _hTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _hTableView.delegate = self;
    _hTableView.dataSource = self;
    _hTableView.tableHeaderView = self.hTableHeadView;
    _hTableView.tableFooterView = [UIView new];
    [self.view addSubview:_hTableView];
    
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
        _hTableHeadView.backgroundColor = [UIColor grayColor];
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
