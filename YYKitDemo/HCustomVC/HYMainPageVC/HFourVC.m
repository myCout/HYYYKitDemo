//
//  HFourVC.m
//  YYKitDemo
//
//  Created by HY on 16/8/11.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HFourVC.h"


@interface HFourVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UIView *hMoveView;

@property (nonatomic, retain) UIImageView *folderImageView;

/** 动画元素 */
@property(nonatomic, strong)  UIImageView *animationImageView;

/** 是否是打开预览动画 */
@property(nonatomic, assign)  BOOL isOpenOverView;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic) CGFloat hHeadViewHeight;
@end

@implementation HFourVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.alpha = 1;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    self.animationImageView = [UIImageView new];
    self.folderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.folderImageView.image = [UIImage imageNamed:@"section0_emotion13"];
    self.folderImageView.center = self.view.center;
    [self.view addSubview:self.folderImageView];
    
//    sizeToFit
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, self.folderImageView.bottom + 20, 100, 0)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor randomColor];
    label.text = @"fdjkalfjdklafjkdlsajfkdlsajfkdlsajfklaaaaabbbbbbcccccdddddeeeeefffff";
////    label.font = [UIFont systemFontOfSize:15];
//    label.font = [UIFont fontWithName:@"Chancery" size:15];

    [self.view addSubview:label];
    [label sizeToFit];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 20)];
    lab.numberOfLines = 0;
    lab.backgroundColor = [UIColor randomColor];
    lab.text = @"IOS发新版后每天会生成自然好评。最明显的是美国区人工好评是60条，";
    [self.view addSubview:lab];
    [lab jk_resizeLabelVertical];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    view.backgroundColor = [UIColor randomColor];
    self.hMoveView = view;
//    [self.view addSubview:view];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (object == self.tableView) {
        
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view jk_addSubviewWithFadeAnimation:self.hMoveView];
    [self.hMoveView jk_moveTo:CGPointMake(200, 200) duration:5 option:UIViewAnimationOptionCurveEaseOut];
    [self.hMoveView jk_changeAlpha:0.2 secs:5];
    // 先将文件夹那个视图进行截图
    UIImage *animationImage = [self.folderImageView snapshotImage];
    // 再将文件夹视图的坐标系迁移到窗口坐标系（绝对坐标系）
    CGRect targetFrame_start = [self.folderImageView.superview convertRect:self.folderImageView.frame toView:nil];
    
    // 计算动画终点位置
    CGFloat targetW = targetFrame_start.size.width*3;
    CGFloat targetH = targetFrame_start.size.height*3;
    CGFloat targetX = (SCREEN_WIDTH - targetW) / 2.0;
    CGFloat targetY =(SCREEN_HEIGHT - targetH) / 2.0;
    CGRect targetFrame_end = CGRectMake(targetX, targetY, targetW, targetH);
    
    // 添加做动画的元素
    if (!self.animationImageView.superview) {
        self.animationImageView.image = animationImage;
        self.animationImageView.frame = targetFrame_start;
        [self.view.window addSubview:self.animationImageView];
    }
    
    if (self.isOpenOverView) {
        
        // 预览动画
        [UIView animateWithDuration:1 delay:0. options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.animationImageView.frame = targetFrame_end;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        
        // 关闭预览动画
        [UIView animateWithDuration:1 delay:0. options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.animationImageView.frame = targetFrame_start;
            
        } completion:^(BOOL finished) {
            
            [self.animationImageView removeFromSuperview];
            
        }];
    }
    
    self.isOpenOverView = !self.isOpenOverView;
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
