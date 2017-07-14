Pod::Spec.new do |s|
  s.name     = 'TJTestSubspec'
  s.version  = '0.0.3'
  s.license  = 'MIT'
  s.summary  = 'A delightful iOS and OS X LSAccountManager framework.'
  s.homepage = 'https://github.com/malai520/TestSubspec'
  s.social_media_url = 'https://github.com/malai520/TestSubspec'
  s.authors  = { 'malai' => 'malai_520@163.com' }
  s.source   = { :git => 'https://github.com/malai520/TestSubspec.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  
  s.public_header_files = 'Classes/TJModule.h'
  s.source_files = 'Classes/TJModule.h'
  
  pch_AF = <<-EOS
#ifndef TARGET_OS_IOS
  #define TARGET_OS_IOS TARGET_OS_IPHONE
#endif

#ifndef TARGET_OS_WATCH
  #define TARGET_OS_WATCH 0
#endif

#ifndef TARGET_OS_TV
  #define TARGET_OS_TV 0
#endif
EOS
  s.prefix_header_contents = pch_AF
  
  s.ios.deployment_target = '8.0'

  s.default_subspec = 'framework'
  
  
  #public
  s.subspec 'source' do |ss|

    ss.dependency 'TJTestSubspec/Module1'
    ss.dependency 'TJTestSubspec/Module2'
    ss.dependency 'TJTestSubspec/Module2'
  end

  s.subspec 'framework' do |ss|
    ss.ios.vendored_frameworks = 'ios/TJTestSubspec.embeddedframework/TJTestSubspec.framework'

  end

  # private
  s.subspec 'Module1' do |sss|
      sss.source_files = 'Classes/TJModule1.{h,m}'
      sss.public_header_files = 'Classes/TJModule1.h'

    end

  s.subspec 'Module2' do |sss|
    sss.source_files = 'Classes/TJModule2.{h,m}'
    sss.public_header_files = 'Classes/TJModule2.h'
    end

  s.subspec 'Module3' do |sss|
    sss.source_files = 'Classes/TJModule3.{h,m}'
    sss.public_header_files = 'Classes/TJModule3.h'

    end 



end
