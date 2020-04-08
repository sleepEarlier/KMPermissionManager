//
//  KMPermissionConfig+location.h
//  KMPermissionManager
//
//  Created by 林杜波 on 2020/4/8.
//

#import "KMPermissionConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KMLocationType) {
    KMLocationTypeWhenInUse,
    KMLocationTypeAlways
};

@interface KMPermissionConfig (location)

/// 定位权限类型
@property (nonatomic, assign) KMLocationType locationType;

/// 是否允许后台定位（使用时请同时修改工程配置\Info.plist）
@property (nonatomic, assign) BOOL allowsBackgroundLocationUpdates;

+ (instancetype)locationAlwaysConfigWithBackgroundUpdate:(BOOL)allowBackground;
+ (instancetype)locationWhenInUseConfigWithBackgroundUpdate:(BOOL)allowBackground;

@end

NS_ASSUME_NONNULL_END
