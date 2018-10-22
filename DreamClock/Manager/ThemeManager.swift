//
//  ThemeManager.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import RxSwift
import RxCocoa
import RxTheme
import SwifterSwift

protocol Theme {
    var primary: UIColor { get }
    var primaryDark: UIColor { get }
    var secondary: UIColor { get }
    var secondaryDark: UIColor { get }
    var separator: UIColor { get }
    var text: UIColor { get }
    var textGray: UIColor { get }
    var background: UIColor { get }
    var statusBarStyle: UIStatusBarStyle { get }
    var barStyle: UIBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    
    //    init(colorTheme: ColorTheme)
}

struct LightTheme: Theme {
    let primary = Color.white
    let primaryDark = Color.FlatUI.clouds
    var secondary =  Color.FlatUI.alizarin
    var secondaryDark = Color.FlatUI.pomegranate
    let separator = Color.FlatUI.clouds
    let text = Color.Material.black
    let textGray = Color.Material.grey
    let background = Color.white
    let statusBarStyle = UIStatusBarStyle.default
    let barStyle = UIBarStyle.default
    let keyboardAppearance = UIKeyboardAppearance.light
}

struct DarkTheme: Theme {
    let primary = Color.Material.grey800
    let primaryDark = Color.Material.grey900
    var secondary = Color.FlatUI.alizarin
    var secondaryDark = Color.FlatUI.pomegranate
    let separator = Color.Material.grey900
    let text = Color.FlatUI.silver
    let textGray = Color.FlatUI.concerte
    let background = Color.Material.grey800
    let statusBarStyle = UIStatusBarStyle.lightContent
    let barStyle = UIBarStyle.black
    let keyboardAppearance = UIKeyboardAppearance.dark
    
}

enum ThemeType: Int, ThemeProvider {
    case light
    case dark
    
    var associatedObject: Theme {
        switch self {
        case .light: return LightTheme()
        case .dark: return DarkTheme()
        }
    }
    
    var isDark: Bool {
        switch self {
        case .dark: return true
        default: return false
        }
    }
    
    func toggled() -> ThemeType {
        var theme: ThemeType
        switch self {
        case .light: theme = ThemeType.dark
        case .dark: theme = ThemeType.light
        }
        theme.save()
        return theme
    }
    
    func withColor() -> ThemeType {
        var theme: ThemeType
        switch self {
        case .light: theme = ThemeType.light
        case .dark: theme = ThemeType.dark
        }
        theme.save()
        return theme
    }
}

extension ThemeType {
    static func currentTheme() -> ThemeType {
        let defaults = UserDefaults.standard
        let isDark = defaults.bool(forKey: "IsDarkKey")
        //        let colorTheme = ThemeType(rawValue: defaults.integer(forKey: "ThemeKey")) ?? ThemeType.light
        //        let theme = isDark ? ThemeType.dark(color: colorTheme) : ThemeType.light(color: colorTheme)
        let theme: ThemeType = isDark ? .dark : .light
        
        theme.save()
        return theme
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(self.isDark, forKey: "IsDarkKey")
        switch self {
        case .light: defaults.set(ThemeType.light.rawValue, forKey: "ThemeKey")
        case .dark: defaults.set(ThemeType.dark.rawValue, forKey: "ThemeKey")
        }
    }
}

let themeService = ThemeType.service(initial: ThemeType.currentTheme())

extension Reactive where Base: UIView {
    
    /// Bindable sink for `backgroundColor` property
    var backgroundColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.backgroundColor = attr
        }
    }
}

extension Reactive where Base: UITextField {
    
    /// Bindable sink for `borderColor` property
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.borderColor = attr
        }
    }
    
    /// Bindable sink for `placeholderColor` property
    var placeholderColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            if let color = attr {
                view.setPlaceHolderTextColor(color)
            }
        }
    }
}

extension Reactive where Base: UITableView {
    
    /// Bindable sink for `separatorColor` property
    var separatorColor: Binder<UIColor?> {
        return Binder(self.base) { view, attr in
            view.separatorColor = attr
        }
    }
}


extension Reactive where Base: UITabBar {
    
    /// Bindable sink for `tintColor` property
    var tintColor: Binder<UIColor> {
        return Binder(self.base) { tabBar, tintColor in
            tabBar.tintColor = tintColor
        }
    }
}

extension Reactive where Base: UITabBarItem {
    
    /// Bindable sink for `titleColor` property
    var titleColor: Binder<UIColor> {
        return Binder(self.base) { tabBarItem, titleColor in
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor], for: .normal)
        }
    }
    
    /// Bindable sink for `titleSelectedColor` property
    var titleSelectedColor: Binder<UIColor> {
        return Binder(self.base) { tabBarItem, titleColor in
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor], for: .selected)
        }
    }
    
}
//
//extension Reactive where Base: RAMItemAnimation {
//
//    /// Bindable sink for `iconSelectedColor` property
//    var iconSelectedColor: Binder<UIColor> {
//        return Binder(self.base) { view, attr in
//            view.iconSelectedColor = attr
//        }
//    }
//
//    /// Bindable sink for `textSelectedColor` property
//    var textSelectedColor: Binder<UIColor> {
//        return Binder(self.base) { view, attr in
//            view.textSelectedColor = attr
//        }
//    }
//}

extension Reactive where Base: UINavigationBar {
    
    /// Bindable sink for `titleTextAttributes` property
    @available(iOS 11.0, *)
    var largeTitleTextAttributes: Binder<[NSAttributedString.Key: Any]?> {
        return Binder(self.base) { view, attr in
            view.largeTitleTextAttributes = attr
        }
    }
}

//extension Reactive where Base: UIApplication {
//
//    /// Bindable sink for `statusBarStyle` property
//    var statusBarStyle: Binder<UIStatusBarStyle> {
//        return Binder(self.base) { view, attr in
//            view.statusBarStyle = attr
//        }
//    }
//}
