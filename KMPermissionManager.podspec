#
# Be sure to run `pod lib lint PermissionManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KMPermissionManager'
  s.version          = '3.0.0'
  s.summary          = 'A tool help to handle permission stuff on iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A simple tool help to handle permiss stuff on iOS, with unify permission status.
                       DESC

  s.homepage         = 'https://github.com/sleepEarlier/KMPermissionManager.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jky130@qq.com' => 'sleepEarlier' }
  s.source           = { :git => 'https://github.com/sleepEarlier/KMPermissionManager.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios, '9.0'

#  s.source_files = "PermissionManager/Classes/Core/**/*"
  
  # s.resource_bundles = {
  #   'PermissionManager' => ['PermissionManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
#  s.frameworks = 'UIKit', 'Foundation', 'AVFoundation', 'Photos', 'CoreLocation', 'CoreTelephony', 'Contacts', 'HealthKit'
  s.frameworks = 'UIKit', 'Foundation', 'AVFoundation', 'Photos', 'CoreTelephony', 'Contacts'
  
  s.subspec 'Core' do |core|
    core.source_files = "PermissionManager/Classes/Core/**/*"
  end
  
  s.subspec 'calendar' do |calendar|
    calendar.source_files = "PermissionManager/Classes/SubPermission/calendar/*"
    calendar.frameworks = 'EventKit'
    calendar.dependency 'KMPermissionManager/Core'
  end
  
  s.subspec 'health' do |health|
    health.source_files = "PermissionManager/Classes/SubPermission/health/*"
    health.frameworks = 'HealthKit'
    health.dependency 'KMPermissionManager/Core'
  end
  
  s.subspec 'location' do |location|
    location.source_files = "PermissionManager/Classes/SubPermission/location/*"
    location.frameworks = 'CoreLocation'
    location.dependency 'KMPermissionManager/Core'
  end
  
  s.subspec 'notification' do |notification|
    notification.source_files = "PermissionManager/Classes/SubPermission/notification/*"
    notification.frameworks = 'UserNotifications'
    notification.dependency 'KMPermissionManager/Core'
  end
  
  s.subspec 'reminder' do |reminder|
    reminder.source_files = "PermissionManager/Classes/SubPermission/reminder/*"
    reminder.frameworks = 'EventKit'
    reminder.dependency 'KMPermissionManager/Core'
  end
end
