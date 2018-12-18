//
//  IconManager.swift
//  DreamClock
//
//  Created by Sun on 2018/12/17.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit


struct Icon {
    
    /// info.plist 中的icon名字, 设置图标时会用到
    let iconName: String
    
    /// 本地图片的名字, 在展示图标时会用到(只有60x60的)
    let imageName: String
}

class IconManager {
    
    
    static func setIcon(name: String) {
        if #available(iOS 10.3, *) {
            guard UIApplication.shared.supportsAlternateIcons else { return }
            var iconName: String?
            iconName = name
            if iconName == DefaultIconName { iconName = nil }
            UIApplication.shared.setAlternateIconName(iconName) { (error) in
                if error != nil {
                    if let rootVC = AppDelegate.shared?.window?.rootViewController {
                        rootVC.showError(title: "settings.personalization.icon.change.failed.hud.title".localized(), body: error?.localizedDescription, position: .center, duration: .forever, buttonTitle: "settings.personalization.icon.change.failed.hud.retry".localized(), buttonTapHandler: { _ in
                            setIcon(name: name)
                        })
                    }
                }
            }
        } else {
            // Fallback on earlier versions
            if let rootVC = AppDelegate.shared?.window?.rootViewController {
                rootVC.showError(title: "settings.personalization.icon.change.nosupport.hud.title".localized(), body: "settings.personalization.icon.change.nosupport.hud.body".localized())
            }
        }
    }
    
    /// 获取所有图标信息
    ///
    /// - Returns: 图标信息
    static func makeAllIconInfo() -> [Icon] {
        return allIcons().map { Icon(iconName: $0.key, imageName: $0.value) }
    }
    
    /// 获取所有图标的名字数组
    ///
    /// - Returns: 所有图标名字的数组
    static func allIcons() -> [String: String] {
        var all = [String: String]()
        all[DefaultIconName] = getPrimaryIconName()
        if let alternateIcons = getAlternateIconsName() {
            alternateIcons.forEach { (icons) in
                all.updateValue(icons.value, forKey: icons.key)
            }
        }
        return all
    }
    
    
    // MARK: - Primary
    ///
    /// <key>CFBundleIcons</key>
    /// <dict>
    ///     <key>CFBundlePrimaryIcon</key>
    ///     <dict>
    ///         <key>UIPrerenderedIcon</key>
    ///         <false/>
    ///         <key>CFBundleIconFiles</key>
    ///         <array>
    ///             <string>Icon-60</string>
    ///             <string>Icon-Notification</string>
    ///             <string>Icon-Small-40</string>
    ///             <string>Icon-Small</string>
    ///         </array>
    ///     </dict>
    /// </dict>
    
    // MARK: - Alternate
    ///
    /// <key>CFBundleIcons</key>
    /// <dict>
    ///     <key>CFBundleAlternateIcons</key>
    ///     <dict>
    ///         <key>DarkMode</key>
    ///         <dict>
    ///             <key>CFBundleIconFiles</key>
    ///             <array>
    ///                 <string>DarkMode-Icon-60</string>
    ///                 <string>DarkMode-Icon-Notification</string>
    ///                 <string>DarkMode-Icon-Small-40</string>
    ///                 <string>DarkMode-Icon-Small</string>
    ///             </array>
    ///         </dict>
    ///     </dict>
    /// </dict>
    ///
    /// [String: [String: Any]]
    
    
    /// MainBundle 中 CFBundleIcons key 对应的数据
    private static var bundleIcons: [String: [String: Any]]? {
        
        if let iconDict = Bundle.main.infoDictionary?[BundleIconsKey] as? [String: [String: Any]] {
            return iconDict
        }
        return nil
    }
    
    
    /// 获取自定义的 Icon 名字
    ///
    /// - Returns: icon 名字数组
    static func getAlternateIconsName() -> [String: String]? {
        if let alternateIcons = bundleIcons?[AlternateIconsKey] as? [String: [String: [String]]] { // [String: Any]?
            if alternateIcons.keys.isEmpty { return nil }
            var iconNames = [String: String]()
            for (key, value) in alternateIcons {
                for namesArray in value.values {
                    let names = namesArray.filter { $0.contains(DefaultIconName) }
                    if let name = names.first {
                        iconNames[key] = name
                    }
                }
            }
            if iconNames.isEmpty { return nil }
            return iconNames
        }
        return nil
    }
    
    
    /// 获取App首要的icon
    ///
    /// - Returns: icon 名字
    static func getPrimaryIconName() -> String {

        if let primaryIcon = bundleIcons?[PrimaryIconKey] { // [String: Any]?
            let iconFiles = primaryIcon[IconFilesKey] as! [String]
            let iconNames = iconFiles.filter { $0.contains(DefaultIconName) }
            if let iconName = iconNames.first {
                return iconName
            }
            return DefaultIconName
        }
        return DefaultIconName
    }

}

fileprivate extension IconManager {
    static let PrimaryIconKey = "CFBundlePrimaryIcon"
    static let IconFilesKey = "CFBundleIconFiles"
    static let AlternateIconsKey = "CFBundleAlternateIcons"
    static let BundleIconsKey = "CFBundleIcons"
    
    static let DefaultIconName = "AppIcon-60"
}

fileprivate extension String {
    fileprivate func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
}
