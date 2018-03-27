//
//  NSObject+TopVC.m
//  DiyCode
//
//  Created by lizhao on 2018/3/27.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "NSObject+TopVC.h"

@implementation NSObject (TopVC)

+ (UIViewController *)lz_topViewController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)rootVC).topViewController;
    }
    return rootVC;
}

@end
