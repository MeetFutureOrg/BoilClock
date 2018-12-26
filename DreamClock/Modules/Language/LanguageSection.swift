//
//  LanguageSection.swift
//  DreamClock
//
//  Created by Sun on 2018/12/26.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxDataSources

enum LanguageSection {
    case language(items: [LanguageSectionItem])
}

enum LanguageSectionItem {

    case languageItem(viewModel: LanguageCellViewModel)
}

extension LanguageSection: SectionModelType {
    typealias Item = LanguageSectionItem
    
    
    var items: [LanguageSectionItem] {
        switch  self {
        case .language(let items): return items.map {$0}
        }
    }
    
    init(original: LanguageSection, items: [Item]) {
        switch original {
        case .language(let items): self = .language(items: items)
        }
    }
}
