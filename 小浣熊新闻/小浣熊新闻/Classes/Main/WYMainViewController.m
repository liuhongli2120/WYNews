//
//  WYMainViewController.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/25.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYMainViewController.h"

@interface WYMainViewController ()

@end

@implementation WYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildControllers];
}

- (void)addChildControllers {
    
    NSArray *array = @[
                       @{@"clsName": @"UIViewController", @"title": @"首页", @"imageName": @"tabbar_icon_news_normal"},
                       @{@"clsName": @"UIViewController", @"title": @"首页", @"imageName": @"tabbar_icon_media_normal"},
                       @{@"clsName": @"UIViewController", @"title": @"首页", @"imageName": @"tabbar_icon_media_normal"},
                       @{@"clsName": @"UIViewController", @"title": @"首页", @"imageName": @"tabbar_icon_media_normal"},
                       @{@"clsName": @"UIViewController", @"title": @"首页", @"imageName": @"tabbar_icon_media_normal"}
                       ];
    
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self childControllerWithDict:dict]];
    }
    
    self.viewControllers = arrayM.copy;
    

}

- (UIViewController *)childControllerWithDict:(NSDictionary *)dict{
    
    NSString *clsName = dict[@"clsName"];
    Class cls = NSClassFromString(clsName);
    
    NSAssert(cls != nil, @"传入的类名错误");
    UIViewController *vc = [[cls alloc]init];
    
    vc.title = dict[@"title"];
    
    NSString *imageName = dict[@"imageName"];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    return nav;

}

@end
