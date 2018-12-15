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
        let languagesInfo = Language.availableLanguagesInfo(true)
        let elements = input.trigger.map { languagesInfo }.map { $0.map { LanguageCellViewModel(with: $0) } }.asDriver(onErrorJustReturn: [])
        
        let selected = input.selection
        
        // TODO: 切换语言后切换根控制器或在Label等控件监听通知
        selected.drive(onNext: { (cellViewModel) in
            Language.setLanguage(cellViewModel.language.languageCode)
        }).disposed(by: rx.disposeBag)
        
        
        return Output(items: elements,
                      selected: selected)
    }
    
    
}
