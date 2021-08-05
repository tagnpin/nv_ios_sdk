#
# Be sure to run `pod lib lint notifyvisitors.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'notifyvisitors'
  s.version          = '6.1.0'
  s.summary          = 'Best multi channel Customer Engagement Software for Your Business'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Notifyvisitors is simplest marketing automation software to send personalised push. Trusted by 6000+ Customers and it is the best multi channel Customer Engagement Software for Your Business notifications and messages to customers. it is a Marketing Automation Software with AI and Machine learning powered Personalisation, Segmentation, Omnichannel and Cross-Device Customer Engagement, Conversion rate optimization and Analytics Software. Multi Channels. Multi Platforms.
                       DESC

  s.homepage         = 'https://github.com/tagnpin/nv_ios_sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mohammad Ashraf Ali' => 'ashraf@notifyvisitors.com' }
  s.source           = { :git => 'https://github.com/tagnpin/nv_ios_sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.source_files = 'notifyvisitors/Classes/**/*.h'
  s.resources = ['notifyvisitors/Assets/**/*.png', 'notifyvisitors/Classes/nvResourceValues.plist']
  s.vendored_library = 'notifyvisitors/Classes/**/*.a'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
end
