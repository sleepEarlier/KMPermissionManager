//
//  KMPermissionProtocol.h
//  PermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import <Foundation/Foundation.h>
#import "KMPermissionDefine.h"

NS_ASSUME_NONNULL_BEGIN

@class KMPermissionConfig;

@protocol KMPermissionProtocol <NSObject>

@required
/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type;

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type;

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type;

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion;

/// 统一权限状态值
+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type;

/// 原始权限状态值
+ (NSInteger)rawStatusForPermission:(KMPermissionType)type;

@end

NS_ASSUME_NONNULL_END
