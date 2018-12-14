//
//  Configs.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import SwifterSwift

enum Keys {
    case fabric
    
    var apiKey: String {
        switch self {
        case .fabric: return ""
        }
    }
    
    var appId: String {
        switch self {
        case .fabric: return ""
        }
    }
}

struct Configs {
    
    struct App {
        static let bundleIdentifier = "com.flywake.dreamclock.DreamClock"
        static let IsTesting = true
        static let NavigationTitleFont = UIFont.navigationTitleFont()
    }
    
    struct Notification {
        static let defaultBody = "Wake Up!"
        static let alarmNotificationRequestIdentifier = Configs.App.bundleIdentifier + ".alarmNotificationRequestIdentifier"
        static let alarmCategoryIdentifier = Configs.App.bundleIdentifier + ".alarmCategoryIdentifier"
        static let alarmStopActionIdentifier = Configs.App.bundleIdentifier + ".alarmStopActionIdentifier"
        static let alarmSnoozeActionIdentifier = Configs.App.bundleIdentifier + ".alarmSnoozeActionIdentifier"
    }
    
    struct Network {
        static let useStaging = false
        static let loggingEnabled = false
        static var baseDomain: String {
            return ""
        }
        static var baseURL: String {
            return baseDomain //+ "/api/v1"
        }
    }
    
    struct BaseDimensions {
        static let inset: CGFloat = 10
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 50
        static let segmentedControlHeight: CGFloat = 30
    }
    
    struct BaseDuration {
        static let hudDuration: TimeInterval = 2
    }
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
    
    struct UserDefaultsKeys {
        static let hasBeenLaunched = "hasBeenLaunched"
        static let hasBeenLaunchedOfNewVersion = "hasBeenLaunchedOfNewVersion"
        static let mojorVersion = "CFBundleShortVersionString"
    }
}
