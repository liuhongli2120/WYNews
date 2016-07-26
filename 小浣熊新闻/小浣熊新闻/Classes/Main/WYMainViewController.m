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
    
//    self.tabBar.tintColor = [UIColor cz_colorWithHex:0xDF0000];
    
    NSArray *array = @[
                       @{@"clsName": @"WYHomeViewController", @"title": @"首页", @"imageName": @"news"},
                       @{@"clsName": @"UIViewController", @"title": @"熊大", @"imageName": @"bar"},
                       @{@"clsName": @"UIViewController", @"title": @"熊二", @"imageName": @"found"},
                       @{@"clsName": @"UIViewController", @"title": @"熊三", @"imageName": @"me"},
                       @{@"clsName": @"UIViewController", @"title": @"熊四", @"imageName": @"reader"}
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
    
    NSString *imageName = [NSString stringWithFormat:@"tabbar_icon_%@_normal", dict[@"imageName"]];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    NSString *imageNameHL = [NSString stringWithFormat:@"tabbar_icon_%@_highlight", dict[@"imageName"]] ;
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameHL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    
    
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    return nav;

}

@end
