//
//  WYNewsCell.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/28.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYNewsListItem;

@interface WYNewsCell : UITableViewCell

//新闻项模型
@property(nonatomic,strong) WYNewsListItem *newsItem;

@end
