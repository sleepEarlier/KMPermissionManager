//
//  KMPermissionDefine.h
//  PermissionManager
//
//  Created by 林杜波 on 2020/2/21.
//

#ifndef KMPermissionDefine_h
#define KMPermissionDefine_h

typedef NS_ENUM(NSInteger, KMPermissionStatus) {
    KMPermissionStatusNotDetermined = 0,
    KMPermissionStatusRestricted    = 1,
    KMPermissionStatusDenied        = 2,
    KMPermissionStatusAuthorized    = 3,
};

typedef NS_ENUM(NSInteger, KMPermissionType) {
    KMPermissionTypeCamera,
    KMPermissionTypePhotoLibray,
    KMPermissionTypeLocationWhenInUse,
    KMPermissionTypeLocationAlways,
    KMPermissionTypeLocationWithBackground,
    KMPermissionTypeContacts,
    KMPermissionTypeMicrophone,
    KMPermissionTypeNotification,
    KMPermissionTypeReminders,
    KMPermissionTypeCalandar,
    // TODO: 健康权限
};

typedef void(^KMPermissionResult)(BOOL rst);

#endif /* KMPermissionDefine_h */
