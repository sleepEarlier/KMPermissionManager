//
//  KMContactsPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMContactsPermission.h"
#import "KMPermissionConfig.h"
#ifdef NSFoundationVersionNumber_iOS_9_0
#import <Contacts/Contacts.h>
#endif

@implementation KMContactsPermission

+ (CNAuthorizationStatus)status {
    CNAuthorizationStatus contackStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    return contackStatus;
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    CNAuthorizationStatus status = [self status];
    return (KMPermissionType)status;
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    return [self status];
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == CNAuthorizationStatusNotDetermined);
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == CNAuthorizationStatusAuthorized);
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == CNAuthorizationStatusRestricted) || ([self status] == CNAuthorizationStatusDenied);
    return rst;
}

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    if ([self isNotDeterminedForPermission:config.type]) {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    if ([NSThread currentThread].isMainThread) {
                        completion(granted);
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(granted);
                        });
                    }
                }
            });
        }];
    }
    else if ([self isAuthorizedForPermission:config.type]) {
        if (completion) {
            completion(YES);
        }
    }
    else if (completion) {
        completion(YES);
    }
}


@end
