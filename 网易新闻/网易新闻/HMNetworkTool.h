//
//  HMNetworkTool.h
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HMNetworkTool : AFHTTPSessionManager

+(instancetype)sharedNetworkTool;

@end
