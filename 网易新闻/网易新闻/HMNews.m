//
//  HMNews.m
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMNews.h"
#import "HMNetworkTool.h"

@implementation HMNews

+(instancetype)newsWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

+(void)loadNewsWithURL:(NSString *)URLStr Success:(void (^)(NSArray *))success faild:(void (^)(NSError *))failed
{
//    @"article/headline/T1348647853363/0-20.html"
    
    NSAssert(success!=nil, @"必须传入成功回调!");
    [[HMNetworkTool sharedNetworkTool] GET:URLStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
//        获得字典中的第一个Key
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
//        获得数组
        NSArray *headLines = responseObject[rootKey];
//        创建可变的模型数组
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:headLines.count];
//        遍历数组
        [headLines enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            创建模型
            HMNews *news = [HMNews newsWithDict:obj];
//            将模型加到数组中
            [arrayM addObject:news];
        }];
//        完成回调,为了线程安全
        success(arrayM.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failed)
        {
            failed(error);
        }
    }];
}

@end










