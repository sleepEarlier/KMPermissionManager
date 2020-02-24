//
//  KMPermissionConfig.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMPermissionConfig.h"
#import <objc/runtime.h>

@implementation KMPermissionConfig

+ (instancetype)configWithType:(KMPermissionType)type {
    KMPermissionConfig *config = [KMPermissionConfig new];
    config.type = type;
    return config;
}

@end

@implementation KMPermissionConfig (location)

- (KMLocationType)locationType {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setLocationType:(KMLocationType)locationType {
    objc_setAssociatedObject(self, @selector(locationType), @(locationType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)allowsBackgroundLocationUpdates {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAllowsBackgroundLocationUpdates:(BOOL)allowsBackgroundLocationUpdates {
    objc_setAssociatedObject(self, @selector(allowsBackgroundLocationUpdates), @(allowsBackgroundLocationUpdates), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

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

@end

static NSSet<HKObjectType *> *readTypes = nil;
static NSSet<HKSampleType *> *shareTypes = nil;
@implementation KMPermissionConfig (health)

+ (void)setReadTypes:(NSSet<HKObjectType *> *)types {
    readTypes = types.copy;
}

+ (NSSet<HKObjectType *> *)readTypes {
    return readTypes;
}

+ (void)setShareTypes:(NSSet<HKSampleType *> *)types {
    shareTypes = types.copy;
}

+ (NSSet<HKSampleType *> *)shareTypes {
    return shareTypes;
}

@end
