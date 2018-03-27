//
//  DiyCodeMineViewController.m
//  DiyCode
//
//  Created by lizhao on 2018/3/23.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeMineViewController.h"
#import "DiyCodeMineHeaderView.h"

#import <HandyFrame/UIView+LayoutMethods.h>

@interface DiyCodeMineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) DiyCodeMineHeaderView *headerView;
@end

@implementation DiyCodeMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headerView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.table fill];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createHeaderView {
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
@end
