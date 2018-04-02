//
//  AppDelegate+Weex.m
//  DiyCode
//
//  Created by lizhao on 2018/4/2.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "AppDelegate+Weex.h"
#import <WeexSDK/WeexSDK.h>
#import "LZImageLoader.h"

@implementation AppDelegate (Weex)
- (void)initWeexSDK {
    //1.business configuration
    [WXAppConfiguration setAppGroup:@"LZApp"];
    [WXAppConfiguration setAppName:@"DiyCode"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    //2.init sdk environment
    [WXSDKEngine initSDKEnvironment];
    
    //3.register custom module and component, optional
    
    //4.register the implementation of protocol, optional
    [WXSDKEngine registerHandler:[LZImageLoader new] withProtocol:@protocol(WXImgLoaderProtocol)];
    //5.set the log level
    [WXLog setLogLevel:WXLogLevelAll];
}

@end
