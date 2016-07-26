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

/// 加载网易新闻列表
///
/// @param channel     频道字符串
/// @param start      开始数字
/// @param completion 完成回调[字典数组/错误]

- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void(^)(NSArray *array, NSError *error))completion;

@end
