//
//  ViewController.m
//  YYKitDemo
//
//  Created by HY on 16/7/13.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "ViewController.h"
#import "YYKit.h"
#import "HYNetworkManager.h"
#import "UIImageView+WebCache.h"
#import "YYFPSLabel.h"
#import "HDownLoadImgInstance.h"
#import "UITableView+CellHeightCache.h"
#import "HYFirstVC.h"

#import "HYStoryModel.h"
#import "NSObject+YYModel.h"
#import "HYSecondVC.h"
#import "HYThirdVC.h"
#import "HYTest4VC.h"
#import "HYTest5VC.h"
#import "HJSWebView.h"
#import "HWKWebView.h"
#import "HCADisplayLinkCAShapeLayerVC.h"
#import "HBulletVC.h"
#import "KVOController.h"
#import "HUIBezierPathController.h"
#import "HChainProgrammingVC.h"
#import "HReactiveCocoaVC.h"
#import "HSidePullMenuVC.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *hTestTb;
@property (nonatomic, retain) NSMutableArray *hDataSourceArray;
@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    _hDataSourceArray = @[@"下拉放大，上推缩小"];
    _hDataSourceArray = [NSMutableArray new];
    [_hDataSourceArray addObject:@"展示Cell"];//0
    [_hDataSourceArray addObject:@"Runtime学习"];//
    [_hDataSourceArray addObject:@"EmailTextField"];//
    [_hDataSourceArray addObject:@"UICollectionView学习"];//
    [_hDataSourceArray addObject:@"KeyboardDemo"];//
    [_hDataSourceArray addObject:@"OC_JS交互"];//
    [_hDataSourceArray addObject:@"WKWebView_OC_JS交互"];//6
    [_hDataSourceArray addObject:@"动画黄金搭档:CADisplayLink & CAShapeLayer"];//7
    [_hDataSourceArray addObject:@"弹幕"];//8HBulletVC
    [_hDataSourceArray addObject:@"FBKVO"];//9
    [_hDataSourceArray addObject:@"UIBezierPath详解"];//10
    [_hDataSourceArray addObject:@"链式编程入门"];//11
    [_hDataSourceArray addObject:@"ReactiveCocoa"];//12
    [_hDataSourceArray addObject:@"侧拉菜单"];//13
    [self.navigationController.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%lu", (unsigned long)_hDataSourceArray.count]];
    

//    // init group
//    GCDGroup *group = [GCDGroup new];
//    
//    // add to group
//    [[GCDQueue globalQueue] execute:^{
//        // task one
//        NSLog(@"task one");
//    } inGroup:group];
//    
//    // add to group
//    [[GCDQueue globalQueue] execute:^{
//        // task two
//        [GCDQueue executeInGlobalQueue:^{
//             NSLog(@"task two");
//        } afterDelaySecs:3];
//    } inGroup:group];
//    
//    // notify in mainQueue
//    [[GCDQueue mainQueue] notify:^{
//        // task three
//        NSLog(@"task three");
//    } inGroup:group];
    
    [self initTableView];
}

- (void)initTableView{
    _hTestTb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)];
    _hTestTb.delegate = self;
    _hTestTb.dataSource = self;
    _hTestTb.tableFooterView = [UIView new];
    [self.view addSubview:_hTestTb];
    //添加监听者
    [_hTestTb addObserver: self forKeyPath: @"contentOffset" options: NSKeyValueObservingOptionNew context: nil];

}

