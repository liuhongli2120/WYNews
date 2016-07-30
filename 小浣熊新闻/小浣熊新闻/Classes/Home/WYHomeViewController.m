//
//  WYHomeViewController.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/25.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYChannelView.h"


@interface WYHomeViewController ()

@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor cz_randomColor];
    WYChannelView *cv = [WYChannelView channelView];
    
    [self.view addSubview:cv];
    
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    

}


@end
