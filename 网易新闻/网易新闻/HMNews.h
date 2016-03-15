//
//  HMNews.h
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNews : NSObject
/**
 *  新闻标题
 */
@property(nonatomic,copy)NSString *title;

/**
 *  新闻摘要
 */
@property(nonatomic,copy)NSString *digest;
/**
 *  新闻图片
 */
@property(nonatomic,copy)NSString *imgsrc;
/**
 *  跟帖数
 */
@property(nonatomic,strong)NSNumber *replyCount;
/**
 *  多张图片
 */
@property(nonatomic,strong)NSArray *imgextra;
/**
 *  是否是大图  YES:是 NO:不是
 */
@property(nonatomic,assign) BOOL imgType;

+(void)loadNewsWithURL:(NSString *)URLStr Success:(void (^)(NSArray *news))success faild:(void (^)(NSError *error))failed;

@end









