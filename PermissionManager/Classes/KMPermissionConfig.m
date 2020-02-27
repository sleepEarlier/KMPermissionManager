//
//  KMPermissionConfig.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMPermissionConfig.h"
#import "KMPermissionConfig+extend.h"

@implementation KMPermissionConfig

+ (instancetype)configWithType:(KMPermissionType)type {
    KMPermissionConfig *config = [KMPermissionConfig new];
    config.type = type;
    return config;
}

+ (instancetype)cameraConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeCamera];
    return config;
}

+ (instancetype)photoLibrayConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypePhotoLibray];
    return config;
}

+ (instancetype)locationAlwaysConfigWithBackgroundUpdate:(BOOL)allowBackground {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeLocation];
    config.locationType = KMLocationTypeAlways;
    config.allowsBackgroundLocationUpdates = allowBackground;
    return config;
}

+ (instancetype)locationWhenInUseConfigWithBackgroundUpdate:(BOOL)allowBackground {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeLocation];
    config.locationType = KMLocationTypeWhenInUse;
    config.allowsBackgroundLocationUpdates = allowBackground;
    return config;
}

+ (instancetype)contactsConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeContacts];
    return config;
}

+ (instancetype)microphoneConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeMicrophone];
    return config;
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

+ (instancetype)remindersConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeReminders];
    return config;
}

+ (instancetype)calendarConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeCalendar];
    return config;
}

+ (instancetype)healthConfigWithReadTypes:(NSSet<HKObjectType *> *)readTypes ShareTypes:(NSSet<HKSampleType *> *)shareTypes {
    [KMPermissionConfig setReadTypes:readTypes];
    [KMPermissionConfig setShareTypes:shareTypes];
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeHealth];
    return config;
}

@end


