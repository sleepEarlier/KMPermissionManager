//
//  KMPermissionConfig+notification.h
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface KMPermissionConfig (notification)

/// iOS10+推送权限类型
@property (nonatomic, assign) UNAuthorizationOptions options API_AVAILABLE(ios(10.0));

/// iOS10以下推送权限类型
@property (nullable, nonatomic, strong) UIUserNotificationSettings *settings;

+ (instancetype)notificationConfigWithOptions:(UNAuthorizationOptions)options API_AVAILABLE(ios(10.0));
+ (instancetype)notificationConfigWithSettings:(UIUserNotificationSettings *)settings;
@end

NS_ASSUME_NONNULL_END
