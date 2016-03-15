//
//  HMWeakTimerTarget.h
//  08-NSTimer使用注意点-(掌握)
//
//  Created by SZSYKT_iOSBasic_2 on 16/2/17.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMWeakTimerTarget : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
@end
