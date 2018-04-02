//
//  DiyCodeWeexViewController.m
//  DiyCode
//
//  Created by lizhao on 2018/4/2.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeWeexViewController.h"
#import <WeexSDK/WXSDKInstance.h>

@interface DiyCodeWeexViewController ()
@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@end

@implementation DiyCodeWeexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.bounds;
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        NSLog(@"%@",error.description);
    };
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"js"];
    [_instance renderWithURL:url options:@{@"bundleUrl":[url absoluteString]} data:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_instance destroyInstance];
}

@end
