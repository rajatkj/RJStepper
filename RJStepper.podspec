#
# Be sure to run `pod lib lint RJStepper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RJStepper'
  s.version          = '0.1.0'
  s.summary          = 'A stepper control with a label in between to show the current value.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "A stepper control with a label in between to show the current value. It has a label in between to show the value"

  s.homepage         = 'https://github.com/rico9260/RJStepper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rico9260' => 'rajat.zangra@gmail.com' }
  s.source           = { :git => 'https://github.com/rico9260/RJStepper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'RJStepper/**/*'
  
  # s.resource_bundles = {
  #   'RJStepper' => ['RJStepper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
