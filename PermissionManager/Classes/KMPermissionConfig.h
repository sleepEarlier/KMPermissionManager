//
//  KMPermissionConfig.h
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import <Foundation/Foundation.h>
#import "KMPermissionDefine.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
#import <HealthKit/HealthKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KMLocationType) {
    KMLocationTypeWhenInUse,
    KMLocationTypeAlways
};

@interface KMPermissionConfig : NSObject

+ (instancetype)configWithType:(KMPermissionType)type;

@property (nonatomic, assign) KMPermissionType type;

@end

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
+ (void)setObjectTypes:(NSSet<HKObjectType *> *)types;

+ (NSSet<HKObjectType *> *)objectTypes;

@end

NS_ASSUME_NONNULL_END
