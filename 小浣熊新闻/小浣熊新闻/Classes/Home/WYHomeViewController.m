//
//  WYHomeViewController.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/25.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYChannelView.h"
#import "WYChannel.h"
#import "WYNewsListViewController.h"

@interface WYHomeViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>
/// 频道视图
@property(nonatomic,strong)WYChannelView *channelView;
@end

@implementation WYHomeViewController{
    
    NSArray <WYChannel *> *_channelList;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试频道数据
    _channelList = [WYChannel channelList];
    
    [self setupUI];
    
    _channelView.channelList = _channelList;
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    NSLog(@"当前控制器 %@", [pageViewController.viewControllers valueForKey:@"channelIndex"]);
    
    NSLog(@"要显示的 %@", [pendingViewControllers valueForKey:@"channelIndex"]);
    
    
    NSLog(@"%@", [pageViewController.view subviews][0]);

}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    
    NSLog(@"前一个控制器数组 %@", [previousViewControllers valueForKey:@"channelIndex"]);
    

}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(WYNewsListViewController *)viewController {
    
    NSInteger idx = viewController.channelIndex;
    
    idx--;
    
    //判断idx
    if (idx < 0) {
        NSLog(@"没有前一个");
        return nil;
    }
    //创建新的控制器
    WYNewsListViewController *vc = [[WYNewsListViewController alloc]initWithChannelId:_channelList[idx].tid index:idx];
    
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(WYNewsListViewController *)viewController {
    
    NSInteger idx = viewController.channelIndex;
    
    idx++;
    
    if (idx > _channelList.count) {
        NSLog(@"没有后一个");
    }
    
    WYNewsListViewController *vc = [[WYNewsListViewController alloc]initWithChannelId:_channelList[idx].tid index:idx];
    
    return vc;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor cz_randomColor];
    WYChannelView *cv = [WYChannelView channelView];
    
    
    [self.view addSubview:cv];
    
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    
    //取消自动调整滚动视图间距
    self.automaticallyAdjustsScrollViewInsets = NO; 
    
    _channelView = cv;
    
    
    [self setupPageController];

}

- (void)setupPageController {
    //创建控制器
    UIPageViewController *pc = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //设置分页控制器的子控制器
    WYNewsListViewController *vc = [[WYNewsListViewController alloc]initWithChannelId:_channelList[2].tid   index:2 ];
    
    [pc setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    //将分页控制器当做子视图添加到当前控制器上
    [self addChildViewController:pc];
    
    //添加视图
    [self.view addSubview:pc.view];
    
    [pc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    //完成子控制器的添加
    [pc didMoveToParentViewController:self];
    
    pc.dataSource = self;
    
    pc.delegate = self;
    

}




@end
