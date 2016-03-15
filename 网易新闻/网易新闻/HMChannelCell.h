//
//  HMChannelCell.h
//  网易新闻
//
//  Created by WGP on 16/3/13.
//  Copyright © 2016年 WGP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  HMNewsTableViewController;
@interface HMChannelCell : UICollectionViewCell

@property(nonatomic,strong)HMNewsTableViewController *newsVC;

@property(nonatomic,copy)NSString *URLStr;

@end
