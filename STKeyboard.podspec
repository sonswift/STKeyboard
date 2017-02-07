#
# Be sure to run `pod lib lint STKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'STKeyboard'
  s.version          = '0.0.1'
  s.summary          = 'STKeyboard is the best way to use or create a new keyboard for your application.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
STKeyboard supports 2 new kinds of keyboard: Number keyboard and Photo keyboard.
You can create a new keyboard for your application easier.
Available in Swift and xCode 8.0 or higher.
                       DESC

  s.homepage         = 'https://github.com/son11592/STKeyboard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Son Thai' => 'hoangson11592@gmail.com' }
  s.source           = { :git => 'https://github.com/son11592/STKeyboard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'STKeyboard/**/*'
  
  # s.resource_bundles = {
  #   'STKeyboard' => ['STKeyboard/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
