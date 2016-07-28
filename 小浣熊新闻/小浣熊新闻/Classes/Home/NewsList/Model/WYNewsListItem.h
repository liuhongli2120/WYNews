//
//  WYNewsListItem.h
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/26.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYNewsListItem : NSObject
//标题
@property(nonatomic,copy)NSString *title;
//新闻摘要
@property(nonatomic,copy)NSString *digest;
//来源
@property(nonatomic,copy)NSString *source;
//图像URL
@property(nonatomic,copy)NSString *imgsrc;
//跟帖数量
@property(nonatomic,assign)NSInteger replyCount;
//多图新闻的其余图片
@property(nonatomic,strong)NSArray *imgextra;

//是否是大图标记
@property (nonatomic, assign) BOOL imgType;
//是否是顶部视图
@property (nonatomic, assign) BOOL hasHead;

@end
