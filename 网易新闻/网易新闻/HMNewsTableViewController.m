//
//  HMNewsTableViewController.m
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import "HMNewsTableViewController.h"
#import "HMNews.h"
#import "HMNewsCell.h"

@interface HMNewsTableViewController ()
@property(nonatomic,strong)NSArray *news;
@end

@implementation HMNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

-(void)setURLStr:(NSString *)URLStr
{
    _URLStr = [URLStr copy];
    [HMNews loadNewsWithURL:self.URLStr Success:^(NSArray *news) {
        NSLog(@"load");
        self.news = news;
        
        [self.tableView reloadData];
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.news.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    获得新闻模型
    HMNews *new = self.news[indexPath.row];
//    获得重用表示
    NSString *ID = [HMNewsCell cellWithNews:new];
//    获得cell
    HMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.news = new;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMNews *news = self.news[indexPath.row];
    
    return [HMNewsCell cellHeight:news];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end

















