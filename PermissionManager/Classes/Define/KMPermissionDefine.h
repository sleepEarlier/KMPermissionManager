//
//  KMPermissionDefine.h
//  PermissionManager
//
//  Created by 林杜波 on 2020/2/21.
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

typedef void(^KMPermissionResult)(BOOL rst);

#endif /* KMPermissionDefine_h */
