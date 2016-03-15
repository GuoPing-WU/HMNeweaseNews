//
//  HMChannelLable.m
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMChannelLable.h"

#define HMSelectedFont 18
#define HMNormalFont 14

@implementation HMChannelLable

+(instancetype)lableWithTitle:(NSString *)title
{
    HMChannelLable *channelLable = [[self alloc] init];
    
//    默认标签的大小是最大的
    channelLable.font = [UIFont systemFontOfSize:HMSelectedFont];
    
    channelLable.text = title;
    
//    自适应的大小
    [channelLable sizeToFit];
    
//    设置可交互
    channelLable.userInteractionEnabled = YES;
    
    channelLable.textAlignment = NSTextAlignmentCenter;
    
    /**
     *  重置字体
     */
    channelLable.font = [UIFont systemFontOfSize:HMNormalFont];
    
    return channelLable;
}


-(void)setScale:(CGFloat)scale
{
    _scale = scale;
    
//    计算最大缩放比例
    CGFloat maxScale = ((CGFloat)HMSelectedFont-HMNormalFont)/HMNormalFont;
//    计算实际缩放比例
    CGFloat currentScale = scale*maxScale+1;
//    进行缩放
    self.transform = CGAffineTransformMakeScale(currentScale, currentScale);
//    设置颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"你点击了我");
    if(self.channelLableDidClickBlock)
    {
        self.channelLableDidClickBlock();
    }
}

@end














