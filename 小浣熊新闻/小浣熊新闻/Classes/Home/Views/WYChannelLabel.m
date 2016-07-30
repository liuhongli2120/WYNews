//
//  WYChannelLabel.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYChannelLabel.h"

#define kNormalSize 14
#define kSelectedSize 18

@implementation WYChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    
    //实例化标签,用大字体撑开 bounds ,布局大字体空间
    WYChannelLabel *l = [WYChannelLabel cz_labelWithText:title fontSize:kSelectedSize color:[UIColor blackColor]];
    //设置文本对齐方式
    l.textAlignment = NSTextAlignmentCenter;
    //设置小字体
    l.font = [UIFont systemFontOfSize:kNormalSize];
    //返回标签, 返回的 bounds 是大字体撑开后的 bounds
    return l;

}

@end
