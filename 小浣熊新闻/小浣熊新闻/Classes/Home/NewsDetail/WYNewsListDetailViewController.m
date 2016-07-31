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
}




@end
