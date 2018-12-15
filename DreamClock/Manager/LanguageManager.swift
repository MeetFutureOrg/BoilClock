//
//  LanguageManager.swift
//  DreamClock
//
//  Created by Sun on 2018/10/25.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation

extension Notification.Name {
    public static let LanguageChange = Notification.Name("LanguageChange")
}

/// 内部当前语言的 Key
let CurrentLanguageKey = "CurrentLanguageKey"

/// 默认中文, 如果中文不可用默认是base
let DefaultLanguage = "zh-Hans"

class Language {
    
    static func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return DefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = DefaultLanguage
        }
        return defaultLanguage
    }
    
    static func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // 如果 excludeBase == true, 可用语言里移除 base
        if let indexOfBase = availableLanguages.index(of: "Base") , excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    static func currentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: CurrentLanguageKey) as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }
    
    static func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if (selectedLanguage != currentLanguage()){
            UserDefaults.standard.set(selectedLanguage, forKey: CurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name.LanguageChange, object: nil)
        }
    }
    
    static func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    static func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: currentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}


