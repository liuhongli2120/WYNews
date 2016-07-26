 //
//  HLNetworkManager.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/26.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "HLNetworkManager.h"

@implementation HLNetworkManager

+ (instancetype)sharedManager {
    
    static HLNetworkManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseUrl = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        instance = [[self alloc]initWithBaseURL:baseUrl];
    });
    
    return instance;

}

@end
