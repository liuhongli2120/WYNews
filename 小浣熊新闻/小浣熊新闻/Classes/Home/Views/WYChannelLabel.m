//
//  WYChannelLabel.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/30.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYChannelLabel.h"

#define kNormalSize 14
#define kSelectedSize 18

@implementation WYChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    
    //实例化标签,用大字体撑开 bounds ,布局大字体空间
    WYChannelLabel *l = [WYChannelLabel cz_labelWithText:title fontSize:kSelectedSize color:[UIColor blackColor]];
    
    //设置文本对齐方式
    l.textAlignment = NSTextAlignmentCenter;
    //设置小字体
    l.font = [UIFont systemFontOfSize:kNormalSize];
    
    //开启用户交互
    l.userInteractionEnabled = YES;
    
    //返回标签, 返回的 bounds 是大字体撑开后的 bounds
    return l;

}
///// touch,在试图内部实现,无法在外部监听 
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%s, %@", __FUNCTION__, self.text);
//
//}

//这种缩放比例是固定的,如果开发中遇到直接拷贝
- (void)setScale:(float)scale {
    
    _scale = scale;
    
    float max = (float)kSelectedSize / kNormalSize;
    float min = 1;
    
    float s = (max - 1)*scale + min;
    
    self.transform = CGAffineTransformMakeScale(s, s);
    //设置字体颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
}

@end
