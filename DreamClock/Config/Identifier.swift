//
//  Identifier.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation

struct Identifier {
    
    /// 夜晚模式
    static let nightMode = Configs.App.bundleIdentifier + ".nightMode"
    static let themeKey = Configs.App.bundleIdentifier + ".theme"
    
    /// 震动反馈开关
    static let feedbackTrigger = Configs.App.bundleIdentifier + ".feedbackTrigger"
    
    static let persistKey = Configs.App.bundleIdentifier + ".persister"
    static let stopIdentifier = Configs.App.bundleIdentifier + ".stop"
    static let snoozeIdentifier = Configs.App.bundleIdentifier + ".snooze"
    static let settingIdentifier = Configs.App.bundleIdentifier + ".setting"
    static let musicIdentifier = Configs.App.bundleIdentifier + ".music"
    static let alarmCellIdentifier = Configs.App.bundleIdentifier + ".alarmCellIdentifier"
    static let disclosureCellIdentifier = Configs.App.bundleIdentifier + ".disclosureCellIdentifier"
    static let switchCellIdentifier = Configs.App.bundleIdentifier + ".switchCellIdentifier"
    static let themeCellIdentifier = Configs.App.bundleIdentifier + ".themeCellIdentifier"
    static let languageCellIdentifier = Configs.App.bundleIdentifier + ".languageCellIdentifier"
}


