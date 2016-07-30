//
//  WYChannel.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYChannel.h"

@implementation WYChannel

- (NSString *)description {
    return [self yy_modelDescription];
}

+(NSArray *)channelList {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *array = dict[@"tList"];
    
    NSArray *modelArray = [NSArray yy_modelArrayWithClass:[self class] json:array];
    
    return modelArray;

}


@end
