//
//  HMChannel.h
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMChannel : NSObject
/**
 *  频道名称
 */
@property(nonatomic,copy)NSString *tname;
/**
 *  tid值越小,频道越重要
 */
@property(nonatomic,copy)NSString *tid;

/**
 *  不同新闻频道对应的URL
 */
@property(nonatomic,copy)NSString *URLStr;

/**
 *  返回所有频道的数据
 */
+(NSArray *)channels;
+(instancetype)channelWithDict:(NSDictionary *)dict;

@end
