//
//  KMCalendarPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMCalendarPermission.h"
#import "KMPermissionConfig.h"
#import <EventKit/EventKit.h>

@implementation KMCalendarPermission

+ (EKAuthorizationStatus)status {
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:(EKEntityTypeEvent)];
    return status;
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    EKAuthorizationStatus status = [self status];
    return (KMPermissionType)status;
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    return [self status];
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
