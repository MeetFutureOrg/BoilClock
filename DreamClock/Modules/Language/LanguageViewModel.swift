//
//  LanguageViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
import Localize_Swift

class LanguageViewModel: ViewModel, ViewModelType  {
    
    /// 传入
    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<LanguageCellViewModel>
    }
    
    /// 输出
    struct Output {
        let items: Driver<[LanguageCellViewModel]>
        let selected: Driver<LanguageCellViewModel>
    }
    
    
    /// 逻辑验证
    func transform(input: Input) -> Output {
        let availableLanguage = Localize.availableLanguages()
        let allItems = availableLanguage.map { LanguageModel(title: Localize.displayNameForLanguage($0), language: $0) }
        let elements = input.trigger
            .map { allItems }
            .map { $0.map { LanguageCellViewModel(with: $0) } }
            .asDriver(onErrorJustReturn: [])
        
        let selected = input.selection
        
        // TODO: 切换语言后切换根控制器或在Label等控件监听通知
        selected.drive(onNext: { (cellViewModel) in
            guard let language = cellViewModel.languageModel.language else {
                Localize.resetCurrentLanguageToDefault()
                return
            }
            Localize.setCurrentLanguage(language)
            
        }).disposed(by: rx.disposeBag)
        
        
        return Output(items: elements,
                      selected: selected)
    }
    
    
}
