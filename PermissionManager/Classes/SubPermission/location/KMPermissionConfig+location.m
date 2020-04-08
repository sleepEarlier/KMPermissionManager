//
//  KMPermissionConfig+location.m
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig+location.h"
#import <objc/runtime.h>

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

@end
