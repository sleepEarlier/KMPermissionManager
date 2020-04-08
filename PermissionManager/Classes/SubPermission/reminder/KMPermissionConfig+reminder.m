//
//  KMPermissionConfig+reminder.m
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig+reminder.h"

@implementation KMPermissionConfig (reminder)

+ (instancetype)remindersConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeReminders];
    return config;
}

@end
