//
//  HYFirstVC.m
//  YYKitDemo
//
//  Created by HY on 16/7/28.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYFirstVC.h"
#import "HHomePageCell.h"
#import "HYStoryModel.h"

@interface HYFirstVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *hCurrDataSource;
@property (nonatomic, retain) UITableView *hTestTb;

@end

@implementation HYFirstVC

#pragma mark - Life Cycle
- (void) viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self netWorkTestClick];
}

- (void)initUI{
    self.title = @"展示Cell";
    
    _hCurrDataSource = [NSMutableArray new];
    _hTestTb = [[UITableView alloc] initWithFrame:self.view.bounds];
    _hTestTb.delegate = self;
    _hTestTb.dataSource = self;
    _hTestTb.tableFooterView = [UIView new];
    [self.view addSubview:_hTestTb];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _hCurrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    HHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[HHomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell initDataWith:_hCurrDataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}


- (void)netWorkTestClick{
    WS(weakSelf)
    [[HYNetworkManager sharedInstance] httpGetRequest:@"stories/latest" params:nil onCompletionBlock:^(NSString *error, NSDictionary *resposeData) {
        if (!error) {
            for (NSDictionary *dataDic in resposeData[@"stories"]) {
                HYStoryModel *model = [HYStoryModel modelWithJSON:dataDic];
                [weakSelf.hCurrDataSource addObject:model];
            }
            
            [weakSelf.hTestTb reloadData];
        }else{
            NSLog(@"error = %@",error);
        }
    }];
}


#pragma mark - CustomDelegate

#pragma mark - Event response

#pragma mark - Private methods

#pragma mark - Getters and setters

@end
