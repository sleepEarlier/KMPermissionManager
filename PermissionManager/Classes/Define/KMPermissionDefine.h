//
//  KMPermissionDefine.h
//  PermissionManager
//
//  Created by usopp on 2020/2/21.
//

#ifndef KMPermissionDefine_h
#define KMPermissionDefine_h

/// 蜂窝网络数据权限改变通知
extern NSString * const KMCellularDataPermissionDidChangedNotification;
extern NSString * const KMCellularDataRestrictedStateUserInfoKey;

typedef NS_ENUM(NSInteger, KMPermissionType) {
    KMPermissionTypeCamera,
    KMPermissionTypePhotoLibray,
    KMPermissionTypeLocation,
    KMPermissionTypeContacts,
    KMPermissionTypeMicrophone,
    KMPermissionTypeNotification,
    KMPermissionTypeReminders,
    KMPermissionTypeCalandar,
    KMPermissionTypeHealth
};

typedef NS_ENUM(NSUInteger, KMPermissionStatus) {
    KMPermissionStatusNotDetermined = 0,
    KMPermissionStatusRestricted,
    KMPermissionStatusDenied,
    KMPermissionStatusAuthorized
};

typedef void(^KMPermissionResult)(BOOL rst);

#endif /* KMPermissionDefine_h */
