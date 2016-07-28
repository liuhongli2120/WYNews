//
//  WYNews_m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/28.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYNewsCell.h"
#import "WYNewsListItem.h"
#import <UIImageView+WebCache.h>

@interface WYNewsCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;

@end

@implementation WYNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setNewsItem:(WYNewsListItem *)newsItem {
    _newsItem = newsItem;
    
    
    _titleLabel.text = newsItem.title;
    _sourceLabel.text = newsItem.source;
    _replyLabel.text = @(newsItem.replyCount).description;
    
    //image
    NSURL *imageUrl = [NSURL URLWithString:newsItem.imgsrc];
    [_iconView sd_setImageWithURL:imageUrl];
    
    //设置多图
    
    NSInteger idx = 0;
    for (NSDictionary *dict in newsItem.imgextra) {
        NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
        
        UIImageView *iv = _extraIcon[idx++];
        [iv sd_setImageWithURL:url];
    }

}


@end
