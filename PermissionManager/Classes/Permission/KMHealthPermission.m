//
//  KMHealthPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMHealthPermission.h"
#import "KMPermissionConfig.h"
#import <HealthKit/HealthKit.h>

@implementation KMHealthPermission

+ (HKAuthorizationStatus)status {
    HKObjectType *type = [KMPermissionConfig objectTypes].anyObject;
    HKAuthorizationStatus st = [[HKHealthStore new] authorizationStatusForType:type];
    return st;
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    HKAuthorizationStatus status = [self status];
    if (status == HKAuthorizationStatusNotDetermined) {
        return KMPermissionStatusNotDetermined;
    }
    else if (status == HKAuthorizationStatusSharingDenied){
        return KMPermissionStatusDenied;
    }
    else {
        return KMPermissionStatusAuthorized;
    }
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    return [self status];
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == HKAuthorizationStatusNotDetermined);
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == HKAuthorizationStatusSharingAuthorized);
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == HKAuthorizationStatusSharingDenied);
    return rst;
}

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    NSSet<HKObjectType *> *types = [KMPermissionConfig objectTypes];
    HKHealthStore *store = [HKHealthStore new];
    [store requestAuthorizationToShareTypes:types readTypes:types completion:^(BOOL success, NSError * _Nullable error) {
        if (completion) {
            completion(success);
        }
    }];
}


@end
