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
#import "SLSlideMenu.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface DiyCodeMineHeaderView()
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UILabel *nameLabel;
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
    [self addSubview:self.nameLabel];
}

- (void)setupLayout {
    _loginButton.ct_size = CGSizeMake(50, 50);
    _loginButton.center = self.center;
    _nameLabel.ct_top = _loginButton.ct_bottom;
    _nameLabel.ct_centerX = _loginButton.ct_centerX;
}

#pragma mark - methods
- (void)loginButtonClicked:(id)sender {
    [SLSlideMenu dismiss];
    DiyCodeLoginViewController *loginVC = [[DiyCodeLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[NSObject lz_topViewController] presentViewController:nav animated:YES completion:nil];
}

#pragma mark - getters & setters
- (void)setUserInfo:(NSDictionary *)userInfo {
    _userInfo = userInfo;
    _nameLabel.text = userInfo[@"login"];
    [_nameLabel sizeToFit];
    [_loginButton sd_setImageWithURL:[NSURL URLWithString:userInfo[@"avatar_url"]] forState:UIControlStateNormal];
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius = 5;
        [_loginButton sizeToFit];
    }
    return _loginButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

@end
