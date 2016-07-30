//
//  WYNews_m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/28.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYNewsCell.h"
#import "WYNewsListItem.h"

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
    
    //设置单图
    [_iconView cz_setImageWithURLString:newsItem.imgsrc];
    
    //设置多图
    
    NSInteger idx = 0;
    for (NSDictionary *dict in newsItem.imgextra) {
        
        //设置多图,是字典,从字典里遍历取值(newsItem.imgsrc)
        [_extraIcon[idx++] cz_setImageWithURLString:dict[@"imgsrc"]];
    }
}


@end
