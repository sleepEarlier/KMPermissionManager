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
    [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeCamera] forCategory:@"Camera"];
    [KMPermissionManager requestPermission:[KMPermissionConfig configWithType:KMPermissionTypeCamera] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeCamera] forCategory:@"Camera"];
    }];
}

- (IBAction)onAlbum:(id)sender {
    [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypePhotoLibray] forCategory:@"PhotoLibrary"];
    [KMPermissionManager requestPermission:[KMPermissionConfig configWithType:KMPermissionTypePhotoLibray] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypePhotoLibray] forCategory:@"PhotoLibrary"];
    }];
}

- (IBAction)onLocate:(id)sender {
    [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeLocation] forCategory:@"Location"];
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeLocation];
    config.locationType = KMLocationTypeAlways;
    config.allowsBackgroundLocationUpdates = NO;
    [KMPermissionManager requestPermission:config complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeLocation] forCategory:@"Location"];
    }];
}

- (IBAction)onContact:(id)sender {
    [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeContacts] forCategory:@"Contacts"];
    [KMPermissionManager requestPermission:[KMPermissionConfig configWithType:KMPermissionTypeContacts] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeContacts] forCategory:@"Contacts"];
    }];
}

- (IBAction)onMicrophone:(id)sender {
    [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeMicrophone] forCategory:@"Microphone"];
    [KMPermissionManager requestPermission:[KMPermissionConfig configWithType:KMPermissionTypeMicrophone] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeMicrophone] forCategory:@"Microphone"];
    }];
}

- (IBAction)onPush:(id)sender {
    [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeNotification] forCategory:@"Notification"];
    
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeNotification];
    
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions option = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        config.options = option;
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert categories:nil];
        config.settings = settings;
    }
    
    
    [KMPermissionManager requestPermission:config complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeNotification] forCategory:@"Notification"];
    }];
}

- (IBAction)onHealth:(id)sender {
    NSSet<HKObjectType *> *types = [NSSet setWithObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    [KMPermissionConfig setObjectTypes:types];
    
    [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeHealth] forCategory:@"Notification"];
    
    [KMPermissionManager requestPermission:[KMPermissionConfig configWithType:KMPermissionTypeHealth] complete:^(BOOL rst) {
        [self logStatus:[KMPermissionManager rawStatusForPermission:KMPermissionTypeHealth] forCategory:@"Notification"];
    }];
}

- (void)logStatus:(KMPermissionStatus)status forCategory:(NSString *)category {
    NSLog(@"%@ permission status:%@", category, @(status));
}

@end
