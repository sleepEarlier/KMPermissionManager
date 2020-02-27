//
//  KMPermissionManager.m
//  KMPermissionManager
//
//  Created by Kimi on 2019/12/22.
//  Copyright © 2019年 Kimi. All rights reserved.
//

#import "KMPermissionManager.h"
#import "KMPermissionProtocol.h"
#import "KMCameraPermission.h"
#import "KMContactsPermission.h"
#import "KMHealthPermission.h"
#import "KMLocationPermission.h"
#import "KMMicrophonePermission.h"
#import "KMNotificationPermission.h"
#import "KMPhotoLibrayPermission.h"
#import "KMRemindersPermission.h"
#import "KMCalandarPermission.h"

NSString * const KMCellularDataPermissionDidChangedNotification = @"KMCellularDataPermissionDidChangedNotification";
NSString * const KMCellularDataRestrictedStateUserInfoKey = @"KMCellularDataRestrictedStateUserInfoKey";
static id staticCellularData = nil;

@implementation KMPermissionManager

#pragma mark - API
+ (void)openSettingsComplete:(KMPermissionResult)completion {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:completion];
    } else {
        // Fallback on earlier versions
        BOOL rst = [[UIApplication sharedApplication] openURL:url];
        if (completion) {
            completion(rst);
        }
    }
}

+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    return [[self classForType:type] isNotDeterminedForPermission:type];
}

+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    return [[self classForType:type] isAuthorizedForPermission:type];
}

+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    return [[self classForType:type] isRestrictedOrDeniedForPermission:type];
}

+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    [[self classForType:config.type] requestPermission:config complete:completion];
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    return [[self classForType:type] unifyStatusForPermission:type];
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    return [[self classForType:type] rawStatusForPermission:type];
}

// 开始监听蜂窝网络数据权限变化
+ (void)startMonitorCellularDataPermissionChanged {
    
    if (@available(iOS 9, *)) {
        staticCellularData = [[CTCellularData alloc] init];
        CTCellularData *cellular = staticCellularData;
        cellular.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [NSNotificationCenter.defaultCenter postNotificationName:KMCellularDataPermissionDidChangedNotification object:@(state) userInfo:@{KMCellularDataRestrictedStateUserInfoKey: @(state)}];
            });
        };
    }
}

// 停止监听蜂窝网络数据权限变化
+ (void)stopMonitorCellularDataPermissionChanged {
    ((CTCellularData *)staticCellularData).cellularDataRestrictionDidUpdateNotifier = nil;
    staticCellularData = nil;
}

+ (CTCellularDataRestrictedState)cellularDataRestrictedState {
    
    if (@available(iOS 9, *)) {
        return ((CTCellularData *)staticCellularData).restrictedState;
    } else {
        return kCTCellularDataNotRestricted;
    }
}

#pragma mark - Help
+ (Class<KMPermissionProtocol>)classForType:(KMPermissionType)type {
    switch (type) {
        case KMPermissionTypeCamera:
            return [KMCameraPermission class];
        case KMPermissionTypePhotoLibray:
            return [KMPhotoLibrayPermission class];
        case KMPermissionTypeLocation:
            return [KMLocationPermission class];
        case KMPermissionTypeContacts:
            return [KMContactsPermission class];
        case KMPermissionTypeMicrophone:
            return [KMMicrophonePermission class];
        case KMPermissionTypeNotification:
            return [KMNotificationPermission class];
        case KMPermissionTypeReminders:
            return [KMRemindersPermission class];
        case KMPermissionTypeCalendar:
            return [KMCalandarPermission class];
        case KMPermissionTypeHealth:
            return [KMHealthPermission class];
            
        default:
            return nil;
    }
}


@end
