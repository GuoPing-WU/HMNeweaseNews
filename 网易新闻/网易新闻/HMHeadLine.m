//
//  HMHeadLine.m
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMHeadLine.h"
#import "HMNetworkTool.h"

@implementation HMHeadLine

+(instancetype)headLineWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

//如果找不到字典中对应的key就会在这个方法中抛出异常,重写则个方法就会报错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

+(void)loadHeadLineSuccess:(void (^)(NSArray *))success failed:(void (^)(NSError *))failed
{
    NSAssert(success!= nil, @"成功回调必须传入!");
    
    [[HMNetworkTool sharedNetworkTool] GET:@"ad/headline/0-4.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        
        NSArray *array = responseObject[rootKey];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrayM addObject:[HMHeadLine headLineWithDict:obj]];
        }];
//        完成回调
        success(arrayM.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failed)
        {
            failed(error);
        }
    }];
}
@end

















