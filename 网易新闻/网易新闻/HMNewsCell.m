//
//  HMNewsCell.m
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMNewsCell.h"
#import "HMNews.h"
#import <UIImageView+WebCache.h>

@interface HMNewsCell ()
/**
 *  图片
 */
@property(nonatomic,weak)IBOutlet UIImageView *iconView;
/**
 *  标题
 */
@property(nonatomic,weak)IBOutlet UILabel *titleLable;

/**
 *  摘要
 */
@property(nonatomic,weak)IBOutlet UILabel *digestLable;

/**
 *  跟帖数
 */
@property(nonatomic,weak)IBOutlet UILabel *replyCountLable;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextras;

@end
@implementation HMNewsCell

/**
 *  根据模型获得cell的重用表示
 */
+(NSString *)cellWithNews:(HMNews *)news
{
    NSString *ID = @"news";
    if(news.imgextra)
    {
        ID = @"threeImagesCell";
    }
    else if(news.imgType)
    {
        ID = @"bigImageCell";
    }
    return ID;
}

/**
 *  根据模型获得返回cell的高度
 */
+(CGFloat)cellHeight:(HMNews *)news
{
    CGFloat height = 80;
    if(news.imgextra)//三张图片的cell
    {
        height = 120;
    }
    else if (news.imgType)
    {
        height = 170;
    }
    return height;
}

-(void)setNews:(HMNews *)news
{
    _news = news;
    self.titleLable.text = news.title;
    self.digestLable.text = news.digest;
    self.replyCountLable.text = [NSString stringWithFormat:@"%zd跟帖",[news.replyCount intValue]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    [news.imgextra enumerateObjectsUsingBlock:^(NSDictionary *imageDict, NSUInteger idx, BOOL * _Nonnull stop) {
//        根据idx获得imageView
        UIImageView *imageView = self.imgextras[idx];
//        获得图片的URLString
        NSString *imgsrc = imageDict[@"imgsrc"];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imgsrc]];
    }];
    
}


@end











