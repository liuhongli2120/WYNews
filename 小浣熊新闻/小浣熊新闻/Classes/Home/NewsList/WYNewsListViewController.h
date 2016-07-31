//
//  WYNewsListViewController.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/26.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNewsListViewController : UIViewController
/// 使用频道代号和索引创建控制器 
///
/// @param channelId 频道Id
/// @param index     频道索引
///
/// @return <#return value description#>
- (instancetype) initWithChannelId:(NSString *)channelId index:(NSInteger)index;

///频道Id
@property(nonatomic,strong,readonly)NSString *channelId;

/// 频道索引
@property(nonatomic,assign,readonly)NSInteger channelIndex;

@end
