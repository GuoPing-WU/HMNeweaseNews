//
//  HMLoopView.h
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    HMTitlePositionBlowImage,
    HMTitlePositionAboveImage,
}HMTitlePosition;

@interface HMLoopView : UIView

/**
 *  创建图片轮播起
 */
-(instancetype)initWithURLStrs:(NSArray <NSString *>*)URLStrs titles:(NSArray<NSString *>*)titles didSelected:(void (^)(NSInteger))didSelected;
/**
 *  定时器时间间隔
 */
@property(nonatomic,assign)NSInteger timeInterval;

/**
 *标题的位置
 */
@property(nonatomic,assign)HMTitlePosition titlePosition;

@end
