//
//  HMLoopViewCell.m
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMLoopViewCell.h"
#import <UIImageView+WebCache.h>

@interface HMLoopViewCell ()

@property(nonatomic,strong)UIImageView *iconView;

@end
@implementation HMLoopViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
    }
    return self;
}

-(void)setURLString:(NSString *)URLString
{
    _URLString = URLString;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:URLString]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.frame = self.bounds;
}

@end