/**
 *  监听属性值发生改变时回调
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offset = _hTestTb.contentOffset.y;
    CGFloat delta = offset / 64.f + 1.f;
    delta = MAX(0, delta);
    self.navigationController.navigationBar.alpha = MIN(1, delta);
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _hDataSourceArray[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = indexPath.row;
    HYBaseViewController *baseVC;
    switch (row) {
        case 0:
        {
            baseVC = (HYBaseViewController *)[HYFirstVC new];
            
        }
            break;
        case 1:
        {
            baseVC = [HYSecondVC new];
        }
            break;
        case 2:
        {
            baseVC = [HYThirdVC new];
        }
            break;
        case 3:
        {
            baseVC = [HYTest4VC new];
        }
            break;
        case 4:
        {
            baseVC = [HYTest5VC new];
        }
            break;
            
        case 5:
        {
            baseVC = [HJSWebView new];
        }
            break;
        case 6:
        {
            baseVC = [HWKWebView new];
        }
            break;
        case 7:
        {
            baseVC = [HCADisplayLinkCAShapeLayerVC new];
        }
            break;
        case 8:
        {
            baseVC = [HBulletVC new];
        }
            break;
           
        case 9:
        {
            baseVC = [KVOController new];
        }
            break;
        case 10:
        {
            baseVC = [HUIBezierPathController new];
        }
            break;
        case 11:
        {
            baseVC = [HChainProgrammingVC new];
        }
            break;
        case 12:
        {
            baseVC = [HReactiveCocoaVC new];
        }
            break;
        case 13:
        {
            baseVC = [HSidePullMenuVC new];
        }
            break;
            
        default:
            break;
    }
    baseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:baseVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这样生成的key在数据源发生改变时会出现问题，可以用数据源对应的model添加key来实现
    NSString *key = [NSString stringWithFormat:@"%ld:%ld",(long)indexPath.section,(long)indexPath.row];
    CGFloat cellHeight = [tableView getCellHeightCacheWithCacheKey:key];
//    NSLog(@"从缓存取出来的-----%f",cellHeight);
    
    if(!cellHeight){
        cellHeight = 44;
        [tableView setCellHeightCacheWithCellHeight:cellHeight CacheKey:key];
    }
    
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}
#pragma mark -
//当scrollView滚动的时候调用的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    //下面代码实现 滑动table时隐藏NavigationBar
//    UIPanGestureRecognizer* pan = scrollView.panGestureRecognizer;
//    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
//    CGFloat velocity = [pan velocityInView:scrollView].y;
//    
//    if (velocity<-5) {
//        
//        [UIView animateWithDuration:1.5 animations:^{
//            //向上拖动，隐藏导航栏
//            [self.navigationController setNavigationBarHidden:true animated:true];
//        }];
//    }
//    else if (velocity>5) {
//        [UIView animateWithDuration:1.5 animations:^{
//            //向下拖动，显示导航栏
//            [self.navigationController setNavigationBarHidden:false animated:true];
//        }];
//    }
//    else if(velocity==0){
//        
//        //停止拖拽
//    }
}

#pragma mark -
- (void)Test{
    YYFPSLabel *fps = [YYFPSLabel new];
    fps.top = 64;
    [self.view addSubview:fps];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.view.width - 20, 150)];
    label.text = @"After purchasing, make sure to login with your daily yoga account on your device to access all premium features.";
    //    label.text = @"We started with Q&A. Technical documentation is next, and we need your help.Whether you're a beginner or an experienced developer, you can contribute.";
    //清空背景颜色
    label.backgroundColor = [UIColor brownColor];
    //设置字体颜色为白色
    label.textColor = [UIColor whiteColor];
    //文字居中显示
    label.textAlignment = NSTextAlignmentCenter;
    //自动折行设置
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    //    label.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:label];
    //    [self btnInit];
    
    //    [[HDownLoadImgInstance sharedInstance] downLoadImgWith:nil];
}

- (void)btnInit{
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 0, 100, 100)];
//    //    btn.titleLabel.text = @"TTTT";
//    [btn setTitle:@"测试按钮" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor greenColor];
//    [btn addTarget:self action:@selector(ttttClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    NSString *imgUrl = @"https://git.oschina.net/haonie/HYImg/raw/master/111.jpeg";
//
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
//    imgV.contentMode = UIViewContentModeScaleAspectFill;
//    [imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
    [imgV setImageWithURL:[NSURL URLWithString:imgUrl] placeholder:nil];
    [self.view addSubview:imgV];
//
    NSString *imgUrl2 = @"https://git.oschina.net/haonie/HYImg/raw/master/112.jpeg";
    UIImageView *imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(imgV.right + 10, 20, 100, 100)];
//    imgV2.contentMode = UIViewContentModeScaleAspectFill;
    [imgV2 setImageWithURL:[NSURL URLWithString:imgUrl2] placeholder:nil];
    [self.view addSubview:imgV2];
//
//    NSString *imgUrl3 = @"https://git.oschina.net/haonie/HYImg/raw/master/113.jpeg";
//    UIImageView *imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(imgV2.right + 10, 20, 100, 100)];
////    imgV3.contentMode = UIViewContentModeScaleAspectFill;
//    [imgV3 setImageWithURL:[NSURL URLWithString:imgUrl3] placeholder:nil];
//    [self.view addSubview:imgV3];
//    
//    NSString *imgUrl4 = @"https://git.oschina.net/haonie/HYImg/raw/master/114.jpeg";
//    UIImageView *imgV4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 250 + 20, 300, 200)];
//    //    imgV3.contentMode = UIViewContentModeScaleAspectFill;
//    [imgV4 setImageWithURL:[NSURL URLWithString:imgUrl4] placeholder:nil];
//    [self.view addSubview:imgV4];
    
    
}

#pragma mark - CustomDelegate

#pragma mark - Event response

#pragma mark - Private methods

#pragma mark - Getters and setters
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
