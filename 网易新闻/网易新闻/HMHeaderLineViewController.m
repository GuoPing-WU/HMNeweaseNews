//
//  HMHeaderLineViewController.m
//  网易新闻
//
//  Created by WGP on 16/3/14.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMHeaderLineViewController.h"
#import "HMHeadLine.h"
#import "HMLoopView.h"

@interface HMHeaderLineViewController ()

@end

@implementation HMHeaderLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HMHeadLine loadHeadLineSuccess:^(NSArray *headLines) {
        
        HMLoopView *loopView = [[HMLoopView alloc] initWithURLStrs:[headLines valueForKey:@"imgsrc"] titles:[headLines valueForKey:@"title"] didSelected:^(NSInteger index) {
//            NSLog(@"点击了第%@",headLines[index]);
        }];
        loopView.frame = self.view.bounds;
        
        [self.view addSubview:loopView];
        
    } failed:^(NSError *error) {
        
    }];
    
    
    
}



@end
