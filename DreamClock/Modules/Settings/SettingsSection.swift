//
//  SettingsSection.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxDataSources

enum SettingsSection {
    case settings(title: String, items: [SettingsSectionItem])
}

enum SettingsSectionItem {
    case settingsDisclosureItem(viewModel: SettingsDisclosureCellViewModel)
    case settingsSwitchItem(viewModel: SettingsSwitchCellViewModel)
}

extension SettingsSection: SectionModelType {
    typealias Item = SettingsSectionItem
    
    var title: String {
        switch self {
        case .settings(let title, _): return title
        }
    }
    
    var items: [SettingsSectionItem] {
        switch  self {
        case .settings(_, let items): return items.map {$0}
        }
    }
    
    init(original: SettingsSection, items: [Item]) {
        switch original {
        case .settings(let title, let items): self = .settings(title: title, items: items)
        }
    }
}
