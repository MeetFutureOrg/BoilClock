//
//  SettingsViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewModel: ViewModel, ViewModelType  {
    
    /// 由vc传入
    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<SettingsSectionItem>
    }
    
    /// 输出
    struct Output {
        let items: BehaviorRelay<[SettingsSection]>
        let selectedEvent: Driver<SettingsSectionItem>
    }
    
    /// 夜晚模式
    let nightModeEnabled = PublishSubject<Bool>()
    
    /// 主要逻辑
    func transform(input: Input) -> Output {
        
        /// 组
        let elements = BehaviorRelay<[SettingsSection]>(value: [])
        ///
        input.trigger.map { () -> [SettingsSection] in
            
            /// 夜晚模式
            let isNightMode = ThemeType.currentTheme().isDark
            let nightModeModel = SettingsModel(type: .nightMode, leftImage: R.image.dc_ic_cell_night_mode.name, title: "settings.preferences.nightMode".localized(), detail: "", showDisclosure: false)
            let nightModeCellViewModel = SettingsSwitchCellViewModel(with: nightModeModel, isEnabled: isNightMode)
            nightModeCellViewModel.nightModeEnabled.bind(to: self.nightModeEnabled).disposed(by: self.rx.disposeBag)
            
            
            /// 主题
            let themeModel = SettingsModel(type: .theme, leftImage: R.image.dc_ic_cell_theme.name, title: "settings.preferences.theme".localized(), detail: "", showDisclosure: true)
            let themeViewModel = ThemeViewModel(provider: self.provider)
            let themeCellViewModel = SettingsDisclosureCellViewModel(with: themeModel, destinationViewModel: themeViewModel)
            
            
            /// 触觉反馈
            let tapicEngineModel = SettingsModel(type: .tapicEngine, leftImage: R.image.dc_ic_cell_tapic_engine.name, title: "settings.preferences.hapticFeedback".localized(), detail: "settings.preferences.tapicEngine".localized(), showDisclosure: false)
            let tapicEngineCellViewModel = SettingsSwitchCellViewModel(with: tapicEngineModel, isEnabled: true)
            
            /// 音效
            let soundModel = SettingsModel(type: .sound, leftImage: R.image.dc_ic_cell_sound.name, title: "settings.preferences.sound".localized(), detail: "", showDisclosure: false)
            let soundCellViewModel = SettingsSwitchCellViewModel(with: soundModel, isEnabled: true)
            
            /// 语言
            let languageModel = SettingsModel(type: .language, leftImage: R.image.dc_ic_cell_language.name, title: "settings.preferences.language".localized(), detail: "", showDisclosure: true)
            let languageViewModel = LanguageViewModel(provider: self.provider)
            // TODO: pass destinationViewModel
            let languageCellViewModel = SettingsDisclosureCellViewModel(with: languageModel, destinationViewModel: languageViewModel)
            
            return [
                SettingsSection.settings(title: "settings.preferences.section.title".localized(), items: [
                    SettingsSectionItem.settingsSwitchItem(viewModel: nightModeCellViewModel),
                    SettingsSectionItem.settingsDisclosureItem(viewModel: themeCellViewModel),
                    SettingsSectionItem.settingsSwitchItem(viewModel: tapicEngineCellViewModel),
                    SettingsSectionItem.settingsSwitchItem(viewModel: soundCellViewModel),
                    SettingsSectionItem.settingsDisclosureItem(viewModel: languageCellViewModel)
                    ])
            ]
            
            }.bind(to: elements).disposed(by: rx.disposeBag)
        
        /// cell 点击事件
        let selectedEvent = input.selection
        
        nightModeEnabled.subscribe(onNext: { isEnabled in
            var theme = ThemeType.currentTheme()
            if theme.isDark != isEnabled {
                theme = theme.toggled()
                themeService.set(theme)
            }
        }).disposed(by: rx.disposeBag)

        return Output(items: elements, selectedEvent: selectedEvent)
    }
    
    
}
