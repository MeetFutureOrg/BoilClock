//
//  LanguageManager.swift
//  DreamClock
//
//  Created by Sun on 2018/10/25.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    public static let LanguageChange = Notification.Name("LanguageChange")
}

/// 当前语言的 Key
private let CurrentLanguageKey = "CurrentLanguageKey"

/// 默认英文, 如果中文不可用默认是base
private let DefaultLanguage = "Base"

/// Base bundle
private let BaseBundle = "Base"

struct LanguageInfo {
    let ensign: Ensign // 国旗资源名字
    let languageCode: Code // 语言代码
    let name: String // 语言名字
    let localeName: String // 语言本地化后的名字
    let isCurrent: Bool // 是否是当前语言
    
    init(code langCode: Code, name: String, localeName: String, isCurrent: Bool) {
        self.ensign = Ensign(langCode: langCode)
        self.languageCode = langCode
        self.name = name
        self.localeName = localeName
        self.isCurrent = isCurrent
    }
    
    
    struct Ensign {
        let name: String
        let path: String
        init(langCode: Code) {
            name = langCode.ensginName

            if let path = Bundle.ensignBundle.path(forResource: langCode.ensginName, ofType: "png") {
                self.path = path
            } else {
                self.path = String()
            }
        

//            UIImage(named: langCode.ensginName, in: <#T##Bundle?#>, compatibleWith: <#T##UITraitCollection?#>)

//            print(Bundle.Ensign.path(forResource: langCode.ensginName, ofType: "png")!)
//            let path = Bundle.main.path(forResource: "CountryEnsign", ofType: "bundle")!
//            let bundle = Bundle(path: path)!
//            namePath = bundle.path(forResource: langCode.ensginName, ofType: "png")!
        }
    }
    
    enum Code: String {
        typealias RawValue = String
        
        case de = "de" // 德语
        case en = "en" // 英语
        case en_AU = "en-AU" // 英语(澳大利亚)
        case en_GB = "en-GB" // 英语(英国)
        case en_IN = "en-IN" // 英语(印度)
        case es = "es" // 西班牙语
        case fr = "fr" // 法语
        case it = "it" // 意大利语
        case ja = "ja" // 日语
        case ko = "ko" // 韩语
        case nl = "nl" // 荷兰语
        case ru = "ru" // 俄语
        case zh_HK = "zh-HK" // 繁体中文(香港)
        case zh_Hans = "zh-Hans" // 简体中文
        case zh_Hant = "zh-Hant" // 繁体中文(台湾)
        case base = "Base" // Base
        
        var ensginName: String {
            let prefix = "language_cell_ensign_"
            switch self {
            case .de, .en, .en_AU, .en_GB, .en_IN, .es, .fr, .it, .ja, .ko, .nl, .ru, .zh_HK, .zh_Hans, .zh_Hant:
                return prefix + rawValue
            default:
                return prefix + "un"
            }
        }
    }
}

class Language {
    
    /// 获取应用当前的语言
    ///
    /// - Returns: 当前语言, 例如: en, zh-Hans 等
    static func current() -> LanguageInfo.Code {
        if let current = UserDefaults.standard.object(forKey: CurrentLanguageKey) as? String {
            if let code = LanguageInfo.Code(rawValue: current) {
                return code
            }
            return self.`default`()
        }
        return .base
    }
    
    /// 获取当前应用的默认语言
    ///
    /// - Returns: 当前默认语言, 例如: en, zh-Hans 等
    static func `default`() -> LanguageInfo.Code {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LanguageInfo.Code(rawValue: DefaultLanguage)!
        }
        
