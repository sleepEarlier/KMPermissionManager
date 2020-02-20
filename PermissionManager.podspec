#
# Be sure to run `pod lib lint PermissionManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PermissionManager'
  s.version          = '1.0.0'
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
  s.source           = { :git => 'https://github.com/sleepEarlier/KMPermissionManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :iOS, '9.0'

  s.source_files = 'PermissionManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PermissionManager' => ['PermissionManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'AVFoundation', 'Photos', 'CoreLocation', 'CoreTelephony', 'Contacts'
  # s.dependency 'AFNetworking', '~> 2.3'
end
