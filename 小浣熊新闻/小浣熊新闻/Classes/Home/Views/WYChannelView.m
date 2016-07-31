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
    
    
    CGFloat x = 30;
    CGFloat margin = 8;
    CGFloat height = _scrollView.bounds.size.height;
    
    
    
    for (WYChannel *channel in channelList) {
        //创建标签,调用字体 label 的类方法
        WYChannelLabel *l = [WYChannelLabel channelLabelWithTitle:channel.tname];
        
        //设置 label 的位置
        l.frame = CGRectMake(x, 0, l.bounds.size.width, height);
        //递增 x
        x += l.bounds.size.width + margin;
        
        //添加滚动视图
        [_scrollView addSubview:l];
    }
    
    //设置 scrollView 的 contentSize, 设置之后就可以滚动
    _scrollView.contentSize = CGSizeMake(x, height);
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    [self changeLabelWithIndex:0 scale:1];
    
}

- (void)changeLabelWithIndex:(NSInteger)index scale:(float)scale {
    //根据index取出对应的label
    WYChannelLabel *l = _scrollView.subviews[index];
    
    l.scale = scale;

}


@end
