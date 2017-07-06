# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Mock_Revenue' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Mock_Revenue
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'AMPopTip'
  pod 'KRProgressHUD'
  pod 'Charts'
  pod 'RealmSwift'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end
  
  target 'Mock_RevenueTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Mock_RevenueUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
