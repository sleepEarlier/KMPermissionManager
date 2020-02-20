//
//  KMPermissionManager.m
//  KMPermissionManager
//
//  Created by Kimi on 2019/12/22.
//  Copyright © 2019年 Kimi. All rights reserved.
//

#import "KMPermissionManager.h"

/// 蜂窝网络数据权限改变通知
NSString * const KMCellularDataPermissionDidChangedNotification = @"KMCellularDataPermissionDidChangedNotification";
NSString * const KMCellularDataRestrictedStateUserInfoKey = @"KMCellularDataRestrictedStateUserInfoKey";


@interface KMPermissionManager()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>

@property (nonatomic, copy) void (^locationSuccess)(void);
@property (nonatomic, copy) void (^locationFailure)(KMPermissionStatus);
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

static id staticCellularData = nil;

@implementation KMPermissionManager

#pragma mark - Shared Instance
+ (KMPermissionManager *)sharedInstaceDispose:(BOOL)dispose
{
    static KMPermissionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KMPermissionManager alloc] init];
    });
    if (dispose) {
        instance = nil;
        onceToken = 0;
    }
    return instance;
}

+ (KMPermissionManager *)sharedInstace {
    return [self sharedInstaceDispose:NO];
}

+ (void)dispose {
    [self sharedInstaceDispose:YES];
}

#pragma mark - 相机权限
+ (KMPermissionStatus)cameraPermissionStatus {
    AVAuthorizationStatus avStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    KMPermissionStatus status = [self statusFromAVAuthorizationStatus:avStatus];
    return status;
}

+ (void)requestCameraPermissionOnSuccess:(void(^)(void))success failure:(void(^)(KMPermissionStatus sts))failure {
    KMPermissionStatus authStatus = [self cameraPermissionStatus];
    if (authStatus == KMPermissionStatusRestricted || authStatus == KMPermissionStatusDenied) {
        if (failure) {
            failure(authStatus);
        }
    }
    else if (authStatus == KMPermissionStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (success) {
                        success();
                    }
                }
                else {
                    if (failure) {
                        failure(KMPermissionStatusDenied);
                    }
                }
            });
        }];
    }
    else {
        if (success) {
            success();
        }
    }
}

#pragma mark - 相册权限
+ (KMPermissionStatus)photoLibraryPermissionStatus {
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    KMPermissionStatus status = [self statusFromPHAuthorizationStatus:photoStatus];
    return status;
}

+ (void)requestPhotoLibraryPermissionOnSuccess:(void(^)(void))success failure:(void(^)(KMPermissionStatus sts))failure {
    KMPermissionStatus phStatus = [self photoLibraryPermissionStatus];
    if (phStatus == KMPermissionStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                KMPermissionStatus newStatus = [self statusFromPHAuthorizationStatus:status];
                if (newStatus == KMPermissionStatusAuthorized) {
                    if (success) {
                        success();
                    }
                }
                else if (failure) {
                    failure(newStatus);
                }
            });
        }];
    }
    else if (phStatus == KMPermissionStatusAuthorized) {
        if (success) {
            success();
        }
    }
    else if (failure) {
        failure(phStatus);
    }
}

#pragma mark - 定位权限
+ (KMPermissionStatus)locationPermissionStatus {
    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
    KMPermissionStatus status = [self statusFromCLAuthorizationStatus:locationStatus];
    return status;
}

+ (void)requestLocationPermissionWhenInUse:(BOOL)onlyWhenInUse success:(void(^)(void))success failre:(void(^)(KMPermissionStatus status))failure {
    KMPermissionStatus status = [self locationPermissionStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        KMPermissionManager *pm = [self sharedInstace];
        pm.locationSuccess = success;
        pm.locationFailure = failure;
        CLLocationManager *lm = [CLLocationManager new];
        lm.delegate = pm;
        pm.locationManager = lm;
        if (@available(iOS 8, *)) {
            if (onlyWhenInUse) {
                [lm requestWhenInUseAuthorization];
            } else {
                [lm requestAlwaysAuthorization];
            }
        } else {
            [lm startUpdatingHeading]; // call any api to trigger the warning dialog
        }
    }
    else if (status >= kCLAuthorizationStatusAuthorizedAlways) {
        if (success) {
            success();
        }
    }
    else {
        if (failure) {
            failure(status);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)locationStatus {
    // 请求权限后会立刻回调，过滤掉此种情况
    if (locationStatus == kCLAuthorizationStatusNotDetermined) {
        return;
    }
    if (locationStatus == kCLAuthorizationStatusAuthorizedAlways || locationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        if (self.locationSuccess) {
            self.locationSuccess();
        } else {
            if (self.locationFailure) {
                KMPermissionStatus status = [KMPermissionManager statusFromCLAuthorizationStatus:locationStatus];
                self.locationFailure(status);
            }
        }
    }
    manager.delegate = nil;
    [KMPermissionManager dispose];
}

#pragma mark - 通讯录权限
+ (KMPermissionStatus)contactsPermissionStatus API_AVAILABLE(ios(9.0)){
    CNAuthorizationStatus contackStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    KMPermissionStatus status = [self statusFromCNAuthorizationStatus:contackStatus];
    return status;
}

+ (void)requestContactsPermissionOnSuccess:(void (^)(void))success failure:(void (^)(KMPermissionStatus))failure API_AVAILABLE(ios(9.0)){
    KMPermissionStatus status = [self contactsPermissionStatus];
    if (status == KMPermissionStatusAuthorized) {
        if (success) {
            success();
        }
    }
    else if (status == KMPermissionStatusNotDetermined) {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (success) {
                        success();
                    }
                }
                else if (failure) {
                    failure([self contactsPermissionStatus]);
                }
            });
        }];
    }
    else {
        if (failure) {
            failure(status);
        }
    }
}

