//
//  WYNewsListViewController.m
//  小浣熊新闻
//
//  Created by 刘宏立 on 16/7/26.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "WYNewsListViewController.h"
#import "WYNewsListItem.h"
#import "WYNewsCell.h"
#import <UIImageView+WebCache.h>


static NSString *normalCellId = @"normalCellId";
static NSString *extraCellId = @"extraCellId";
static NSString *bigImageCellId = @"bigImageCellId";
static NSString *headerCellId = @"headerCellId";

@interface WYNewsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray <WYNewsListItem *> *newsList;

@end

@implementation WYNewsListViewController

- (instancetype)initWithChannelId:(NSString *)channelId index:(NSInteger)index {
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _channelId = channelId;
        _channelIndex = index;
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setupUI];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WYNewsListItem *model = _newsList[indexPath.row];
    
    NSString *cellId;
    
    if (model.hasHead) {
        cellId = headerCellId;
    } else if (model.imgType) {
        cellId = bigImageCellId;
    } else if (model.imgextra > 0) {
        cellId = extraCellId;
    } else {
        cellId = normalCellId;
    }
    
    WYNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.newsItem = model;
    
    return cell;
}

#pragma mark - 加载数据
- (void)loadData {
    
    //T1348648517839(娱乐)
    //T1348648141035(军事)
    [[HLNetworkManager sharedManager] newsListWithChannel:_channelId start:0 completion:^(NSArray *array, NSError *error) {
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
    
    //设置表格的 contentInset
    tv.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    [tv registerNib:[UINib nibWithNibName:@"WYNewsNormalCell" bundle:nil] forCellReuseIdentifier:normalCellId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsExtraImagesCell" bundle:nil] forCellReuseIdentifier:extraCellId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsBigImageCell" bundle:nil] forCellReuseIdentifier:bigImageCellId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsBigImageCell" bundle:nil] forCellReuseIdentifier:headerCellId];
    
    
    tv.dataSource = self;
    tv.delegate = self;
    
    
    tv.estimatedRowHeight = 100;
    tv.rowHeight = UITableViewAutomaticDimension;
    
    _tableView = tv;
    
}

@end
