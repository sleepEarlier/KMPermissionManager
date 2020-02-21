//
//  KMPermissionProtocol.h
//  PermissionManager
//
//  Created by 林杜波 on 2020/2/21.
//

#import <Foundation/Foundation.h>
#import "KMPermissionDefine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol KMPermissionProtocol <NSObject>

@required
/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type;

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type;

/// 是否已拒绝或设备不支持
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type;

/// 请求权限
+ (void)requestPermission:(KMPermissionType)type complete:(KMPermissionResult)completion;

@end

NS_ASSUME_NONNULL_END
