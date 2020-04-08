//
//  KMPermissionConfig.h
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import <Foundation/Foundation.h>
#import "KMPermissionDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface KMPermissionConfig : NSObject

+ (instancetype)configWithType:(KMPermissionType)type;

@property (nonatomic, assign) KMPermissionType type;

// factory
+ (instancetype)cameraConfig;
+ (instancetype)photoLibrayConfig;
+ (instancetype)contactsConfig;
+ (instancetype)microphoneConfig;

@end

NS_ASSUME_NONNULL_END
