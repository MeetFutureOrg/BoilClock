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
    
    let title: Driver<String>
    
    let languageModel: LanguageModel
    
    init(with languageModel: LanguageModel) {
        self.languageModel = languageModel
        title = Driver.just("\(languageModel.title ?? "")")
    }
}
