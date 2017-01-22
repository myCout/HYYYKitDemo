//
//  KVOController.m
//  YYKitDemo
//
//  Created by HY on 2017/1/17.
//  Copyright © 2017年 郝毅. All rights reserved.
//

#import "KVOController.h"
#import "HChangeValueController.h"
#import "HYStoryModel.h"

@interface KVOController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UILabel *hLb;
@property (nonatomic, retain) UIButton *hBtn;
@property (nonatomic, retain) UIView *hHeadView;
@property (nonatomic, retain) UITableView *hTableView;
@property (nonatomic, retain) HYStoryModel *model;
@end

@implementation KVOController

+ (instancetype)sharedInstance
{
    static KVOController* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [KVOController new];
    });

    return instance;
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    [self.KVOController unobserveAll];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.hTableView];
    self.hTableView.tableHeaderView = self.hHeadView;
    
    self.hHeadView.sd_layout.leftSpaceToView(self.hTableView,0)
    .topSpaceToView(self.hTableView,0)
    .widthIs(self.hTableView.width)
    .heightIs(150);
    
    _model = [HYStoryModel new];
    _model.title = @"1111";

    [_hBtn jk_addActionHandler:^(NSInteger tag) {
//        _hLb.text = @"NSLocalizedDescription=remote notifications are not supported in the simulator";
        HChangeValueController *changeVC = [HChangeValueController new];
        changeVC.model = _model;
        [self.navigationController pushViewController:changeVC animated:YES];
    }];
    
    _hLb.sd_layout.leftSpaceToView(self.hHeadView,20)
    .topSpaceToView(self.hHeadView,20)
    .autoHeightRatio(0)
    .widthRatioToView(self.hHeadView,0.4);
    _hLb.text = _model.title;
    _hBtn.sd_layout.leftSpaceToView(self.hHeadView,20)
    .topSpaceToView(_hLb,20)
    .heightIs(40)
    .widthIs(80);
    
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.KVOController = KVOController;
    
    [self.KVOController observe:_model keyPath:@"title" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"change = %@",change[NSKeyValueChangeNewKey])
    }];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}
#pragma mark - UI
- (UITableView *)hTableView{
    if (!_hTableView) {
        _hTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height-64) style:UITableViewStylePlain];
        _hTableView.dataSource = self;
        _hTableView.delegate = self;
        _hTableView.backgroundColor = [UIColor randomColor];
    }
    return _hTableView;
}

- (UIView *)hHeadView{
    if(!_hHeadView){
        _hHeadView = [UIView new];
        _hLb = [UILabel new];
        _hLb.backgroundColor = [UIColor randomColor];
        _hBtn = [UIButton new];
        _hBtn.backgroundColor = [UIColor randomColor];
        [_hHeadView addSubview:_hLb];
        [_hHeadView addSubview:_hBtn];
    }
    return _hHeadView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
