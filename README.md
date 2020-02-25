# PermissionManager

[![CI Status](https://img.shields.io/badge/build-passing-brightgreen)](https://travis-ci.org/jky130@qq.com/PermissionManager)
[![Version](https://img.shields.io/badge/pod-1.0.0-brightgreen)](https://cocoapods.org/pods/PermissionManager)
[![License](https://img.shields.io/badge/license-MIT-green)](https://cocoapods.org/pods/PermissionManager)
[![Platform](https://img.shields.io/badge/platform-iOS%209.0%2B-brightgreen)](https://cocoapods.org/pods/PermissionManager)



## Support

 

| Permission   | support |
| ------------ |:-------:|
| HealthKit    | ✅       |
| Calendar     | ✅       |
| Reminder     | ✅       |
| Notification | ✅       |
| Microphone   | ✅       |
| Contacts     | ✅       |
| Location     | ✅       |
| PhotoLibray  | ✅       |
| Camera       | ✅       |

CellularData Monitor is supported.

Provide unify request method and permission status.

## Example

##### Request permissions:

```objectivec
// request camera permission
[KMPermissionManager requestPermission:[KMPermissionConfig configWithType:KMPermissionTypeCamera] complete:^(BOOL rst) {
    // handle permisstion result
 }];
```



```objectivec
// request location manager
KMPermissionConfig *config = [KMPermissionConfig configWithType:KMPermissionTypeLocation];
// setup options
config.locationType = KMLocationTypeAlways;
config.allowsBackgroundLocationUpdates = NO;

[KMPermissionManager requestPermission:config complete:^(BOOL rst) {
    // handle permisstion result
}];
```



##### Fetch permission status

1. Unify permission status value (`KMPermissionStatus`)
   
   ```objectivec
   + (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type;
   ```
   
   

2. Raw permission status value, like `CNAuthorizationStatus`、`AVAuthorizationStatus`...
   
   ```objectivec
   + (NSInteger)rawStatusForPermission:(KMPermissionType)type;
   ```
   
   



To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PermissionManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PermissionManager'
```

## Author

Usopp

## License

PermissionManager is available under the MIT license. See the LICENSE file for more info.
