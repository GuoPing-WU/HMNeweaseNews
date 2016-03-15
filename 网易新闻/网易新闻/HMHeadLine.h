//
//  HMHeadLine.h
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMHeadLine : NSObject
/**
 *  图片
 */
@property(nonatomic,copy)NSString *imgsrc;
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;

+(instancetype)headLineWithDict:(NSDictionary *)dict;

+(void)loadHeadLineSuccess:(void (^)(NSArray *headLines))success failed:(void (^)(NSError *error))failed;


@end
