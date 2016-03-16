//
//  HMNewsDetailViewController.m
//  网易新闻
//
//  Created by WGP on 16/3/15.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMNewsDetailViewController.h"
#import "HMNetworkTool.h"

@interface HMNewsDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

/**
 *  时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  正文
 */
@property (nonatomic, copy) NSString *body;
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;

@end

@implementation HMNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  控制的view加载的时候调用
     */
    self.webView.delegate = self;
    [self loadData];
}

- (void)loadData {
    //    http://c.m.163.com/nc/article/BI47TS2200031H2L/full.html
    //    http://c.m.163.com/nc/article/BI4JEKGK00254TI5/full.html
    
    // 加载新闻详情数据
    [[HMNetworkTool sharedNetworkTool] GET:self.URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        // 获得第一个key
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        NSDictionary *dict = responseObject[rootKey];
        
        // 获得新闻时间和来源
        NSString *time = dict[@"ptime"];
        NSString *source = dict[@"source"];
        
        self.time = [NSString stringWithFormat:@"%@ %@",time,source];
        // 获得新闻标题
        self.title = dict[@"title"];
        // 获得body内容
        self.body = dict[@"body"];
        NSLog(@"%@--%@--%@",time,source,self.body);
        
        // 获得图片
        NSArray *imgs = dict[@"img"];
        
        for (NSDictionary *img in imgs) {
            // 获得ref字符串
            NSString *ref = img[@"ref"];
            // 获得img的URL
            NSString *imgURL = img[@"src"];
            //            <img src="http://img5.cache.netease.com/ent/2016/3/14/20160314161334ad93e.jpg" width="50%%" height="500"/>
            
            // 获得img标签
            NSString *imgTag = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"/>",imgURL];
            
            // 在body中查找ref，将ref替换成imgURL
            self.body = [self.body stringByReplacingOccurrencesOfString:ref withString:imgTag];
        }
        
        // 获得video
        NSArray *videos = dict[@"video"];
        for (NSDictionary *video in videos) {
            // 获得ref字符串
            NSString *ref = video[@"ref"];
            // 获得video的URL
            NSString *url_mp4 = video[@"url_mp4"];
            
            // 获得video的封面图片
            NSString *cover = video[@"cover"];
            // 获得video下面的文字
            NSString *alt = video[@"alt"];
            
            // 拼接video标签
            NSString *videoTag = [NSString stringWithFormat:@"<video width=\"100%%\" controls poster=\"%@\">  <source src=\"%@\" type=\"video/mp4\" > </video> <br/> <span>%@</span>",cover,url_mp4,alt];
            // 在body中查找ref，将ref替换成videoTag
            self.body = [self.body stringByReplacingOccurrencesOfString:ref withString:videoTag];
        }
        // 使用webView显示数据
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"detail.html" withExtension:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 *
 *  这个方法在wenView加载完成后调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *js = [NSString stringWithFormat:@"changeContent('%@','%@','%@');",self.title,self.time,self.body];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}


@end









