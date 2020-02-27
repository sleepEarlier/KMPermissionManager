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

// factory
+ (instancetype)cameraConfig;
+ (instancetype)photoLibrayConfig;
+ (instancetype)locationAlwaysConfigWithBackgroundUpdate:(BOOL)allowBackground;
+ (instancetype)locationWhenInUseConfigWithBackgroundUpdate:(BOOL)allowBackground;
+ (instancetype)contactsConfig;
+ (instancetype)microphoneConfig;
+ (instancetype)notificationConfigWithOptions:(UNAuthorizationOptions)options API_AVAILABLE(ios(10.0));
+ (instancetype)notificationConfigWithSettings:(UIUserNotificationSettings *)settings;
+ (instancetype)remindersConfig;
+ (instancetype)calendarConfig;
+ (instancetype)healthConfigWithReadTypes:(NSSet<HKObjectType *> *)readTypes ShareTypes:(NSSet<HKSampleType *> *)shareTypes;

@end

NS_ASSUME_NONNULL_END
