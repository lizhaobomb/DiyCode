//
//  DiyCodeMeApiManager.m
//  DiyCode
//
//  Created by lizhao on 2018/3/27.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "DiyCodeMeApiManager.h"
#import "DiyCodeService.h"

@interface DiyCodeMeApiManager()<CTAPIManager,CTAPIManagerValidator>
@end

@implementation DiyCodeMeApiManager

- (NSString *)methodName {
    return @"users/me.json";
}

- (CTAPIManagerRequestType)requestType {
    return CTAPIManagerRequestTypeGet;
}

- (NSString * _Nonnull)serviceIdentifier {
    return ServiceIdentifierDiyCode;
}


- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return CTAPIManagerErrorTypeNoError;
}

- (CTAPIManagerErrorType)manager:(CTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    return CTAPIManagerErrorTypeNoError;
}


@end
