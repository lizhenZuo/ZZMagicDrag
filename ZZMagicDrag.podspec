#
#  Be sure to run `pod spec lint ZZMagicDrag.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "ZZMagicDrag"
  spec.version      = "1.0.1"
  spec.summary      = "use of ZZMagicDrag framework"

  spec.description  = <<-DESC
  详情请查看：https://github.com/lizhenZuo/ZZMagicDrag.git
                   DESC

  spec.homepage     = "https://github.com/lizhenZuo/ZZMagicDrag.gitg"
  spec.license      = "MIT"
  spec.author             = { "Zorro" => "1732096868@qq.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/lizhenZuo/ZZMagicDrag.git", :tag => spec.version }
  spec.source_files  = "ZZMagicDrag", "ZZMagicDrag/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

end
