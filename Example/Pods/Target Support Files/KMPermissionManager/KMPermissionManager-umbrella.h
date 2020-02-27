#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KMPermissionDefine.h"
#import "KMPermissionProtocol.h"
#import "KMPermissionConfig+extend.h"
#import "KMPermissionConfig.h"
#import "KMPermissionManager.h"
#import "KMCalandarPermission.h"
#import "KMCameraPermission.h"
#import "KMContactsPermission.h"
#import "KMHealthPermission.h"
#import "KMLocationPermission.h"
#import "KMMicrophonePermission.h"
#import "KMNotificationPermission.h"
#import "KMPhotoLibrayPermission.h"
#import "KMRemindersPermission.h"

FOUNDATION_EXPORT double KMPermissionManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char KMPermissionManagerVersionString[];

