//
//  HMChannel.m
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMChannel.h"

@implementation HMChannel

+(NSArray *)channels
{
//    将JSON数据转换为NSData
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil]];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//    获得第一个Key
    NSString *rootKey = dict.keyEnumerator.nextObject;
//    获得数组
    NSArray *array = dict[rootKey];
    
    NSMutableArray *channels = [NSMutableArray arrayWithCapacity:array.count];
//    遍历数组
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [channels addObject:[HMChannel channelWithDict:obj]];
    }];
//    排序
    return [channels sortedArrayUsingComparator:^NSComparisonResult(HMChannel  *obj1, HMChannel  *obj2) {
//        NSOrderedAscending = -1L,升序
//        NSOrderedSame,       相等
//        NSOrderedDescending  降序
        
        return [obj1.tid compare:obj2.tid];
    }];
}
+(instancetype)channelWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

/**
 *
 *使用KVC的时候,如果模型中没有找到字典中相对应的key值的时候,就会在这个方法里抛出异常
 */
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

/**
 *  重写模型的setTid方法,重写copy属性的set方法，记得要copy
 */

-(void)setTid:(NSString *)tid
{
//     @"article/headline/T1348647853363/0-20.html"
    _tid = tid.copy;
    _URLStr = [NSString stringWithFormat: @"article/headline/%@/0-20.html",tid];
}
@end




