//
//  NSUserDefaults+User.h
//  DiyCode
//
//  Created by lizhao on 2018/3/28.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (User)

+ (void)saveUserTokenInfo:(NSDictionary *)userTokenInfo;
+ (NSDictionary *)userTokenInfo;

@end
