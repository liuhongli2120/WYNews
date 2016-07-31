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
    
    
    UINavigationBar *navBar = [[UINavigationBar alloc]init];
    
    [self.view addSubview:navBar];
    
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        //高度是64,包含了状态栏的高度
        make.height.mas_equalTo(64);
    }];
    
    UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"网易内容"];
    
    navBar.items = @[item];
    
    item.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    _webView.scrollView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    

}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"接收到的模型: %@", _item);
    
    [self loadData];
}

- (void)loadData {
    // block 里面的东西暂时不会执行, 这个会调用网络工具,网络工具执行之后再进行完成回调,就会调用到这个方法
    [[HLNetworkManager sharedManager] newsListDetailWithDocId:_item.docid completion:^(NSDictionary *dict, NSError *error) {
        
        NSString *body = dict[@"body"];
        NSArray *img = dict[@"img"];
        NSArray *video = dict[@"video"];
        
        NSLog(@"%@", body);
        NSLog(@"%@", img);
        NSLog(@"%@", video);
        
        
        
        for (NSDictionary *dict in img) {
            NSString *ref = dict[@"ref"];
            
            NSRange range = [body rangeOfString:ref];
            
            if (range.location == NSNotFound) {
                continue;
            }
            
            NSString *imgStr = [NSString stringWithFormat:@"<img src=\"%@\" />", dict[@"src"]];
            body = [body stringByReplacingCharactersInRange:range withString:imgStr];
            
        }
        
        
        for (NSDictionary *dict in video) {
            NSString *ref = dict[@"ref"];
            
            NSRange range = [body rangeOfString:ref];
            
            if (range.location == NSNotFound) {
                continue;
            }
            
            NSString *videoStr = [NSString stringWithFormat:@"<video src=\"%@\" />", dict[@"mp4_url"]];
            body = [body stringByReplacingCharactersInRange:range withString:videoStr];
            
            
            
        }
        
        body = [[self cssString ] stringByAppendingString:body];
        
        [self.webView loadHTMLString:body baseURL:nil];
        
        NSLog(@"%@", dict);
    }];
 
}


- (NSString *)cssString {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news.css" ofType:nil];
    
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];

}


@end
