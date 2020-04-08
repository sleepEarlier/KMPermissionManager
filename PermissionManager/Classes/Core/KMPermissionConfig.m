//
//  KMPermissionConfig.m
//  KMPermissionManager
//
//  Created by usopp on 2020/2/21.
//

#import "KMPermissionConfig.h"

@implementation KMPermissionConfig

+ (instancetype)configWithType:(KMPermissionType)type {
    KMPermissionConfig *config = [KMPermissionConfig new];
    config.type = type;
    return config;
}

+ (instancetype)cameraConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeCamera];
    return config;
}

+ (instancetype)photoLibrayConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypePhotoLibray];
    return config;
}

+ (instancetype)contactsConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeContacts];
    return config;
}

+ (instancetype)microphoneConfig {
    KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeMicrophone];
    return config;
}

@end


