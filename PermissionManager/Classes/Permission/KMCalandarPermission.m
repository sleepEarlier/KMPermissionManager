//
//  KMCalandarPermission.m
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/2/21.
//

#import "KMCalandarPermission.h"
#import "KMPermissionConfig.h"
#import <EventKit/EventKit.h>

@implementation KMCalandarPermission

+ (EKAuthorizationStatus)status {
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:(EKEntityTypeEvent)];
    return status;
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = [self status] == EKAuthorizationStatusNotDetermined;
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = [self status] == EKAuthorizationStatusAuthorized;
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == EKAuthorizationStatusRestricted) || ([self status] == EKAuthorizationStatusDenied) ;
    return rst;
}

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (completion) {
            completion(granted);
        }
    }];
}

@end
