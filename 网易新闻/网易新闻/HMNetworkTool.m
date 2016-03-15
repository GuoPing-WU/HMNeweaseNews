//
//  HMNetworkTool.m
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMNetworkTool.h"

@implementation HMNetworkTool

+(instancetype)sharedNetworkTool
{
    static HMNetworkTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       //        http://c.m.163.com/nc/ad/headline/0-4.html
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[self alloc] initWithBaseURL:baseURL];
        
//        修改响应解析器能够解析的数据类型
        instance.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}

@end
