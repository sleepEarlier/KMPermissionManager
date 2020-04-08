//
//  KMPermissionConfig+health.m
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig+health.h"
#import <objc/runtime.h>

static NSSet<HKObjectType *> *readTypes = nil;
static NSSet<HKSampleType *> *shareTypes = nil;
@implementation KMPermissionConfig (health)

+ (void)setReadTypes:(NSSet<HKObjectType *> *)types {
    readTypes = types.copy;
}

+ (NSSet<HKObjectType *> *)readTypes {
    return readTypes;
}

+ (void)setShareTypes:(NSSet<HKSampleType *> *)types {
    shareTypes = types.copy;
}

+ (NSSet<HKSampleType *> *)shareTypes {
    return shareTypes;
}

+ (instancetype)healthConfigWithReadTypes:(NSSet<HKObjectType *> *)readTypes ShareTypes:(NSSet<HKSampleType *> *)shareTypes {
    [KMPermissionConfig setReadTypes:readTypes];
    [KMPermissionConfig setShareTypes:shareTypes];
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeHealth];
    return config;
}

@end
