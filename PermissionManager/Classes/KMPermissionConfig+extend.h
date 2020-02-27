//
//  KMPermissionConfig+extend.h
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/2/27.
//

#import <KMPermissionManager/KMPermissionManager.h>
#import "KMPermissionDefine.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
#import <HealthKit/HealthKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMPermissionConfig (location)

/// 定位权限类型
@property (nonatomic, assign) KMLocationType locationType;

/// 是否允许后台定位（使用时请同时修改工程配置\Info.plist）
@property (nonatomic, assign) BOOL allowsBackgroundLocationUpdates;

@end


@interface KMPermissionConfig (notification)

/// iOS10+推送权限类型
@property (nonatomic, assign) UNAuthorizationOptions options API_AVAILABLE(ios(10.0));

/// iOS10以下推送权限类型
@property (nullable, nonatomic, strong) UIUserNotificationSettings *settings;

@end


@interface KMPermissionConfig (health)

/// 健康权限类型
+ (void)setReadTypes:(NSSet<HKObjectType *> *)types;

+ (NSSet<HKObjectType *> *)readTypes;

+ (void)setShareTypes:(NSSet<HKSampleType *> *)shareTypes;

+ (NSSet<HKSampleType *> *)shareTypes;

@end

NS_ASSUME_NONNULL_END
