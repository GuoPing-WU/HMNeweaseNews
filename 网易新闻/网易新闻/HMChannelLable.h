//
//  HMChannelLable.h
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMChannelLable : UILabel
/**
 *  缩放系数
 */
@property(nonatomic,assign)CGFloat scale;
/**
 *  标签点击回调
 */
@property(nonatomic,copy)void (^channelLableDidClickBlock)();
+(instancetype)lableWithTitle:(NSString *)title;

@end