        let availableLanguages = self.available()
        if (availableLanguages.contains(LanguageInfo.Code(rawValue: preferredLanguage)!)) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = DefaultLanguage
        }
        return LanguageInfo.Code(rawValue: defaultLanguage)!
    }
    
    
    /// 获取当前应用可用语言列表
    /// 即: 项目的 `Localization` 列表中的所有语言
    ///
    /// - Parameter excludeBase: 是否剔除 `Base`, 默认 false -> 不剔除
    /// - Returns: 可用语言列表
    static func available(_ excludeBase: Bool = false) -> [LanguageInfo.Code] {
        var available = Bundle.main.localizations
        // 剔除 base
//        if let indexOfBase = available.firstIndex(of: "Base") , excludeBase == true {
//            available.remove(at: indexOfBase)
//        }
        available = available.sorted()
        return available.map { LanguageInfo.Code(rawValue: $0)! }
    }
    
    
    /// 获取当前应用可用语言信息
    ///
    /// - Parameter excludeBase: 是否剔除 `Base`
    /// - Returns: 可用语言信息列表, available 列表中的所有语言信息, 包含本地名称和语言原本的名字以及是否是当前语言
    static func availableLanguagesInfo(_ excludeBase: Bool = false) -> [LanguageInfo] {
        return self.available(excludeBase).map { self.getInfo(for: $0) }
    }
    
    
    /// 设置语言
    ///
    /// - Parameter language: 需要设置的语言, 例如: en, zh-Hans 等
    static func setLanguage(_ langCode: LanguageInfo.Code) {
        let selected = available().contains(langCode) ? langCode : self.default()
        if (selected != current()){
            UserDefaults.standard.set(selected.rawValue, forKey: CurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name.LanguageChange, object: nil)
        }
    }
    
    
    /// 重设为默认语言 => 跟随系统
    static func resetToDefault() {
        setLanguage(self.default())
    }
    
    
    /// 通过语言代码转换为语言的结构信息
    ///
    /// - Parameter language: 语言代码
    /// - Returns: 语言结构信息, 例如:
    ///
    ///                             languageCode: zh-Hans
    ///
    ///                             name: 中文(简体)
    ///
    ///                             localeName: Chinese
    ///
    ///                             isCurrent: false
    ///
    static func getInfo(for langCode: LanguageInfo.Code) -> LanguageInfo {
        let isCurrent = langCode == self.current()
//        let isCurrent: Bool
//        if self.current() == .base {
//            isCurrent = true
//        } else {
//            isCurrent = langCode == self.current()
//        }
        
        var languageName = ""
        var localeName = ""
        let languageLocale = NSLocale(localeIdentifier: langCode.rawValue)
        let currentLocale = NSLocale(localeIdentifier: self.current().rawValue)
        
        if let lName = languageLocale.displayName(forKey: .identifier, value: langCode.rawValue) {
            languageName = lName
        }
        
        if let name = currentLocale.displayName(forKey: .identifier, value: langCode.rawValue) {
            localeName = name
        }
        
        if langCode == .base {
            localeName = "settings.preferences.language.choose.follow.system".localized()
        }
        
        return LanguageInfo(code: langCode, name: languageName, localeName: localeName, isCurrent: isCurrent)
    }
    
//    static func getEnsignPath(by langCode : String) -> String {
//        assert(code.count>0, "must have a code")
////        let ensignListPath:String = Bundle.main.path(forResource: "EnsignList", ofType:"plist")!
//        let ensignList = NSArray(contentsOfFile:ensignListPath) as! [Dictionary<String, String>]
//
//        let ensign =
//
//
//        print(code)
//        for dic in ensignList {
//            if dic.keys.contains(code) {
//                return dic[code] ?? "🇺🇳"
//            }
//        }
//
//        return "🇺🇳"
//    }
    
    
    /// 通过语言代码转换为语言名称
    ///
    /// - Parameter language: 语言代码
    /// - Returns: 语言名称, 例如: 中文(简体), English 等
    static func displayName(for langCode: LanguageInfo.Code) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: self.current().rawValue)
        if langCode == .base {
            return "settings.preferences.language.choose.follow.system".localized()
        }
        
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: langCode.rawValue) {
            return displayName
        }
        
        return String()
    }
}

/// 语言本地化的扩展
public extension String {
  
    /// 替换 NSLocalizedString
    ///
    /// - Returns: 本地化后的字符串
    func localized() -> String {
        return localized(using: nil, in: .main)
    }
    
    /**
     用于替换 NSLocalizedString 的语法
     
     - parameter tableName: `strings` 文件的名字, 如果为 `nil`, 或者`空`, 会加载 `Localizable.strings` 文件
     
     - parameter bundle: `bundle` , 如果为 `nil`, 会加载 `main bundle`
     
     - returns: 本地化后的字符串
     */
    func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        
        let preferredLanguage = Bundle.main.preferredLocalizations.first!
        
        if let path = bundle.path(forResource: Language.current() == .base ? preferredLanguage : Language.current().rawValue , ofType: "lproj"),
            let bundle = Bundle(path: path) {
            
            print(path)
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        } else if let path = bundle.path(forResource: BaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        return self
    }
}


fileprivate extension Array {
    func sorted<T: Comparable>(by path: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        return sorted(by: { (lhs, rhs) -> Bool in
            return ascending ? lhs[keyPath: path] < rhs[keyPath: path] : lhs[keyPath: path] > rhs[keyPath: path]
        })
    }
}


extension Bundle {
    static var ensignBundle: Bundle {
        let path = main.path(forResource: "CountryEnsign", ofType: "bundle")!
        return Bundle(path: path)!
    }
}
