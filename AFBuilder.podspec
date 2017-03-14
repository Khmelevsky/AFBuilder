Pod::Spec.new do |s|
  s.name           = 'AFBuilder'
  s.version        = '0.2.1'
  s.summary        = "AFNetworking request handling."
  s.homepage       = "https://github.com/Khmelevsky/AFNetworkingHandlers"
  s.author         = { 'Alexandr Khmelevsky' => 'khmelevsky.alex@gmail.com' }
  s.source         = { :git => 'https://github.com/Khmelevsky/AFNetworkingHandlers', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.requires_arc   = true
  s.source_files   = 'Source/*.swift'
  s.license        = 'MIT'
  s.dependency 'AFNetworking', '~> 3.0'
end
