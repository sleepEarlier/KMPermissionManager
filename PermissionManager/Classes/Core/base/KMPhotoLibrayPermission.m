//
//  KMPhotoLibrayPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMPhotoLibrayPermission.h"
#import "KMPermissionConfig.h"
#import <Photos/Photos.h>

@implementation KMPhotoLibrayPermission

+ (PHAuthorizationStatus)status {
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    return photoStatus;
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    PHAuthorizationStatus status = [self status];
    return (KMPermissionType)status;
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    return [self status];
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == PHAuthorizationStatusNotDetermined);
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == PHAuthorizationStatusAuthorized);
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == PHAuthorizationStatusRestricted) || ([self status] == PHAuthorizationStatusDenied);
    return rst;
}

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    if ([self isNotDeterminedForPermission:config.type]) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (completion) {
                BOOL granted = (status == PHAuthorizationStatusAuthorized);
                if ([NSThread currentThread].isMainThread) {
                    completion(granted);
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(granted);
                    });
                }
            }
        }];
    }
    else if ([self isAuthorizedForPermission:config.type]) {
        if (completion) {
            completion(YES);
        }
    }
    else if (completion) {
        completion(NO);
    }
}


@end
