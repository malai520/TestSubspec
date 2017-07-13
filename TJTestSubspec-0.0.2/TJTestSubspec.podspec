Pod::Spec.new do |s|
  s.name = "TJTestSubspec"
  s.version = "0.0.2"
  s.summary = "A delightful iOS and OS X LSAccountManager framework."
  s.license = "MIT"
  s.authors = {"malai"=>"malai_520@163.com"}
  s.homepage = "https://github.com/malai520/TestSubspec"
  s.social_media_url = "https://github.com/malai520/TestSubspec"
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/TJTestSubspec.embeddedframework/TJTestSubspec.framework'
end
