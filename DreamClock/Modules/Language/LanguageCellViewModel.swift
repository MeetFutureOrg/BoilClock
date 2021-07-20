//
//  LanguageCellViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LanguageCellViewModel {
    
    let ensignName: Driver<String>
    let ensignPath: Driver<String>
    let name: Driver<String>
    let localeName: Driver<String>
    let isCurrent: Driver<Bool>
    
    let language: LanguageInfo
    
    
    init(with language: LanguageInfo) {
        self.language = language
        ensignName = Driver.just(language.ensign.name)
        self.ensignPath = Driver.just(language.ensign.path)
        name = Driver.just(language.name)
        localeName = Driver.just(language.localeName)
        isCurrent = Driver.just(language.isCurrent)
    }
}
