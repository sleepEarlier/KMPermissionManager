//
//  KMPermissionConfig+health.h
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig.h"
#import <HealthKit/HealthKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMPermissionConfig (health)

/// 健康权限类型
+ (void)setReadTypes:(NSSet<HKObjectType *> *)types;

+ (NSSet<HKObjectType *> *)readTypes;

+ (void)setShareTypes:(NSSet<HKSampleType *> *)shareTypes;

+ (NSSet<HKSampleType *> *)shareTypes;

+ (instancetype)healthConfigWithReadTypes:(NSSet<HKObjectType *> *)readTypes ShareTypes:(NSSet<HKSampleType *> *)shareTypes;
@end

NS_ASSUME_NONNULL_END
