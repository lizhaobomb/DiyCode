//
//  LZImageLoader.m
//  DiyCode
//
//  Created by lizhao on 2018/4/2.
//  Copyright © 2018年 lizhao. All rights reserved.
//

#import "LZImageLoader.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>
@implementation LZImageLoader

- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)options completed:(void (^)(UIImage *, NSError *, BOOL))completedBlock {
    if ([url hasPrefix:@"//"]) {
        url = [@"http:" stringByAppendingString:url];
    }
    return (id<WXImageOperationProtocol>)[[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, finished);
        }
    }];
}

@end
