//
//  WYChannelView.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannel.h"

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
        UILabel *l = [UILabel cz_labelWithText:channel.tname fontSize:14 color:[UIColor blackColor]];
        [_scrollView addSubview:l];
    }
}


@end
