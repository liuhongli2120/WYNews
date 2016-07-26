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
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    });
    
    return instance;
}

#pragma mark - 封装 AFN 网络请求

/// 发起 GET 请求
///
/// @param URLString  URLString
/// @param parameters 参数字典
/// @param completion 完成回调
- (void)getRequest: (NSString *)URLString parameters: (NSDictionary *)parameters completion:(void(^)(id json, NSError *error))completion{
    
    [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败 %@", error);
        
        completion(error, nil);
    }];
}

#pragma mark - 网易新闻接口
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *, NSError *))completion{
    NSString *urlString = [NSString stringWithFormat:@"list/%@/%zd-20.html", channel, start];
    [self getRequest:urlString parameters:nil completion:^(id json, NSError *error) {
//        NSLog(@"%@", json);
        
        NSArray *array = json[channel];
        completion(array,error);
    }];

}

@end
