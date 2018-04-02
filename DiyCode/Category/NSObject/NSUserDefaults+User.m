//
//  NSUserDefaults+User.m
//  DiyCode
//
//  Created by lizhao on 2018/3/28.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "NSUserDefaults+User.h"

@implementation NSUserDefaults (User)

+ (void)saveUserTokenInfo:(NSDictionary *)userTokenInfo {
    [[NSUserDefaults standardUserDefaults] setObject:userTokenInfo forKey:@"User"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDictionary *)userTokenInfo {
    NSDictionary *userTokenInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    return userTokenInfo;
}

@end
