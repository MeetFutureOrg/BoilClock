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

let themeService = ThemeType.service(initial: ThemeType.currentTheme())

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
    
    init(colorTheme: ColorTheme)
}

struct LightTheme: Theme {
    
    var primary: UIColor = UIColor.white
    
    var primaryDark: UIColor = UIColor.white.darken()
    
    var secondary: UIColor = UIColor.red
    
    var secondaryDark: UIColor = UIColor.red.darken()
    
    var separator: UIColor = UIColor.white
    
    var text: UIColor = UIColor.black
    
    var textGray: UIColor = UIColor.gray
    
    var background = UIColor.white
    var statusBarStyle = UIStatusBarStyle.default
    var barStyle = UIBarStyle.default
    var keyboardAppearance = UIKeyboardAppearance.light
    
    init(colorTheme: ColorTheme) {
        secondary = colorTheme.color
        secondaryDark = colorTheme.colorDark
    }
}

struct DarkTheme: Theme {
    var primary = UIColor.black
    var primaryDark = UIColor.black.darken()
    var secondary = UIColor.red
    var secondaryDark = UIColor.red.darken()
    var separator = UIColor.black.darken()
    var text = UIColor.white
    var textGray = UIColor.gray
    var background = UIColor.black
    var statusBarStyle = UIStatusBarStyle.lightContent
    var barStyle = UIBarStyle.black
    var keyboardAppearance = UIKeyboardAppearance.dark
    
    init(colorTheme: ColorTheme) {
        secondary = colorTheme.color
        secondaryDark = colorTheme.colorDark
    }
}


enum ColorTheme: Int {
    case red, green, blue, skyBlue, magenta, purple, watermelon, lime, pink
    
    static let allValues = [red, green, blue, skyBlue, magenta, purple, watermelon, lime, pink]
    
    var color: UIColor {
        switch self {
        case .red: return UIColor.red
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        case .skyBlue: return UIColor.blue
        case .magenta: return UIColor.magenta
        case .purple: return UIColor.purple
        case .watermelon: return UIColor.red
        case .lime: return UIColor.orange
        case .pink: return UIColor.systemPink
        }
    }
    
    var colorDark: UIColor {
        switch self {
        case .red: return UIColor.red.darken()
        case .green: return UIColor.green.darken()
        case .blue: return UIColor.blue.darken()
        case .skyBlue: return UIColor.blue.darken()
        case .magenta: return UIColor.magenta.darken()
        case .purple: return UIColor.purple.darken()
        case .watermelon: return UIColor.red.darken()
        case .lime: return UIColor.orange.darken()
        case .pink: return UIColor.systemPink.darken()
        }
    }
    
    var title: String {
        switch self {
        case .red: return "settings.preferences.theme.color.red".localized()
        case .green: return "settings.preferences.theme.color.green".localized()
        case .blue: return "settings.preferences.theme.color.blue".localized()
        case .skyBlue: return "settings.preferences.theme.color.skyBlue".localized()
        case .magenta: return "settings.preferences.theme.color.magenta".localized()
        case .purple: return "settings.preferences.theme.color.purple".localized()
        case .watermelon: return "settings.preferences.theme.color.watermelon".localized()
        case .lime: return "settings.preferences.theme.color.lime".localized()
        case .pink: return "settings.preferences.theme.color.pink".localized()
        }
    }
}

enum ThemeType: ThemeProvider {
    case light(color: ColorTheme)
    case dark(color: ColorTheme)
    
    var associatedObject: Theme {
        switch self {
        case .light(let color): return LightTheme(colorTheme: color)
        case .dark(let color): return DarkTheme(colorTheme: color)
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
        case .light(let color): theme = ThemeType.dark(color: color)
        case .dark(let color): theme = ThemeType.light(color: color)
        }
        theme.save()
        return theme
    }
    
    func withColor(color: ColorTheme) -> ThemeType {
        var theme: ThemeType
        switch self {
        case .light: theme = ThemeType.light(color: color)
        case .dark: theme = ThemeType.dark(color: color)
        }
        theme.save()
        return theme
    }
}

extension ThemeType {
    static func currentTheme() -> ThemeType {
        let defaults = UserDefaults.standard
        let isDark = defaults.bool(forKey: Configs.UserDefaultsKeys.nightMode)
        let colorTheme = ColorTheme(rawValue: defaults.integer(forKey:  Configs.UserDefaultsKeys.themeKey)) ?? ColorTheme.red
        let theme = isDark ? ThemeType.dark(color: colorTheme) : ThemeType.light(color: colorTheme)
        theme.save()
        return theme
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(self.isDark, forKey:  Configs.UserDefaultsKeys.nightMode)
        switch self {
        case .light(let color): defaults.set(color.rawValue, forKey:  Configs.UserDefaultsKeys.themeKey)
        case .dark(let color): defaults.set(color.rawValue, forKey:  Configs.UserDefaultsKeys.themeKey)
        }
    }
}


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

extension Reactive where Base: UINavigationBar {
    
    /// Bindable sink for `titleTextAttributes` property
    @available(iOS 11.0, *)
    var largeTitleTextAttributes: Binder<[NSAttributedString.Key: Any]?> {
        return Binder(self.base) { view, attr in
            view.largeTitleTextAttributes = attr
        }
    }
}
