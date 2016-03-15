//
//  HMNewsCell.h
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMNews;

@interface HMNewsCell : UITableViewCell

@property(nonatomic,strong)HMNews *news;
/**
 *  根据模型获得cell的重用表示
 */
+(NSString *)cellWithNews:(HMNews *)news;

/**
 *  根据模型获得返回cell的高度
 */
+(CGFloat)cellHeight:(HMNews *)news;

@end
