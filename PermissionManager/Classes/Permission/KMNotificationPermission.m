//
//  KMNotificationPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMNotificationPermission.h"
#import "KMPermissionConfig.h"
#import "KMPermissionConfig+extend.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@implementation KMNotificationPermission

+ (KMPermissionStatus)status {
    if (@available(iOS 10.0, *)) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block KMPermissionStatus status;
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            status = [self unifyStatusFromUNAuthorizationStatus:settings.authorizationStatus];
           dispatch_semaphore_signal(sema);
        }];

        if (![NSThread isMainThread]) {
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        } else {
            while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0]];
            }
        }

#if !__has_feature(objc_arc)
        dispatch_release(sema);
#endif
        return status;
    } else {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (!setting) {
            return KMPermissionStatusNotDetermined;
        }
        BOOL enable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
        KMPermissionStatus status = enable ? KMPermissionStatusAuthorized : KMPermissionStatusDenied;
        return status;
    }
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    return [self status];
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    // return UNAuthorizationStatus
    KMPermissionStatus status = [self status];
    if (status == KMPermissionStatusNotDetermined) {
        return status;
    }
    else {
        return status - 1;
    }
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == KMPermissionStatusNotDetermined);
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == KMPermissionStatusAuthorized);
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == KMPermissionStatusDenied);
    return rst;
}

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions options = config.options;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (completion) {
                if ([NSThread currentThread].isMainThread) {
                    completion(granted);
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(granted);
                    });
                }
            }
        }];
    } else {
        UIUserNotificationSettings *settings = config.settings;
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

#pragma mark - Help
+ (KMPermissionStatus)unifyStatusFromUNAuthorizationStatus:(UNAuthorizationStatus)status API_AVAILABLE(ios(10.0)){
    if (status == UNAuthorizationStatusNotDetermined) {
        return KMPermissionStatusNotDetermined;
    }
    else if (status == UNAuthorizationStatusDenied) {
        return KMPermissionStatusDenied;
    }
    else {
        // 推送没有Restricted状态
        return KMPermissionStatusAuthorized;
    }
}

@end
