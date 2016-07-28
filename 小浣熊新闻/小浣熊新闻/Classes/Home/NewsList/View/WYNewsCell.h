//
//  WYNewsCell.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/28.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WYNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;


@end
