# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'DreamClock' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # inhibit pods warnings
  inhibit_all_warnings!

  # Pods for DreamClock
  
  # Networking
  pod 'Moya/RxSwift'
  pod 'ReachabilitySwift'

  # Rx Extensions
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxSwiftExt'
  pod 'NSObject+Rx'
  pod 'RxViewController'
  pod 'RxGesture'
  pod 'RxOptional'
  pod 'RxTheme'

  # JSON Mapping
  pod 'Moya-ObjectMapper/RxSwift'

  # Image
  pod 'Kingfisher'

  # Date
  pod 'SwiftDate'
  pod 'DateToolsSwift'

  # Tools
  pod 'DeviceKit'
  pod 'R.swift', '5.0.0.rc.1'
  # pod 'SwiftyUserDefaults'
  pod 'KeychainAccess'

  # Auto Layout
  pod 'SnapKit'

  # Fabric
  # pod 'Fabric'
  # pod 'Crashlytics'

  # UI
  pod 'Hero'
  pod 'IGListKit'
  pod 'DZNEmptyDataSet'
  pod 'NVActivityIndicatorView'
  pod 'SwiftMessages'
  pod 'SwiftEntryKit'
  # pod 'ESTabBarController-swift'
  # pod 'RAMAnimatedTabBarController', '~> 3.5'
  # pod 'SkeletonView'

  # Keyboard
  pod 'IQKeyboardManagerSwift'
  
  # Color
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'

  # Code Quality
  pod 'SwifterSwift'
  pod 'SwiftRichString'
  pod 'FLEX'

  # DEBUG
  pod 'CocoaDebug', :configurations => ['Debug']
  pod 'netfox', :configurations => ['Debug']

  # Logging
  pod 'CocoaLumberjack/Swift'

  target 'DreamClockTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DreamClockUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

# Cocoapods optimization, always clean project after pod updating
post_install do |installer|
    installer.pods_project.targets.each do |target|
#        if target.name == 'ChameleonFramework' || target.name == 'netfox'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
#        end
    end
end
#    Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
#        flag_name = File.basename(script, ".sh") + "-Installation-Flag"
#        folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
#        file = File.join(folder, flag_name)
#        content = File.read(script)
#        content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
#        File.write(script, content)
#    end
