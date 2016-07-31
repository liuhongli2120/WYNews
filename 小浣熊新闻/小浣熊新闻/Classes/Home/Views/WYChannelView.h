//
//  WYChannelView.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannel;

@interface WYChannelView : UIView
/// 频道列表数组
@property(nonatomic,strong)NSArray <WYChannel *> *channelList;

+ (instancetype)channelView;

- (void)changeLabelWithIndex:(NSInteger)index scale:(float)scale;


@end
