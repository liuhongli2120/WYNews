//
//  AppDelegate.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/25.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置网络指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [self setupApprearace];
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    Class cls = NSClassFromString(@"WYMainViewController");
    
    UIViewController *vc = [[cls alloc]init];
    _window.rootViewController = vc;
    
    [_window makeKeyAndVisible];
    
    
    return YES;
}

- (void)setupApprearace {
    
    [UITabBar appearance].tintColor = [UIColor cz_colorWithHex:0xDF0000];

}



@end
