//
//  KMPermissionManager.h
//  KMPermissionManager
//
//  Created by Kimi on 2019/12/22.
//  Copyright © 2019年 Kimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMPermissionConfig.h"
#import <CoreTelephony/CTCellularData.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMPermissionManager : NSObject

/// 跳转设置
+ (void)openSettingsComplete:(nullable KMPermissionResult)completion;

/// 是否未请求过权限，HealthKit权限请在使用前设置`KMPermissionConfig`的`objectTypes`
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type;

/// 是否已授权，HealthKit权限请在使用前设置`KMPermissionConfig`的`objectTypes`
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type;

/// 是否已拒绝或设备被禁用，HealthKit权限请在使用前设置`KMPermissionConfig`的`objectTypes`
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type;


/*!
* @abstract 请求权限.
*
* @param config  权限设置
* @param completion  回调，主线程执行。（iOS 10之前请求推送权限不会执行回调，请在AppDelegate代理方法中处理）
*
* @discusstion HealthKit权限请在使用前设置`KMPermissionConfig`的`objectTypes`
*/
+ (void)requestPermission:(KMPermissionConfig *)config complete:(nullable KMPermissionResult)completion;

/// 统一权限状态值
+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type;

/// 原始权限状态值
+ (NSInteger)rawStatusForPermission:(KMPermissionType)type;

/// 开始监听蜂窝煤数据权限变化，变化时会发出`KMCellularDataPermissionDidChangedNotification`通知
/// 可通过UserInfo中的KMCellularDataRestrictedStateUserInfoKey获取状态值
+ (void)startMonitorCellularDataPermissionChanged;

/// 停止监听蜂窝煤数据权限变化
+ (void)stopMonitorCellularDataPermissionChanged;

/// 获取当前蜂窝数据权限（需先开始监听才能返回正确的状态）
+ (CTCellularDataRestrictedState)cellularDataRestrictedState;

@end
NS_ASSUME_NONNULL_END
