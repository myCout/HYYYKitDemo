//
//  HFourVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/11.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HFourVC.h"
#define kHeadH 260.0f //头视图的高度
#define kHeadMinH 64.0f //状态栏高度20 + 导航栏高度44
#define kBarH 29.0f//头视图下边选项卡的高度

@interface HFourVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UIImageView *headView;

@property (nonatomic, retain) UITableView *tableView;

//@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
//
//@property (strong, nonatomic) NSLayoutConstraint *headViewHeight;

@property (nonatomic) CGFloat hHeadViewHeight;
@end

@implementation HFourVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.alpha = 1;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [UIView beginAnimations:nil context:nil];
    [self makeParallaxEffect];
    [UIView commitAnimations];
}

- (void)viewWillDisappear:(BOOL)animated {
    [UIView beginAnimations:nil context:nil];
    self.navigationController.navigationBar.alpha = 1;
    [UIView commitAnimations];
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.alpha = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [self.tableView setContentInset:UIEdgeInsetsMake(300, 0, 0, 0)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -150, self.view.bounds.size.width, 300)];
    self.headView.layer.anchorPoint = CGPointMake(0.5f, 0);
    self.headView.image = [UIImage imageNamed:@"pyy.jpg"];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self.tableView) {
        [self makeParallaxEffect];
    }
}

- (void)makeParallaxEffect {
    CGPoint point = [((NSValue *) [self.tableView valueForKey:@"contentOffset"]) CGPointValue];
    if (point.y < -300) {
        float scaleFactor = fabs(point.y) / 300.f;
        self.headView.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    } else {
        self.headView.transform = CGAffineTransformMakeScale(1, 1);
    }
    
    if (point.y <= 0) {
        if (point.y >= -300) {
            self.headView.transform = CGAffineTransformTranslate(self.headView.transform, 0, (fabs(point.y) - 300) / 2.f);
        }
        self.headView.alpha = fabs(point.y / 300.f);
        self.navigationController.navigationBar.alpha = 1 - powf(fabs(point.y / 300.f), 3);
    } else {
        self.headView.transform = CGAffineTransformTranslate(self.headView.transform, 0, 0);
        self.headView.alpha = 0;
        self.navigationController.navigationBar.alpha = 1;
    }
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
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

@end
