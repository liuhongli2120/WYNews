//
//  WYChannelView.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannel;

/// 自定义控件
/**
 1.继承自UIControl
 2.监听方通过属性访问出发时间内部的属性 - 定义一个属性
 3.在发生事件时记录属性,发送事件消息
 */

@interface WYChannelView : UIControl
/// 频道列表数组
@property(nonatomic,strong)NSArray <WYChannel *> *channelList;
/// 选中的标签索引
@property(nonatomic,assign,readonly)NSInteger selectedIndex;

+ (instancetype)channelView;

- (void)changeLabelWithIndex:(NSInteger)index scale:(float)scale;


@end