#pragma mark - 麦克风权限
+ (KMPermissionStatus)microphonePermissionStatus {
    AVAuthorizationStatus avStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    KMPermissionStatus status = [self statusFromAVAuthorizationStatus:avStatus];
    return status;
}

+ (void)requestMicrophonePermissionOnSuccess:(void(^)(void))success failure:(void(^)(KMPermissionStatus sts))failure {
    KMPermissionStatus authStatus = [self microphonePermissionStatus];
    if (authStatus == KMPermissionStatusRestricted || authStatus == KMPermissionStatusDenied) {
        if (failure) {
            failure(authStatus);
        }
    }
    else if (authStatus == KMPermissionStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (success) {
                        success();
                    }
                }
                else {
                    if (failure) {
                        failure(KMPermissionStatusDenied);
                    }
                }
            });
        }];
    }
    else {
        if (success) {
            success();
        }
    }
}


#pragma mark - 推送权限
+ (KMPermissionStatus)notificationPermissionStatus {
    if (@available(iOS 10.0, *)) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block KMPermissionStatus status;
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            status = [self statusFromUNAuthorizationStatus:settings.authorizationStatus];
           dispatch_semaphore_signal(sema);
        }];

        if (![NSThread isMainThread]) {
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        } else {
            while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0]];
            }
        }

#if !__has_feature(objc_arc)
        dispatch_release(sema);
#endif
        return status;
    } else {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (!setting) {
            return KMPermissionStatusNotDetermined;
        }
        BOOL enable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
        KMPermissionStatus status = enable ? KMPermissionStatusAuthorized : KMPermissionStatusDenied;
        return status;
    }
}

+ (void)requestNotificationPermissionOnSuccess:(void (^)(void))success failure:(void (^)(KMPermissionStatus))failure {
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (success) {
                        success();
                    }
                } else if (failure){
                    failure(KMPermissionStatusDenied);
                }
            });
        }];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
}

#pragma mark - 网络权限状态

// 开始监听蜂窝网络数据权限变化
+ (void)startMonitorCellularDataPermissionChanged API_AVAILABLE(ios(9.0)){
    
    if (@available(iOS 9, *)) {
        staticCellularData = [[CTCellularData alloc] init];
        CTCellularData *cellular = staticCellularData;
        cellular.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [NSNotificationCenter.defaultCenter postNotificationName:KMCellularDataPermissionDidChangedNotification object:@(state) userInfo:@{KMCellularDataRestrictedStateUserInfoKey: @(state)}];
            });
        };
    }
}

// 停止监听蜂窝网络数据权限变化
+ (void)stopMonitorCellularDataPermissionChanged API_AVAILABLE(ios(9.0)){
    ((CTCellularData *)staticCellularData).cellularDataRestrictionDidUpdateNotifier = nil;
    staticCellularData = nil;
}

+ (KMPermissionStatus)cellularDataRestrictedState API_AVAILABLE(ios(9.0)){
    
    if (@available(iOS 9, *)) {
        CTCellularDataRestrictedState cellularState = ((CTCellularData *)staticCellularData).restrictedState;
        KMPermissionStatus status = [self statusFromCellularDataRestrictedState:cellularState];
        return status;
    } else {
        return KMPermissionStatusAuthorized;
    }
}

#pragma mark - Helper
+(KMPermissionStatus)statusFromCellularDataRestrictedState:(CTCellularDataRestrictedState)status {
    KMPermissionStatus st = KMPermissionStatusNotDetermined;
    if (status == kCTCellularDataRestricted) {
        st = KMPermissionStatusDenied;
    }
    else if (status == kCTCellularDataNotRestricted) {
        st = KMPermissionStatusAuthorized;
    }
    return st;
}

+(KMPermissionStatus)statusFromAVAuthorizationStatus:(AVAuthorizationStatus)status {
    return (KMPermissionStatus)status;
}

+(KMPermissionStatus)statusFromPHAuthorizationStatus:(PHAuthorizationStatus)status {
    return (KMPermissionStatus)status;
}

+(KMPermissionStatus)statusFromCLAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status >= kCLAuthorizationStatusAuthorizedAlways) {
        return KMPermissionStatusAuthorized;
    }
    return (KMPermissionStatus)status;
}

+(KMPermissionStatus)statusFromCNAuthorizationStatus:(CNAuthorizationStatus)status API_AVAILABLE(ios(9.0)){
    return (KMPermissionStatus)status;
}

+(KMPermissionStatus)statusFromUNAuthorizationStatus:(NSInteger)status {
    if (@available(iOS 10.0, *)) {
        if (status >= UNAuthorizationStatusAuthorized) {
            return KMPermissionStatusAuthorized;
        }
        return (KMPermissionStatus)status;
    } else {
        return KMPermissionStatusNotDetermined;
    }
}

@end
