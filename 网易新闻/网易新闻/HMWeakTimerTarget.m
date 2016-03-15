//
//  HMWeakTimerTarget.m
//  08-NSTimer使用注意点-(掌握)
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/17.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "HMWeakTimerTarget.h"

@interface HMWeakTimerTarget()

@property (nonatomic, weak) id aTarget;
@property (nonatomic, assign) SEL aSelector;
@end

@implementation HMWeakTimerTarget

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    
    HMWeakTimerTarget *target = [[HMWeakTimerTarget alloc] init];
    // 记录真实回调target
    target.aTarget = aTarget;
    target.aSelector = aSelector;
    
    return [NSTimer scheduledTimerWithTimeInterval:ti target:target selector:@selector(update:) userInfo:userInfo repeats:yesOrNo];
}

- (void)update:(NSTimer *)timer{
//    NSLog(@"update");
    // 回调控制器的update方法
    [self.aTarget performSelector:self.aSelector withObject:timer];
//    self performSelector:<#(SEL)#> withObject:<#(id)#>
}
@end
