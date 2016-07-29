 //
//  UIImageView+CZ_WebImage.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/29.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "UIImageView+CZ_WebImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (CZ_WebImage)

-(void)cz_setImageWithURLString:(NSString *)urlString {
    
    //转换URL
    NSURL *url = [NSURL URLWithString:urlString];
    //设置图像
    if (url != nil) {
        [self sd_setImageWithURL:url];
    }
}

@end
