//
//  FeedbackManager.swift
//  DreamClock
//
//  Created by Sun on 2018/12/13.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices


/// 来源 https://github.com/WorldDownTown/TapticEngine

public class TapticEngine {
    
    public static let impact: Impact = .init()
    public static let selection: Selection = .init()
    public static let notification: Notification = .init()
    
    private static var _enabled: Bool {
        return isEnabled
    }
    
    public static var isEnabled = false {
        didSet {
            if isEnabled && !oldValue {
                
            } else if !isEnabled && oldValue {
                
            }
        }
    }
    
    /// 封装 `UIImpactFeedbackGenerator` 类型
    public class Impact {
  
        /// Impact 反馈类型
        ///
        /// - light: 轻微
        /// - medium: 中度
        /// - heavy: 重度
        public enum Style: Int {
            case light = 1519
            case medium = 1520
            case heavy = 1521
        }
        
        private var style: Style = .light
        private var generator: Any? = Impact.make(.light)
        
        private static func make(_ style: Style) -> Any? {
            guard _enabled else { return nil }
            if #available(iOS 10.0, *) {
                let feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
                switch style {
                case .light:
                    feedbackStyle = .light
                case .medium:
                    feedbackStyle = .medium
                case .heavy:
                    feedbackStyle = .heavy
                }
                let generator = UIImpactFeedbackGenerator(style: feedbackStyle)
                generator.prepare()
                return generator
            } else {
                AudioServicesPlaySystemSound(SystemSoundID(style.rawValue))
                return nil
            }
        }
        
        private func updateGeneratorIfNeeded(_ style: Style) {
            guard self.style != style else { return }
            
            generator = Impact.make(style)
            self.style = style
        }
        
        public func feedback(_ style: Style) {
            updateGeneratorIfNeeded(style)
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UIImpactFeedbackGenerator else { return }
                generator.impactOccurred()
                generator.prepare()
            }
        }
        
        public func prepare(_ style: Style) {
            updateGeneratorIfNeeded(style)
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UIImpactFeedbackGenerator else { return }
                generator.prepare()
            }
        }
    }
    
    
    /// 封装 `UISelectionFeedbackGenerator`
    public class Selection {
        private var generator: Any? = {
            let generator: UISelectionFeedbackGenerator = UISelectionFeedbackGenerator()
            generator.prepare()
            return generator
        }()
        
        public func feedback() {
            guard _enabled else { return }
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UISelectionFeedbackGenerator else { return }
                generator.selectionChanged()
                generator.prepare()
            } else {
                AudioServicesPlaySystemSound(SystemSoundID(Impact.Style.medium.rawValue))
            }
        }
        
        public func prepare() {
            guard _enabled else { return }
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UISelectionFeedbackGenerator else { return }
                generator.prepare()
            } else {
                AudioServicesPlaySystemSound(SystemSoundID(Impact.Style.light.rawValue))
            }
        }
    }
    
    
    /// 封装 `UINotificationFeedbackGenerator`
    public class Notification {
        
        /// Notification 反馈类型
        ///
        /// - success: 成功
        /// - warning: 警告
        /// - error: 错误
        public enum `Type`: Int {
            case success = 1519
            case warning = 1520
            case error = 1521
        }
        
        private var generator: Any? = {
            guard #available(iOS 10.0, *) else { return nil }
            
            let generator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
            generator.prepare()
            return generator
        }()
        
        public func feedback(_ type: Type) {
            guard _enabled else { return }
            
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UINotificationFeedbackGenerator else { return }
                let feedbackType: UINotificationFeedbackGenerator.FeedbackType
                switch type {
                case .success:
                    feedbackType = .success
                case .warning:
                    feedbackType = .warning
                case .error:
                    feedbackType = .error
                }
                generator.notificationOccurred(feedbackType)
                generator.prepare()
            } else {
                AudioServicesPlaySystemSound(SystemSoundID(type.rawValue))
            }
        }
        
        public func prepare() {
            guard _enabled else { return }
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UINotificationFeedbackGenerator else { return }
                generator.prepare()
            } else {
                AudioServicesPlaySystemSound(SystemSoundID(Type.success.rawValue))
            }
        }
    }
}


extension TapticEngine {
    
    
    func toggled() -> Bool {
        TapticEngine.isEnabled.toggle()
        save()
        return TapticEngine._enabled
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(TapticEngine._enabled, forKey: Identifier.feedbackTrigger)
    }
}

//#if canImport(RxCocoa)
//import RxSwift
//import RxCocoa
//
//public extension Reactive where Base: TapticEngine {
//
//    /// Reactive wrapper for `isOn` property.
//    public var isOn: ControlProperty<Bool> {
//        return value
//    }
//
//    /// Reactive wrapper for `isOn` property.
//    ///
//    /// ⚠️ Versions prior to iOS 10.2 were leaking `UISwitch`'s, so on those versions
//    /// underlying observable sequence won't complete when nothing holds a strong reference
//    /// to `UISwitch`.
//    public var value: ControlProperty<Bool> {
//        return base.rx.controlPropertyWithDefaultEvents(
//            getter: { uiSwitch in
//                uiSwitch.isOn
//        }, setter: { uiSwitch, value in
//            uiSwitch.isOn = value
//        }
//        )
//    }
//}
//
//#endif
