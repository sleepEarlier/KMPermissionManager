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
    [self logStatus:[KMPermissionManager cameraPermissionStatus] forCategory:@"Camera"];
    [KMPermissionManager requestCameraPermissionOnSuccess:^{
        [self logStatus:[KMPermissionManager cameraPermissionStatus] forCategory:@"Camera"];
    } failure:^(KMPermissionStatus status) {
        [self logStatus:status forCategory:@"Camera"];
    }];
}

- (IBAction)onAlbum:(id)sender {
    [self logStatus:[KMPermissionManager photoLibraryPermissionStatus] forCategory:@"PhotoLibrary"];
    [KMPermissionManager requestPhotoLibraryPermissionOnSuccess:^{
        [self logStatus:[KMPermissionManager photoLibraryPermissionStatus] forCategory:@"PhotoLibrary"];
    } failure:^(KMPermissionStatus status) {
        [self logStatus:status forCategory:@"PhotoLibrary"];
    }];
}

- (IBAction)onLocate:(id)sender {
    [self logStatus:[KMPermissionManager locationPermissionStatus] forCategory:@"Location"];
    [KMPermissionManager requestLocationPermissionWhenInUse:YES success:^{
        [self logStatus:[KMPermissionManager locationPermissionStatus] forCategory:@"Location"];
    } failre:^(KMPermissionStatus status) {
        [self logStatus:status forCategory:@"Location"];
    }];
}

- (IBAction)onContact:(id)sender {
    [self logStatus:[KMPermissionManager contactsPermissionStatus] forCategory:@"Contacts"];
    [KMPermissionManager requestContactsPermissionOnSuccess:^{
        [self logStatus:[KMPermissionManager contactsPermissionStatus] forCategory:@"Contacts"];
    } failure:^(KMPermissionStatus status) {
        [self logStatus:status forCategory:@"Contacts"];
    }];
}

- (IBAction)onMicrophone:(id)sender {
    [self logStatus:[KMPermissionManager microphonePermissionStatus] forCategory:@"Microphone"];
    [KMPermissionManager requestMicrophonePermissionOnSuccess:^{
        [self logStatus:[KMPermissionManager microphonePermissionStatus] forCategory:@"Microphone"];
    } failure:^(KMPermissionStatus status) {
        [self logStatus:status forCategory:@"Microphone"];
    }];
}

- (IBAction)onPush:(id)sender {
    [self logStatus:[KMPermissionManager notificationPermissionStatus] forCategory:@"Notification"];
    [KMPermissionManager requestNotificationPermissionOnSuccess:^{
        [self logStatus:[KMPermissionManager notificationPermissionStatus] forCategory:@"Notification"];
    } failure:^(KMPermissionStatus status) {
        [self logStatus:status forCategory:@"Notification"];
    }];
}

- (void)logStatus:(KMPermissionStatus)status forCategory:(NSString *)category {
    NSLog(@"%@ permission status:%@", category, @(status));
}

@end
