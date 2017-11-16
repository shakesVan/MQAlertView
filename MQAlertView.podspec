#
# Be sure to run `pod lib lint MQAlertView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MQAlertView'
  s.version          = '0.1.1'
  s.summary          = 'A simple customizable alertView that displays text, input boxes and pictures'

  s.homepage         = 'https://github.com/xiaoyao250/MQAlertView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaoyao250' => 'xiaoyao250' }
  s.source           = { :git => 'https://github.com/xiaoyao250/MQAlertView.git', :tag => s.version.to_s }
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.source_files = 'MQAlertView/Classes/**/*'
  s.framework = 'UIKit', 'Foundation'
  s.pod_target_xcconfig = { "SWIFT_VERSION" => "4.0" }

  s.requires_arc = true
end
