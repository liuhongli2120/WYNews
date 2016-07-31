//
//  WYChannelLabel.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYChannelLabel : UILabel

/// 缩放比例
@property(nonatomic,assign)float scale;

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@end
