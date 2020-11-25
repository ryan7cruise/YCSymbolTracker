#
# Be sure to run `pod lib lint YCLaunchSymbolTracker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YCSymbolTracker'
  s.version          = '0.1.3'
  s.summary          = 'Track symbols.'
  s.homepage         = 'https://github.com/ryan7cruise/YCSymbolTracker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yuchen Peng' => 'yuchenpeng826@hotmail.com' }
  s.source           = { :git => 'https://github.com/ryan7cruise/YCSymbolTracker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.ios.source_files = 'YCSymbolTracker/*.{h,m}'
  s.ios.preserve_path = 'YCSymbolTracker/symbol_tracker.rb'

  s.ios.pod_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO'
  }
  
  s.ios.user_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO',
    'OTHER_CFLAGS' => '$(inherited) -fsanitize-coverage=func,trace-pc-guard',
    'OTHER_SWIFT_FLAGS' => '$(inherited) -sanitize=undefined -sanitize-coverage=func'
  }

end
