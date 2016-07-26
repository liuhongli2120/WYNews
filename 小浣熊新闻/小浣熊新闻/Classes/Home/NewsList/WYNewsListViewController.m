//
//  WYNewsListViewController.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/26.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYNewsListViewController.h"
#import "WYNewsListItem.h"


static NSString *cellId = @"cellId";

@interface WYNewsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <WYNewsListItem *> *newsList;

@end

@implementation WYNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = _newsList[indexPath.row].title;
    
    return cell;
}

#pragma mark - 加载数据
- (void)loadData {
    [[HLNetworkManager sharedManager] newsListWithChannel:@"T1348648517839" start:0 completion:^(NSArray *array, NSError *error) {
        NSLog(@"%@",array);
        //字典转模型
        NSArray *list = [NSArray yy_modelArrayWithClass:[WYNewsListItem class] json:array];
        
        self.newsList = [NSMutableArray arrayWithArray:list];
        
        [self.tableView reloadData];
        
    }];
}

#pragma mark - 设置界面
- (void)setupUI {
    UITableView *tv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    [self.view addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    tv.dataSource = self;
    tv.delegate = self;
    
    _tableView = tv;
    
}



@end
