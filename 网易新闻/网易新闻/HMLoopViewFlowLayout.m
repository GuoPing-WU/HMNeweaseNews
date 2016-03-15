//
//  HMLoopViewFlowLayout.m
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMLoopViewFlowLayout.h"

@implementation HMLoopViewFlowLayout

//调用该方法时,collectionView尺寸已经确定
-(void)prepareLayout{
    [super prepareLayout];
//    设置item的尺寸
    self.itemSize = self.collectionView.bounds.size;
//    设置item之间的间隙
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
//    设置方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    设置分页
    self.collectionView.pagingEnabled  =YES;
//    设置隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.bounces = NO;
}

@end
