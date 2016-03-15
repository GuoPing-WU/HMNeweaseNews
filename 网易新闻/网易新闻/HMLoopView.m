//
//  HMLoopView.m
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMLoopView.h"
#import "HMLoopViewCell.h"
#import "HMLoopViewFlowLayout.h"
#import "HMWeakTimerTarget.h"

@interface HMLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
//表题
@property(nonatomic,strong)UILabel *titleLable;
/**
 *  分页指示器
 */
@property(nonatomic,strong)UIPageControl *pageControl;
/**
 *  轮播起
 */
@property(nonatomic,strong)UICollectionView *collectionView;
/**
 *  图片URLStr数组
 */
@property(nonatomic,strong)NSArray *URLStrs;
/**
 *  标题数组
 */
@property(nonatomic,strong)NSArray *titles;
/**
 *  定时器
 */
@property(nonatomic,strong)NSTimer *timer;
/**
 *  选中回调Block
 */
@property(nonatomic,copy)void (^didSelectedBlock)(NSInteger index);
@end
@implementation HMLoopView

-(instancetype)initWithURLStrs:(NSArray<NSString *> *)URLStrs titles:(NSArray<NSString *> *)titles didSelected:(void (^)(NSInteger))didSelected
{
    if(self = [super init])
    {
//        记录属性
        self.URLStrs = URLStrs;
        self.titles = titles;
        self.didSelectedBlock = didSelected;
        
//        设置页数
        self.pageControl.numberOfPages = URLStrs.count;
        self.titleLable.text = self.titles[0];
        
//        滚动到URLStrs.count位置
//        主队列一不执行,在主线程空闲的时候才能执行BLock代码
//        执行block代码的时候,已经调用了collectionview的数据源方法
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(self.URLStrs.count>1)
            {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.URLStrs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
                
//                添加定时器
                [self addTimer];
            }
        });
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self =  [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

-(void)setup
{
//    创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[HMLoopViewFlowLayout alloc] init]];
    
//    注册cell
    [collectionView registerClass:[HMLoopViewCell class] forCellWithReuseIdentifier:@"loopCell"];
    
//    设置代理和数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
//    创建标题
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.font = [UIFont systemFontOfSize:15];
    self.titleLable.textColor = [UIColor grayColor];
    [self addSubview:self.titleLable];
//    创建分页指示器
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    设置单页隐藏
    self.pageControl.hidesForSinglePage = YES;
    [self addSubview:self.pageControl];
    
//    设置默认时间 默认值2
    self.timeInterval = 2;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//设置标题的高度
    CGFloat titleH = 30;
    
    CGRect frame = self.bounds;
    if(self.titlePosition == HMTitlePositionBlowImage)
    {
        frame.size.height -= titleH;
    }
    self.collectionView.frame = frame;
    CGFloat marginX = 10;
    
//    设置pageControl的frame
    CGFloat pageW = self.URLStrs.count*15;
    CGFloat pageX = self.bounds.size.width-marginX-pageW;
    CGFloat pageH = titleH;
    CGFloat pageY = self.bounds.size.height-titleH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
//    设置标题的frame
    CGFloat titleW = self.bounds.size.width-3*marginX-pageW;
    
    self.titleLable.frame = CGRectMake(marginX, pageY, titleW, titleH);
    
}
#pragma mark - 定时器相关方法
/**
 *  创建定时器
 */
-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 *  移除定时器
 */
-(void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)nextImage
{
//    获得当前现实的页号
    NSInteger page = self.collectionView.contentOffset.x/self.collectionView.bounds.size.width;
//    计算偏移量
    CGFloat offset = (page+1)*self.collectionView.bounds.size.width;
    
//    设置偏移量
    [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

#pragma marrk - UICollectionView 数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.URLStrs.count*((self.URLStrs.count==1)?1:3);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopCell" forIndexPath:indexPath];
//    传递字符串
    cell.URLString = self.URLStrs[indexPath.item%self.URLStrs.count];
    return cell;
}

//监听cell的点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.didSelectedBlock)
    {
        self.didSelectedBlock(indexPath.item%self.URLStrs.count);
    }
}

#pragma mark - UIScrollView代理方法
/**
 *  当户开始拖拽的时候调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    if(page==0 || page == ([self.collectionView numberOfItemsInSection:0]-1))
    {
        page = self.URLStrs.count-((page==0)?0:1);
        
        self.collectionView.contentOffset = CGPointMake(page*self.collectionView.bounds.size.width, 0);
    }
    
//    设置标题
    self.titleLable.text = self.titles[page%self.URLStrs.count];
    self.pageControl.currentPage = page%self.URLStrs.count;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

@end















