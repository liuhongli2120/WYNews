//
//  WYChannelView.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannel.h"
#import "WYChannelLabel.h"

@interface WYChannelView()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation WYChannelView

+ (instancetype)channelView {
    
    UINib *nib = [UINib nibWithNibName:@"WYChannelView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;

}

- (void)setChannelList:(NSArray<WYChannel *> *)channelList {
    _channelList = channelList;
    
    
    for (WYChannel *channel in channelList) {
        //创建标签
        WYChannelLabel *l = [WYChannelLabel channelLabelWithTitle:channel.tname];
        //添加滚动视图
        [_scrollView addSubview:l];
    }
}


@end
