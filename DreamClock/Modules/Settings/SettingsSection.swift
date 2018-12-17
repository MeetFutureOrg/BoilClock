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
    case preferences(title: String, items: [SettingsSectionItem])
    case personalization(title: String, items: [SettingsSectionItem])
}

enum SettingsSectionItem {
    case settingsDisclosureItem(viewModel: SettingsDisclosureCellViewModel)
    case settingsSwitchItem(viewModel: SettingsSwitchCellViewModel)
}

extension SettingsSection: SectionModelType {
    typealias Item = SettingsSectionItem
    
    var title: String {
        switch self {
        case let .preferences(title, _):
            fallthrough
        case let .personalization(title, _):
            return title
        }
    }
    
    var items: [SettingsSectionItem] {
        switch  self {
        case .preferences(_, let items): return items.map { $0 }
        case .personalization(_,let items): return items.map { $0 }
        }
    }
    
    init(original: SettingsSection, items: [Item]) {
        switch original {
        case .preferences(let title, let items):
            self = .preferences(title: title, items: items)
        case .personalization(let title, let items):
            self = .personalization(title: title, items: items)
        }
    }
}
