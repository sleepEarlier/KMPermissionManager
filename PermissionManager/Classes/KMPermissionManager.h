//
//  KMPermissionManager.h
//  KMPermissionManager
//
//  Created by Kimi on 2019/12/22.
//  Copyright © 2019年 Kimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#ifdef NSFoundationVersionNumber_iOS_9_0
#import <CoreTelephony/CTCellularData.h>
#import <Contacts/Contacts.h>
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/// 蜂窝网络数据权限改变通知
extern NSString * const KMCellularDataPermissionDidChangedNotification;
extern NSString * const KMCellularDataRestrictedStateUserInfoKey;

typedef NS_ENUM(NSInteger, KMPermissionStatus) {
    KMPermissionStatusNotDetermined = 0,
    KMPermissionStatusRestricted    = 1,
    KMPermissionStatusDenied        = 2,
    KMPermissionStatusAuthorized    = 3,
};

@interface KMPermissionManager : NSObject

#pragma mark - 相机权限
+ (KMPermissionStatus)cameraPermissionStatus;
+ (void)requestCameraPermissionOnSuccess:(nullable void(^)(void))success failure:(nullable void(^)(KMPermissionStatus status))failure;

#pragma mark - 相册权限
+ (KMPermissionStatus)photoLibraryPermissionStatus;
+ (void)requestPhotoLibraryPermissionOnSuccess:(nullable void(^)(void))success failure:(nullable void(^)(KMPermissionStatus status))failure;

#pragma mark - 定位权限
+ (KMPermissionStatus)locationPermissionStatus;
+ (void)requestLocationPermissionWhenInUse:(BOOL)onlyWhenInUse success:(nullable void(^)(void))success failre:(nullable void(^)(KMPermissionStatus status))failure;

#pragma mark - 通讯录权限
+ (KMPermissionStatus)contactsPermissionStatus API_AVAILABLE(ios(9.0));
+ (void)requestContactsPermissionOnSuccess:(nullable void(^)(void))success failure:(nullable void(^)(KMPermissionStatus status))failure API_AVAILABLE(ios(9.0));

#pragma mark - 麦克风权限
+ (KMPermissionStatus)microphonePermissionStatus;
// iOS 10.x 模拟器存在不会弹出权限框的问题，请使用真机
+ (void)requestMicrophonePermissionOnSuccess:(nullable void(^)(void))success failure:(nullable void(^)(KMPermissionStatus sts))failure;

#pragma mark - 推送权限
+ (KMPermissionStatus)notificationPermissionStatus;
/// iOS10之前不会调用回调，需要在AppDelete中处理
+ (void)requestNotificationPermissionOnSuccess:(nullable void(^)(void))success failure:(nullable void(^)(KMPermissionStatus status))failure;

#pragma mark - 蜂窝煤网络权限
/// 蜂窝网络数据权限监听，如果权限变化，会在主线程发送 `kSMTCellularDataPermissionDidChangedNotification` 通知，iOS9之后有效
/// 在 notification.userInfo 中通过 key: `kSMTCellularDataRestrictedStateUserInfoKey` 获取状态值，状态值类型为CTCellularDataRestrictedState
+ (void)startMonitorCellularDataPermissionChanged API_AVAILABLE(ios(9.0));
+ (void)stopMonitorCellularDataPermissionChanged API_AVAILABLE(ios(9.0));

/** 获取当前蜂窝网络数据权限 */
+ (KMPermissionStatus)cellularDataRestrictedState API_AVAILABLE(ios(9.0));

@end
NS_ASSUME_NONNULL_END
