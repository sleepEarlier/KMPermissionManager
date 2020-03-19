//
//  KMLocationPermission.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMLocationPermission.h"
#import <CoreLocation/CoreLocation.h>
#import "KMPermissionConfig.h"
#import "KMPermissionConfig+extend.h"

@interface KMLocationPermission () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) KMPermissionResult completion;

@end

@implementation KMLocationPermission

+ (CLAuthorizationStatus)status {
    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
    return locationStatus;
}

+ (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type {
    CLAuthorizationStatus status = [self status];
    if (status >= kCLAuthorizationStatusAuthorizedAlways) {
        return KMPermissionStatusAuthorized;
    }
    return (KMPermissionType)status;
}

+ (NSInteger)rawStatusForPermission:(KMPermissionType)type {
    return [self status];
}

/// 是否未请求过权限
+ (BOOL)isNotDeterminedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == kCLAuthorizationStatusNotDetermined);
    return rst;
}

/// 是否已授权
+ (BOOL)isAuthorizedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == kCLAuthorizationStatusAuthorizedAlways) || ([self status] == kCLAuthorizationStatusAuthorizedWhenInUse);
    return rst;
}

/// 是否已拒绝或设备被禁用
+ (BOOL)isRestrictedOrDeniedForPermission:(KMPermissionType)type {
    BOOL rst = ([self status] == kCLAuthorizationStatusRestricted) || ([self status] == kCLAuthorizationStatusDenied);
    return rst;
}

/// 请求权限
+ (void)requestPermission:(KMPermissionConfig *)config complete:(KMPermissionResult)completion {
    if ([self isNotDeterminedForPermission:config.type]) {
        KMLocationPermission *permission = [self sharedInstace];
        permission.completion = completion;
        permission.manager = [CLLocationManager new];
        if (completion) {
            permission.manager.delegate = permission;
        }
        
        if (config.allowsBackgroundLocationUpdates) {
            // 需要设置工程Capabilities\InfoPlist
            permission.manager.allowsBackgroundLocationUpdates = YES;
        }
        
        if (config.locationType == KMLocationTypeAlways) {
            [permission.manager requestAlwaysAuthorization];
        }
        else if (config.locationType == KMLocationTypeWhenInUse) {
            [permission.manager requestWhenInUseAuthorization];
        }
    }
    else if ([self isAuthorizedForPermission:config.type]) {
        if (completion) {
            completion(YES);
        }
    }
    else if (completion) {
        completion(NO);
    }
}

#pragma mark - Shared Instance
+ (instancetype)sharedInstaceDispose:(BOOL)dispose
{
    static KMLocationPermission *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KMLocationPermission alloc] init];
    });
    if (dispose) {
        instance = nil;
        onceToken = 0;
    }
    return instance;
}

+ (instancetype)sharedInstace {
    return [self sharedInstaceDispose:NO];
}

+ (void)dispose {
    [self sharedInstaceDispose:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)locationStatus {
    // 请求权限后会立刻回调，过滤掉此种情况
    if (locationStatus == kCLAuthorizationStatusNotDetermined) {
        return;
    }
    BOOL granted = (locationStatus == kCLAuthorizationStatusAuthorizedAlways) || (locationStatus == kCLAuthorizationStatusAuthorizedWhenInUse);
    if (self.completion) {
        self.completion(granted);
    }
    manager.delegate = nil;
    [KMLocationPermission dispose];
}

@end
