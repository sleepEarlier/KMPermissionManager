//
//  KMPermissionConfig+notification.m
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig+notification.h"
#import <objc/runtime.h>

@implementation KMPermissionConfig (notification)

- (UNAuthorizationOptions)options {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setOptions:(UNAuthorizationOptions)options {
    objc_setAssociatedObject(self, @selector(options), @(options), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIUserNotificationSettings *)settings {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSettings:(UIUserNotificationSettings *)settings {
    objc_setAssociatedObject(self, @selector(settings), settings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)notificationConfigWithOptions:(UNAuthorizationOptions)options API_AVAILABLE(ios(10.0)) {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeNotification];
    config.options = options;
    return config;
}

+ (instancetype)notificationConfigWithSettings:(UIUserNotificationSettings *)settings {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeNotification];
    config.settings = settings;
    return config;
}

@end
