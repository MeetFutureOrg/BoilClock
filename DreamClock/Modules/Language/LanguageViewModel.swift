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
        let selection: Driver<LanguageSectionItem>
    }
    
    /// 输出
    struct Output {
        let items: Driver<[LanguageSection]>
        let selected: Driver<LanguageSectionItem>
    }
    
//    private var currentLanguage: BehaviorRelay<Language>
    /// 逻辑验证
    func transform(input: Input) -> Output {
        
        
        let elements = BehaviorRelay<[LanguageSection]>(value: [])
        
        input.trigger.map { () -> [LanguageInfo] in
            return Language.availableLanguagesInfo()
            }.map { (languages) -> [LanguageSection] in
                let items = languages.compactMap({ (language) -> LanguageSectionItem in
                    let viewModel = LanguageCellViewModel(with: language)
                    return LanguageSectionItem.languageItem(viewModel: viewModel)
                })
                
                return [LanguageSection.language(items: items)]
        }.bind(to: elements).disposed(by: rx.disposeBag)
        
        
//        Observable.combineLatest(languages, input.trigger.asObservable()).map { (languages, trigger) -> [LanguageSection] in
//
//
//            let items = languages.compactMap({ (language) -> LanguageSectionItem in
//                let viewModel = LanguageCellViewModel(with: language)
//                return LanguageSectionItem.languageItem(viewModel: viewModel)
//            })
//
//            return [LanguageSection.language(items: items)]
//        }.bind(to: elements).disposed(by: rx.disposeBag)
        
        /**
         Thread 1: Fatal error: Failure converting from Optional(DreamClock.LanguageSectionItem.languageItem(viewModel: DreamClock.LanguageCellViewModel)) to LanguageCellViewModel
         */
        
        
//        let elements = input.trigger.map { languagesInfo }.map { $0.map { LanguageCellViewModel(with: $0) } }.asDriver(onErrorJustReturn: [])
//
        let selected = input.selection
        
        selected.drive(onNext: { (item) in
            switch item {
            case .languageItem(let viewModel):
                Language.setLanguage(viewModel.language.languageCode)
            }
        }).disposed(by: rx.disposeBag)
        // TODO: 切换语言后切换根控制器或在Label等控件监听通知
//        selected.drive(onNext: { (cellViewModel) in
//            Language.setLanguage(cellViewModel.language.languageCode)
//        }).disposed(by: rx.disposeBag)
        
        
        return Output(items: elements.asDriver(),
                      selected: selected)
    }
    
    
}
