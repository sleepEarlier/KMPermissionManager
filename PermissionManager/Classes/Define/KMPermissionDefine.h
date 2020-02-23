//
//  KMPermissionDefine.h
//  PermissionManager
//
//  Created by usopp on 2020/2/21.
//

#ifndef KMPermissionDefine_h
#define KMPermissionDefine_h

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
