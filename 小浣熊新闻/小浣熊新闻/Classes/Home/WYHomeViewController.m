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
/// 分页控制器
@property(nonatomic,weak)UIPageViewController *pageViewController;
/// 分页控制器内部的滚动视图
@property(nonatomic,weak)UIScrollView *pageScrollView;
/// 当前列表控制器
@property(nonatomic,weak)WYNewsListViewController *currentListVC;
/// 将要显示列表 控制器
@property(nonatomic,weak)WYNewsListViewController *nextListVC;



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

#pragma mark -  KVO 的监听方法

/// 是KVO统一调用的方法
///
/// @param keyPath 监听的 keyPath (属性)
/// @param object  监听的对象,可以通过对象获得属性 值
/// @param change  监听的变化
/// @param context 上下文,一般是null
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    NSLog(@"====0000=====>%@, %@, %@", keyPath, object, change);
    
//    NSLog(@"%@", NSStringFromCGPoint(_pageScrollView.contentOffset));
    
    CGFloat width = _pageScrollView.bounds.size.width;
    
    CGFloat offSetX = ABS(_pageScrollView.contentOffset.x - width);
    
    CGFloat scale = offSetX / width;
//    NSLog(@"%f,从%zd,到 %zd", scale, _currentListVC.channelIndex,_nextListVC.channelIndex);
    
    //根据索引调整频道视图中标签的比例
    [_channelView changeLabelWithIndex:_currentListVC.channelIndex scale:(1 - scale)];
    [_channelView changeLabelWithIndex:_nextListVC.channelIndex scale:scale];
     
//    NSLog(@"%f", offSetX);

}



- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<WYNewsListViewController *> *)pendingViewControllers {
    
//    NSLog(@"当前控制器 %@", [pageViewController.viewControllers valueForKey:@"channelIndex"]);
    
//    NSLog(@"要显示的 %@", [pendingViewControllers valueForKey:@"channelIndex"]);
    
    //记录当前列表和将要显示列表控制器
    _currentListVC = pageViewController.viewControllers[0];
    _nextListVC = pendingViewControllers[0];
    
    
//    NSLog(@"%@", [pageViewController.view subviews][0]);
    
//    NSLog(@"=====>%@", _pageScrollView);
    
    /// KVO 监听滚动视图
    [_pageScrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];

}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<WYNewsListViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    
//    NSLog(@"前一个控制器数组 %@", [previousViewControllers valueForKey:@"channelIndex"]);
    ///用观察者监听只有两种方式,一种是KVO,用的很少,因为它只有一个目的,监听某个对象的某个特殊属性的变化 ,在监听WebView时,因为整个页面的大小不知道,监听的是 contentOffsize的高度
    /// 注销滚动视图的观察者,一旦注销观察者,后续分页控制器导致的 contentOffset 不再监听
    //保证监听的变化就是一个完整屏的数值变化
    [_pageScrollView removeObserver:self forKeyPath:@"contentOffset"];
    

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


#pragma mark - 实现监听方法
- (void)didSelectedIndex:(WYChannelView *)cv {
    
    NSLog(@"选中的标签:%zd", cv.selectedIndex);
    
    NSInteger idx = cv.selectedIndex;
    
    if (_currentListVC.channelIndex == idx) {
        NSLog(@"不做什么");
        return;
    }
    
    
    [_channelView changeLabelWithIndex:idx scale:1];
    
    [_channelView changeLabelWithIndex:_currentListVC.channelIndex scale:0];
    
    //设置列表控制器
    WYNewsListViewController *vc = [[WYNewsListViewController alloc]initWithChannelId:_channelList[idx].tid index:idx];
    
    NSInteger dir = UIPageViewControllerNavigationDirectionForward;
    
    if (idx < _currentListVC.channelIndex) {
        dir = UIPageViewControllerNavigationDirectionReverse; 
    }
    
    [_pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    _currentListVC = vc;

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
    
    //添加监听方法
    [cv addTarget:self action:@selector(didSelectedIndex:) forControlEvents:UIControlEventValueChanged];
    
    
    
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
    
    _pageViewController = pc;
    
    if ([pc.view .subviews[0] isKindOfClass:[UIScrollView class]]) {
        _pageScrollView = pc.view.subviews[0];
    }
    

}




@end
