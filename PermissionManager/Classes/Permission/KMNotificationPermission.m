//
//  KMNotificationPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMNotificationPermission.h"
#import "KMPermissionConfig.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

typedef NS_ENUM(NSInteger, KMNotificationPermissionStatus) {
    KMNotificationPermissionStatusNotDetermined = 0,
    KMNotificationPermissionStatusDenied        = 1,
    KMNotificationPermissionStatusAuthorized    = 2,
};

@implementation KMNotificationPermission

+ (KMNotificationPermissionStatus)status {
    if (@available(iOS 10.0, *)) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block KMNotificationPermissionStatus status;
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            status = [self statusFromUNAuthorizationStatus:settings.authorizationStatus];
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
            return KMNotificationPermissionStatusNotDetermined;
        }
        BOOL enable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
        KMNotificationPermissionStatus status = enable ? KMNotificationPermissionStatusAuthorized : KMNotificationPermissionStatusDenied;
        return status;
    }
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == KMNotificationPermissionStatusNotDetermined);
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == KMNotificationPermissionStatusAuthorized);
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == KMNotificationPermissionStatusDenied);
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
+(KMNotificationPermissionStatus)statusFromUNAuthorizationStatus:(NSInteger)status {
    if (@available(iOS 10.0, *)) {
        if (status >= UNAuthorizationStatusAuthorized) {
            return KMNotificationPermissionStatusAuthorized;
        }
        return (KMNotificationPermissionStatus)status;
    } else {
        return KMNotificationPermissionStatusNotDetermined;
    }
}

@end
