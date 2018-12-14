//
//  FeedbackManager.swift
//  DreamClock
//
//  Created by Sun on 2018/12/13.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices
import DeviceKit

/// 根据 https://github.com/WorldDownTown/TapticEngine 修改而来

public class TapticEngine {
    
    public static let impact: Impact = .init()
    public static let selection: Selection = .init()
    public static let notification: Notification = .init()
    
    private static var _enabled: Bool {
        return isEnabled
    }
    
    public static var isEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey:  Configs.UserDefaultsKeys.feedbackTrigger)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Configs.UserDefaultsKeys.feedbackTrigger)
        }
    }
    
    private static let device = Device()
    
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
            if device.feedbackLevel == .improved  {
                guard #available(iOS 10.0, *) else { return nil }
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
        
        private func updateFeedback(_ style: Style) {
            generator = Impact.make(style)
            self.style = style
        }
        
        public func feedback(_ style: Style) {
            updateFeedback(style)
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UIImpactFeedbackGenerator else { return }
                generator.impactOccurred()
                generator.prepare()
            }
        }
        
        public func prepare(_ style: Style) {
            updateFeedback(style)
            if #available(iOS 10.0, *) {
                guard let generator = generator as? UIImpactFeedbackGenerator else { return }
                generator.prepare()
            }
        }
    }
    
    
    /// 封装 `UISelectionFeedbackGenerator`
    public class Selection {
        private var generator: Any? = {
            guard #available(iOS 10.0, *) else { return nil }
            let generator: UISelectionFeedbackGenerator = UISelectionFeedbackGenerator()
            generator.prepare()
            return generator
        }()
        
        public func feedback() {
            guard _enabled else { return }
            if device.feedbackLevel == .improved {
                guard #available(iOS 10.0, *) else { return }
                guard let generator = generator as? UISelectionFeedbackGenerator else { return }
                generator.selectionChanged()
                generator.prepare()
            } else {
                AudioServicesPlaySystemSound(SystemSoundID(Impact.Style.light.rawValue))
            }
        }
        
        public func prepare() {
            guard _enabled else { return }
            if device.feedbackLevel == .improved {
                guard #available(iOS 10.0, *) else { return }
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
            
            if device.feedbackLevel == .improved {
                guard #available(iOS 10.0, *) else { return }
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
            if device.feedbackLevel == .improved {
                guard #available(iOS 10.0, *) else { return }
                guard let generator = generator as? UINotificationFeedbackGenerator else { return }
                generator.prepare()
            } else {
                AudioServicesPlaySystemSound(SystemSoundID(Type.success.rawValue))
            }
        }
    }
}


extension TapticEngine {
    static func toggle() {
        isEnabled.toggle()
    }
}

