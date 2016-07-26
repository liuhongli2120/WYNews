//
//  HLNetworkManager.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/26.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HLNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
