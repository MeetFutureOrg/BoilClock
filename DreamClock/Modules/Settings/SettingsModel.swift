//
//  SettingsModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation

enum SettingsType {
    case nightMode
    case theme
    case haptic
    case sound
    case language
    case icon
}

struct SettingsModel {
    var type: SettingsType
    var leftImage: String
    var title: String?
    var detail: String?
    var showDisclosure = false
}
