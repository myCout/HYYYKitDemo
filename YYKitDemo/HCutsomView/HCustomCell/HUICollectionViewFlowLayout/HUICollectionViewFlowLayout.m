//
//  HUICollectionViewFlowLayout.m
//  YYKitDemo
//
//  Created by HY on 16/8/11.
//  Copyright © 2016年 郝毅. All rights reserved.
//

#import "HUICollectionViewFlowLayout.h"

@interface HUICollectionViewFlowLayout ()

/** attrs的数组 */
@property(nonatomic,strong)NSMutableArray * attrsArr;

@end

@implementation HUICollectionViewFlowLayout


//-(void)prepareLayout
//{
//    self = [super init];
//    if (self) {
//        //设置每个item的大小  这个属性最好在控制器中设置
//        self.itemSize = CGSizeMake150, 150);
//        //设置滚动方向
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        //设置内边距
//        CGFloat insert =(self.collectionView.frame.size.width-self.itemSize.width)/2;
//        self.sectionInset =UIEdgeInsetsMake(0, insert, 0, insert);
//        //设置每行的最小间距
//        self.minimumLineSpacing = 50.0; 
//    } 
//    return self;
//    
//}

//-(id)init
//{
//    self = [super init];
//    if (self) {
//        //设置每个item的大小  这个属性最好在控制器中设置
//        self.itemSize = CGSizeMake(150, 150);
//        //设置滚动方向
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        //设置内边距
//        CGFloat insert =(self.collectionView.frame.size.width-self.itemSize.width)/2;
//        self.sectionInset =UIEdgeInsetsMake(0, insert, 0, insert);
//        //设置每行的最小间距
//        self.minimumLineSpacing = 50.0; 
//    } 
//    return self;
//}
//
///**
// *  只要手一松开就会调用
// *  这个方法的返回值，就决定了CollectionView停止滚动时的偏移量
// *  proposedContentOffset这个是最终的 偏移量的值 但是实际的情况还是要根据返回值来定
// *  velocity  是滚动速率  有个x和y 如果x有值 说明x上有速度
// *  如果y有值 说明y上又速度 还可以通过x或者y的正负来判断是左还是右（上还是下滑动）  有时候会有用
// */
//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    //计算出 最终显示的矩形框
//    CGRect rect;
//    rect.origin.x =proposedContentOffset.x;
//    rect.origin.y=0;
//    rect.size=self.collectionView.frame.size;
//    
//    NSArray * array = [super layoutAttributesForElementsInRect:rect];
//    
//    // 计算CollectionView最中心点的x值 这里要求 最终的 要考虑惯性
//    CGFloat centerX = self.collectionView.frame.size.width /2+ proposedContentOffset.x;
//    //存放的最小间距
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes * attrs in array) {
//        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
//            minDelta=attrs.center.x-centerX;
//        }
//    }
//    // 修改原有的偏移量
//    proposedContentOffset.x+=minDelta;
//    //如果返回的时zero 那个滑动停止后 就会立刻回到原地
//    return proposedContentOffset;
//}
//
///**
// *  这个方法的返回值是一个数组(数组里存放在rect范围内所有元素的布局属性)
// *  这个方法的返回值  决定了rect范围内所有元素的排布（frame）
// */
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{   //获得super已经计算好的布局属性 只有线性布局才能使用
//    NSArray * array = [super layoutAttributesForElementsInRect:rect];
//    //计算CollectionView最中心的x值
//#warning 特别注意：
//    CGFloat centetX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
//    for (UICollectionViewLayoutAttributes * attrs in array) {
//        //CGFloat scale = arc4random_uniform(100)/100.0;
//        //attrs.indexPath.item 表示 这个attrs对应的cell的位置
//        NSLog(@" 第%zdcell--距离：%.1f",attrs.indexPath.item ,attrs.center.x - centetX);
//        //cell的中心点x 和CollectionView最中心点的x值
//        CGFloat delta = ABS(attrs.center.x - centetX);
//        //根据间距值  计算cell的缩放的比例
//        //这里scale 必须要 小于1
//        CGFloat scale = 1 - delta/self.collectionView.frame.size.width;
//        //设置缩放比例
//        attrs.transform=CGAffineTransformMakeScale(scale, scale);
//    }
//    return array;
//}
//
///*!
// *  多次调用 只要滑出范围就会 调用
// *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
// *  一旦重新刷新 布局，就会重新调用
// *  1.layoutAttributesForElementsInRect：方法
// *  2.preparelayout方法
// */
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
-(NSMutableArray *)attrsArr
{
    if(!_attrsArr){
        _attrsArr=[[NSMutableArray alloc] init];
    }
    return _attrsArr;
}

-(void)prepareLayout
{
    [super prepareLayout];
    [self.attrsArr removeAllObjects];
    NSInteger count =[self.collectionView   numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        NSIndexPath *  indexPath =[NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attrs=[self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
}
/**
 *  返回UICollectionViewLayoutAttributes 类型的数组，UICollectionViewLayoutAttributes 对象包含cell或view的布局信息。子类必须重载该方法，并返回该区域内所有元素的布局信息，包括cell,追加视图和装饰视图。
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArr;
}

#pragma mark - 返回CollectionView的内容大小
/*!
 * 如果不设置这个的话  CollectionView就不能滑动
 返回collectionView内容区的宽度和高度，子类必须重载该方法，返回值代表了所有内容的宽度和高度，而不仅仅是可见范围的，collectionView通过该信息配置它的滚动范围，默认返回 CGSizeZero。
 */
-(CGSize)collectionViewContentSize
{
    int count = (int)[self.collectionView numberOfItemsInSection:0];
    int rows=(count +3 -1)/3;
    CGFloat rowH = self.collectionView.frame.size.width/2;
    if ((count)%6==2|(count)%6==4) {
        return CGSizeMake(0, rows * rowH-rowH/2);
    }else{
        return CGSizeMake(0, rows*rowH);
    }
}


/**
 *  返回对应于indexPath的位置的cell的布局属性
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width =self.collectionView.frame.size.width*0.5;
    UICollectionViewLayoutAttributes * attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat height =width;
    NSInteger i=indexPath.item;
    if (i==0) {
        attrs.frame = CGRectMake(0, 0, width, height);
    }else if (i==1){
        attrs.frame = CGRectMake(width, 0, width, height/2);
    }else if (i==2){
        attrs.frame = CGRectMake(width, height/2, width, height/2);
    }else if (i==3){
        attrs.frame = CGRectMake(0, height, width, height/2);
    }else if (i==4){
        attrs.frame = CGRectMake(0, height+height/2, width, height/2);
    }else if (i==5){
        attrs.frame = CGRectMake(width, height, width, height);
    }else{
        UICollectionViewLayoutAttributes *lastAttrs = self.attrsArr[i-6];
        CGRect frame  = lastAttrs.frame;
        frame.origin.y+=2 * height;
        attrs.frame=frame;
    }
    return attrs;
}


@end
