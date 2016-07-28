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
    
    WYNewsListItem *model = _newsList[indexPath.row];
    
    NSString *cellId;
    if (model.imgextra > 0) {
        cellId = extraCellId;
    } else {
        cellId = normalCellId;
    }
    
    WYNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.titleLabel.text = model.title;
    cell.sourceLabel.text = model.source;
    cell.replyLabel.text = @(model.replyCount).description;
    
    //image
    NSURL *imageUrl = [NSURL URLWithString:model.imgsrc];
    [cell.iconView sd_setImageWithURL:imageUrl];
    
    //设置多图
    
    NSInteger idx = 0;
    for (NSDictionary *dict in model.imgextra) {
        NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
        
        UIImageView *iv = cell.extraIcon[idx++];
        [iv sd_setImageWithURL:url];
    }
    
    
    
    
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
    
    [tv registerNib:[UINib nibWithNibName:@"WYNewsNormalCell" bundle:nil] forCellReuseIdentifier:normalCellId];
    [tv registerNib:[UINib nibWithNibName:@"WYNewsExtraImagesCell" bundle:nil] forCellReuseIdentifier:extraCellId];
    tv.dataSource = self;
    tv.delegate = self;
    
    
    tv.estimatedRowHeight = 100;
    tv.rowHeight = UITableViewAutomaticDimension;
    
    _tableView = tv;
    
}

@end
