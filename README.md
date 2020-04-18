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
| PhotoLibrary  | ✅       |
| Camera       | ✅       |

CellularData Monitor is supported too. The library Provide unify request method and permission status.

Core spec (default spec) contain Camera、PhotoLibrary、Microphone、Contacts permissions, to include other permissions, pod subspec like `calandar`、`reminder`.


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
   // NotDetermined、Restricted、Denied、Authorized
   + (KMPermissionStatus)unifyStatusForPermission:(KMPermissionType)type;
   ```
   
   

2. Get raw permission status value, like `CNAuthorizationStatus`、`AVAuthorizationStatus`...
   
   ```objectivec
   + (NSInteger)rawStatusForPermission:(KMPermissionType)type;
   ```
   
   



To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PermissionManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
# use default spec
pod 'KMPermissionManager', '~> 2.4.0'

# also calendar、reminder
pod 'KMPermissionManager', '~> 2.4.0', :subspecs => ['calendar', 'reminder']
```

## Author

Usopp

## License

KMPermissionManager is available under the MIT license. See the LICENSE file for more info.
