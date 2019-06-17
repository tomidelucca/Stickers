platform :ios, '11.2'

target 'Stickers' do
  pod 'PureLayout'
end

post_install do |pi|
  pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.2'
      end
  end
end
