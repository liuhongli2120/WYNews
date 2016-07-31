//
//  WYNewsListDetailViewController.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/31.
//  Copyright © 2016年 lhl. All rights reserved.
//
//在webView 里要接收一个 docid
#import "WYNewsListDetailViewController.h"
#import "WYNewsListItem.h"

@interface WYNewsListDetailViewController ()

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation WYNewsListDetailViewController

/// @property(nonatomic,strong)UIWebView *webView; 这里用strong,为了写方法loadView,这样,UIWebView就是根视图.
- (void)loadView {
    
    _webView = [UIWebView new];
    
    self.view = _webView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"接收到的模型: %@", _item);
    
    [self loadData];
}

- (void)loadData {
    // block 里面的东西暂时不会执行, 这个会调用网络工具,网络工具执行之后再进行完成回调,就会调用到这个方法
    [[HLNetworkManager sharedManager] newsListDetailWithDocId:_item.docid completion:^(NSDictionary *dict, NSError *error) {
        NSLog(@"%@", dict);
    }];

}


@end
