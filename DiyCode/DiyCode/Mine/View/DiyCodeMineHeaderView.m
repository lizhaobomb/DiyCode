//
//  DiyCodeMineHeaderView.m
//  DiyCode
//
//  Created by lizhao on 2018/3/27.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeMineHeaderView.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import "DiyCodeLoginViewController.h"
#import "NSObject+TopVC.h"

@interface DiyCodeMineHeaderView()
@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation DiyCodeMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupLayout];
}

- (void)configSubviews {
    [self addSubview:self.loginButton];
}

- (void)setupLayout {
    _loginButton.center = self.center;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton sizeToFit];
    }
    return _loginButton;
}

- (void)loginButtonClicked:(id)sender {
    DiyCodeLoginViewController *loginVC = [[DiyCodeLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[NSObject lz_topViewController] presentViewController:nav animated:YES completion:nil];
}


@end
