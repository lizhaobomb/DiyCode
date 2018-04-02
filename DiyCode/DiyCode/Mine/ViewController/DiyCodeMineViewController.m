//
//  DiyCodeMineViewController.m
//  DiyCode
//
//  Created by lizhao on 2018/3/23.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeMineViewController.h"
#import "DiyCodeMineHeaderView.h"
#import "DiyCodeMeApiManager.h"
#import "NSUserDefaults+User.h"

#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeMineViewController () <UITableViewDelegate, UITableViewDataSource, CTAPIManagerCallBackDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) DiyCodeMineHeaderView *headerView;
@property (nonatomic, strong) DiyCodeMeApiManager *meApiManager;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation DiyCodeMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headerView;
    if ([NSUserDefaults userTokenInfo][@"access_token"]) {
        [self.meApiManager loadData];
    }
    _datas = @[@[@"我的帖子",@"我的收藏"],@[@"关于我们",@"设置"]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.table fill];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CTNetworkCallbackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    if (manager == self.meApiManager) {
        NSLog(@"%@",manager.response.content);
        self.headerView.userInfo = manager.response.content;
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager {
    NSLog(@"%@",manager.response.content);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"row:%zd",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"!!clicked!!");
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor brownColor];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MineCell"];
    }
    return _table;
}

- (DiyCodeMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[DiyCodeMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    }
    return _headerView;
}

- (DiyCodeMeApiManager *)meApiManager {
    if (!_meApiManager) {
        _meApiManager = [[DiyCodeMeApiManager alloc] init];
        _meApiManager.delegate = self;
    }
    return _meApiManager;
}
@end
