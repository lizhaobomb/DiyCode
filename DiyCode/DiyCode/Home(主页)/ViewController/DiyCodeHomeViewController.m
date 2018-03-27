//
//  DiyCodeHomeViewController.m
//  Bygones
//
//  Created by lizhao on 2018/3/7.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeHomeViewController.h"
#import <TYPagerController/TYPagerController.h>
#import <TYPagerController/TYTabPagerBar.h>
#import <HandyFrame/UIView+LayoutMethods.h>
#import "DiyCodeTopicsViewController.h"
#import "DiyCodeNewsViewController.h"
#import "DiyCodeSitesViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import "SLSlideMenu.h"
#import "DiyCodeMineViewController.h"

@interface DiyCodeHomeViewController () <   TYPagerControllerDelegate,
                                            TYPagerControllerDataSource,
                                            TYTabPagerBarDelegate,
                                            TYTabPagerBarDataSource,
                                            SLSlideMenuProtocol
                                        >
@property (nonatomic, strong) TYPagerController *pageController;
@property (nonatomic, strong) TYTabPagerBar *tabPagerBar;
@property (nonatomic, strong) NSArray *menuDatas;
@property (nonatomic, strong) DiyCodeMineViewController *mineVC;
@end

@implementation DiyCodeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"DiyCode";
    [self addLeftMenu];
    [self addPageController];
    [self addTabPagerBar];
    [self setupMenuDatas];
    [self reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupLayout];
}


#pragma mark - methods
- (void)addLeftMenu {
    [SLSlideMenu prepareSlideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuSwipeDirectionLeft slideOffset:300 allowSlideMenuSwipeShow:YES allowSwipeCloseMenu:YES aboveNav:YES identifier:@"swipeLeft" object:nil];
}

- (void)addPageController {
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
}

- (void)addTabPagerBar {
    [self.view addSubview:self.tabPagerBar];
}

- (void)setupLayout {
    self.tabPagerBar.ct_width = SCREEN_WIDTH;
    self.tabPagerBar.ct_height = 44;
    self.tabPagerBar.ct_top = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    [self.pageController.view fromTheBottom:0 ofView:self.tabPagerBar];
    self.pageController.view.ct_height = CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.tabPagerBar.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame);
    self.pageController.view.ct_width = SCREEN_WIDTH;
}

- (void)setupMenuDatas {
    self.menuDatas = @[@"Topics",@"News",@"Sites"];
}

- (void) reloadData {
    [self.pageController reloadData];
    [self.tabPagerBar reloadData];
}

#pragma mark - SLSlideMenuProtocol
- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView {
    DiyCodeMineViewController *mineVC = [[DiyCodeMineViewController alloc] init];
    _mineVC = mineVC;
    [menuView addSubview:mineVC.view];
    mineVC.view.frame = menuView.bounds;
}

#pragma mark - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController {
    return self.menuDatas.count;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    NSString *title = self.menuDatas[index];
    if ([title isEqualToString:@"Topics"]) {
        return [[DiyCodeTopicsViewController alloc] init];
    }
    if ([title isEqualToString:@"News"]) {
        return [[DiyCodeNewsViewController alloc] init];
    }
    if ([title isEqualToString:@"Sites"]) {
        return [[DiyCodeSitesViewController alloc] init];
    }
    return [[UIViewController alloc] init];
}

#pragma mark - TYPagerControllerDelegate
- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [self.tabPagerBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [self.tabPagerBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

#pragma mark - TYTabPagerBarDataSource
- (NSInteger)numberOfItemsInPagerTabBar {
    return self.menuDatas.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.menuDatas[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = self.menuDatas[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [self.pageController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - getters
- (TYPagerController *)pageController {
    if (!_pageController) {
        _pageController = [[TYPagerController alloc] init];
        _pageController.view.backgroundColor = [UIColor blueColor];
        _pageController.layout.prefetchItemCount = 1;
        // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
        _pageController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
        _pageController.dataSource = self;
        _pageController.delegate = self;
    }
    return _pageController;
}

- (TYTabPagerBar *)tabPagerBar {
    if (!_tabPagerBar) {
        _tabPagerBar = [[TYTabPagerBar alloc] init];
        _tabPagerBar.delegate = self;
        _tabPagerBar.dataSource = self;
        _tabPagerBar.backgroundColor = [UIColor flatSkyBlueColor];
        _tabPagerBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
        _tabPagerBar.layout.cellWidth = SCREEN_WIDTH / 3;
        _tabPagerBar.layout.cellSpacing = 0;
        _tabPagerBar.layout.cellEdging = 0;
        [_tabPagerBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    }
    return _tabPagerBar;
}

@end
