//
//  HYTest4VC.m
//  YYKitDemo
//
//  Created by HY on 16/8/4.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HYTest4VC.h"
#import "HUICollectionViewFlowLayout.h"
#import "HYTest5VC.h"
@interface HYTest4VC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, retain) UICollectionView *hUICollectionView;

@end

@implementation HYTest4VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    // 流水布局
    HUICollectionViewFlowLayout *flowLayout = [[HUICollectionViewFlowLayout alloc] init];
    // 设置cell的尺寸
    flowLayout.itemSize = CGSizeMake(150, 100);
    // 设置每一行的间距
    flowLayout.minimumLineSpacing = 15;
    // 设置每个cell的间距
    flowLayout.minimumInteritemSpacing = 0;
    // 设置每组的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
     [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.hUICollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 49) collectionViewLayout:flowLayout];
    self.hUICollectionView.dataSource = self;
    self.hUICollectionView.delegate = self;
    [self.hUICollectionView setBackgroundColor:[UIColor clearColor]];
    //注册Cell，必须要有
    [self.hUICollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.hUICollectionView];
}


#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 17;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:label];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(50, 100);
//}
//
////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}

#pragma mark - UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    cell.backgroundColor = [UIColor greenColor];
//    NSLog(@"item======%ld",(long)indexPath.item);
//    NSLog(@"row=======%ld",(long)indexPath.row);
//    NSLog(@"section===%ld",(long)indexPath.section);
//    HYTest5VC * test5 = [HYTest5VC new];
//    [self presentViewController:test5 animated:YES completion:^{
//        //
//    }];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
