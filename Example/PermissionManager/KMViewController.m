//
//  KMViewController.m
//  PermissionManager
//
//  Created by jky130@qq.com on 02/19/2020.
//  Copyright (c) 2020 jky130@qq.com. All rights reserved.
//

#import "KMViewController.h"
#import <KMPermissionManager.h>

@interface KMViewController ()

@end

@implementation KMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onCamera:(id)sender {
    [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeCamera] forCategory:@"Camera"];
    [KMPermissionManager requestPermission:[KMPermissionConfig cameraConfig] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeCamera] forCategory:@"Camera"];
    }];
}

- (IBAction)onAlbum:(id)sender {
    [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypePhotoLibray] forCategory:@"PhotoLibrary"];
    [KMPermissionManager requestPermission:[KMPermissionConfig photoLibrayConfig] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypePhotoLibray] forCategory:@"PhotoLibrary"];
    }];
}

- (IBAction)onLocate:(id)sender {
    [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeLocation] forCategory:@"Location"];
    KMPermissionConfig *config = [KMPermissionConfig locationWhenInUseConfigWithBackgroundUpdate:NO];
    [KMPermissionManager requestPermission:config complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeLocation] forCategory:@"Location"];
    }];
}

- (IBAction)onContact:(id)sender {
    [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeContacts] forCategory:@"Contacts"];
    [KMPermissionManager requestPermission:[KMPermissionConfig contactsConfig] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeContacts] forCategory:@"Contacts"];
    }];
}

- (IBAction)onMicrophone:(id)sender {
    [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeMicrophone] forCategory:@"Microphone"];
    [KMPermissionManager requestPermission:[KMPermissionConfig microphoneConfig] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeMicrophone] forCategory:@"Microphone"];
    }];
}

- (IBAction)onPush:(id)sender {
    [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeNotification] forCategory:@"Notification"];
    
    KMPermissionConfig *config;
    
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions option = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        config = [KMPermissionConfig notificationConfigWithOptions:option];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert categories:nil];
        config = [KMPermissionConfig notificationConfigWithSettings:settings];
    }
    
    
    [KMPermissionManager requestPermission:config complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeNotification] forCategory:@"Notification"];
    }];
}

- (IBAction)onHealth:(id)sender {
    NSSet<HKObjectType *> *readTypes = [NSSet setWithObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    NSSet<HKSampleType *> *shareTypes = [NSSet setWithObject:[HKSampleType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    KMPermissionConfig *config = [KMPermissionConfig healthConfigWithReadTypes:readTypes ShareTypes:shareTypes];
    
    [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeHealth] forCategory:@"healthKit"];
    
    [KMPermissionManager requestPermission:config complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager unifyStatusForPermission:KMPermissionTypeHealth] forCategory:@"healthKit"];
    }];
}
- (IBAction)onOpenSetting:(id)sender {
    [KMPermissionManager openSettingsComplete:^(BOOL rst) {
        NSLog(@"open setting:%@",@(rst));
    }];
}

- (void)logStatus:(KMPermissionStatus)status forCategory:(NSString *)category {
    NSLog(@"%@ permission status:%@", category, @(status));
}

@end
