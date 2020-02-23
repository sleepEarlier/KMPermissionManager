//
//  KMCameraPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMCameraPermission.h"
#import <AVFoundation/AVFoundation.h>
#import "KMPermissionConfig.h"

@implementation KMCameraPermission

+ (AVAuthorizationStatus)status {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    return status;
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    AVAuthorizationStatus status = [self status];
    return (KMPermissionType)status;
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    return [self status];
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == AVAuthorizationStatusNotDetermined);
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == AVAuthorizationStatusAuthorized);
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == AVAuthorizationStatusRestricted) || ([self status] == AVAuthorizationStatusDenied);
    return rst;
}

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    if ([self isNotDeterminedForPermission:config.type]) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (completion) {
                if ([NSThread currentThread].isMainThread) {
                    completion(granted);
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(granted);
                    });
                }
            }
        }];
    }
    else if ([self isRestrictedOrDeniedForPermission:config.type]) {
        if (completion) {
            completion(NO);
        }
    }
    else if (completion){
        completion(YES);
    }
}

@end
