# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'DreamClock' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # inhibit pods warnings
  inhibit_all_warnings!

  # Pods for DreamClock
  
  # Rx Extensions
  pod 'RxSwift', '~> 6.2.0'
  pod 'RxCocoa'
  pod 'RxAlamofire'
  pod 'RxKingfisher'
  pod 'RxDataSources'
  pod 'RxSwiftExt'
  pod 'NSObject+Rx'
  pod 'RxViewController'
  pod 'RxGesture'
  pod 'RxOptional'
  pod 'RxTheme'
  pod 'RxAnimated'
  pod 'RxKeyboard'

  # JSON
  pod 'ObjectMapper'

  # Image
  pod 'Kingfisher'

  # Date
  pod 'SwiftDate'
  pod 'DateToolsSwift'

  # Tools
  pod 'DeviceKit'
  pod 'R.swift'
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
  pod 'NVActivityIndicatorView/Extended'
  pod 'SwiftMessages'
  pod 'SwiftEntryKit'
  pod 'DZNEmptyDataSet'
  # pod 'ESTabBarController-swift'
  # pod 'RAMAnimatedTabBarController', '~> 3.5'
  # pod 'SkeletonView'

  # Code Quality
  pod 'SwifterSwift'
  pod 'SwiftRichString'
  pod 'FLEX'

  # Logger
  pod 'CocoaLumberjack'

  target 'DreamClockTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DreamClockUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
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
