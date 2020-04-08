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

#import "KMCameraPermission.h"
#import "KMContactsPermission.h"
#import "KMMicrophonePermission.h"
#import "KMPhotoLibrayPermission.h"
#import "KMPermissionDefine.h"
#import "KMPermissionProtocol.h"
#import "KMPermissionConfig.h"
#import "KMPermissionManager.h"
#import "KMCalendarPermission.h"
#import "KMPermissionConfig+calendar.h"
#import "KMHealthPermission.h"
#import "KMPermissionConfig+health.h"
#import "KMLocationPermission.h"
#import "KMPermissionConfig+location.h"
#import "KMNotificationPermission.h"
#import "KMPermissionConfig+notification.h"
#import "KMPermissionConfig+reminder.h"
#import "KMRemindersPermission.h"

FOUNDATION_EXPORT double KMPermissionManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char KMPermissionManagerVersionString[];

