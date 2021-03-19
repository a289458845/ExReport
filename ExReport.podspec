#
# Be sure to run `pod lib lint ExReport.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'ExReport'
    s.version          = '0.1.2'
    s.summary          = '统计报表组件'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/a289458845/ExReport'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'a289458845' => '289458845@qq.com' }
    s.source           = { :git => 'https://github.com/a289458845/ExReport.git', :tag => s.version.to_s }
    #s.public_header_files = 'ATCategory/Category/*.h'
    s.ios.deployment_target = '9.0'
    #s.public_header_files = 'Pod/Classes/*.h'
    s.source_files = 'ExReport/Classes/**/*'
    
    s.resource_bundles = {
        'ExReport' => ['ExReport/Assets/*.png','ExReport/Assets/*']
    }
    s.prefix_header_contents = '#import "ExReport.h"'
    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.dependency 'ExNetwork'
    s.dependency 'SDWebImage', '~> 4.2.2'
    s.dependency 'Masonry'
    s.dependency 'MJExtension', '~> 3.0.17'
    s.dependency 'MJRefresh', '~> 3.2.0'
    s.dependency 'MBProgressHUD', '~> 1.1.0'
end
