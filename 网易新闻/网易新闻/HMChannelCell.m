//
//  HMChannelCell.m
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMChannelCell.h"
#import "HMNewsTableViewController.h"

@interface HMChannelCell ()


@end
@implementation HMChannelCell

-(void)awakeFromNib
{
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
//    self.newsVC = sb.instantiateInitialViewController;
//    
////    将控制器的view添加到cell，由于控制器的懒加载，下面这行代码才会导致viewDidLoad调用
//    [self addSubview:self.newsVC.view];
}


-(void)setNewsVC:(HMNewsTableViewController *)newsVC
{
    _newsVC = newsVC;
    [self addSubview:self.newsVC.view];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.newsVC.view.frame = self.bounds;
}
@end
