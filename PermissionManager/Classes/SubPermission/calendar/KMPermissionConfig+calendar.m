//
//  KMPermissionConfig+calendar.m
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig+calendar.h"

@implementation KMPermissionConfig (calendar)

+ (instancetype)calendarConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeCalendar];
    return config;
}

@end
