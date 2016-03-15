//
//  HMHomeViewController.m
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMHomeViewController.h"
#import "HMChannelCell.h"
#import "HMChannelLable.h"
#import "HMChannel.h"
#import "HMNewsTableViewController.h"

@interface HMHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 *  布局参数
 */
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
/**
 *  新闻频道数组
 */
@property(nonatomic,strong)NSArray *channels;
/**
 *  控制器缓冲池
 */
@property(nonatomic,strong)NSMutableDictionary *controllerCache;
/**
 *  当前item的索引
 */
@property(nonatomic,assign)NSInteger currentIndex;
@end

@implementation HMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    添加频道标签
    [self setupChannel];
}

//在ios7.0之后,如果试图控制器中有UINavgationController和UIScrollerView的组合,会默认调整UIScrollerView的边距,从而达到穿透Nav的效果

/**
 *  添加频道标签
 */
-(void)setupChannel
{
//    设置不要自动调整UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
   
//    获得channelView的高度
    CGFloat channelH = self.channelView.frame.size.height;
    
//    频道标签之间的间隙
    CGFloat marginX = 8;
    CGFloat lableX = marginX;
    for (HMChannel *channel in self.channels) {
//        创建标签
        HMChannelLable *channelLable = [HMChannelLable lableWithTitle:channel.tname];
        __weak typeof(self) weakVC = self;
        __weak typeof(channelLable) weakChannelLable = channelLable;
        channelLable.channelLableDidClickBlock = ^
        {
//            获得当前选中的标签的索引
            HMChannelLable *currentLable = weakVC.channelView.subviews[weakVC.currentIndex];
            currentLable.scale = 0;
//            重置currentIndex
            weakVC.currentIndex = [weakVC.channelView.subviews indexOfObject:weakChannelLable];
            
//            滚动到cell指定的位置
            [weakVC.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakVC.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            
//            获得标签中心点的值
            CGFloat centerX = weakChannelLable.center.x;
//            获得屏幕宽度的一半
            CGFloat halfScreen = [UIScreen mainScreen].bounds.size.width*0.5;
//            获得scrollView的最大滚动范围
            CGFloat maxOffset = weakVC.channelView.contentSize.width-[UIScreen mainScreen].bounds.size.width;
//            获得偏移值
            CGFloat offset = centerX-halfScreen;
            if(offset<0)
            {
                offset = 0;
            }
            else if (offset > maxOffset)
            {
                offset = maxOffset;
            }
            [weakVC.channelView setContentOffset:CGPointMake(offset, 0) animated:YES];
        };
        
//        设置frame
        channelLable.frame = CGRectMake(lableX, 0, channelLable.frame.size.width, channelH);
//        将频道标签添加到channelView上
        [self.channelView addSubview:channelLable];
        
        lableX += channelLable.frame.size.width;
    }
//    设置滚动范围
    self.channelView.contentSize  =CGSizeMake(lableX+marginX, 0);
    self.channelView.showsHorizontalScrollIndicator = NO;
    
//    设置默认
    self.currentIndex = 0;
    HMChannelLable *currentLable = self.channelView.subviews[self.currentIndex];
    currentLable.scale = 1;
}

/**
 *出现问题:上下留黑,frame不对,布局属性的位置不对
 *当控制器的view布局好之后调用,
 */
-(void)viewDidLayoutSubviews
{
//    一定要记得调用父类
    [super viewDidLayoutSubviews];
    
//    设置布局属性
    [self setupFlowLayout];
}

-(void)setupFlowLayout
{
//    设置item属性
    self.flowLayout.itemSize  = self.collectionView.bounds.size;
//    设置item之间的间隙
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
//    设置方向
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    设置分页效果
    self.collectionView.pagingEnabled = YES;
//    设置隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator =  NO;

//    禁止弹簧效果
    self.collectionView.bounces = NO;
}

#pragma mark - UISCrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
//    如果有水平或垂直滚动条的时候不通过过这种方式来获得子控件
    HMChannelLable *currentLable = self.channelView.subviews[self.currentIndex];
    HMChannelLable *nextLable = nil;
    for (NSIndexPath *indexPath in indexPaths) {
        if(indexPath.item != self.currentIndex)
        {
            nextLable = self.channelView.subviews[indexPath.item];
            break;
        }
    }
    //    下一个频道标签的缩放比例
    CGFloat nextScale = ABS(self.collectionView.contentOffset.x/self.collectionView.bounds.size.width-self.currentIndex);
    CGFloat currentScale = 1-nextScale;
    
    currentLable.scale = currentScale;
    nextLable.scale = nextScale;
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.currentIndex = self.collectionView.contentOffset.x/self.collectionView.bounds.size.width;
}

#pragma mark  - collectioView数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channelCell" forIndexPath:indexPath];
//    移除上一个控制器
    [cell.newsVC.view removeFromSuperview];
    
    HMChannel *channel = self.channels[indexPath.item];
//    根据模型获得性对应的新闻控制器
    HMNewsTableViewController *newsVC = [self newsVCWith:channel];
//    传递控制器
    cell.newsVC = newsVC;
    return cell;
}

-(HMNewsTableViewController *)newsVCWith:(HMChannel *)channel
{
    HMNewsTableViewController *newsVC = self.controllerCache[channel.tid];
    if(newsVC==nil)
    {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
            newsVC = sb.instantiateInitialViewController;
//        传递URLStr
            newsVC.URLStr = channel.URLStr;
        //    将控制器的view添加到cell，由于控制器的懒加载，下面这行代码才会导致viewDidLoad调用
       
        [self.controllerCache setObject:newsVC forKey:channel.tid];
    }
    return newsVC;
}

#pragma mark - 懒加载
-(NSArray *)channels
{
    if(_channels==nil)
    {
        _channels = [HMChannel channels];
    }
    return _channels;
}


-(NSMutableDictionary *)controllerCache
{
    if(_controllerCache==nil)
    {
        _controllerCache = [[NSMutableDictionary alloc] init];
    }
    return _controllerCache;
}

@end



















