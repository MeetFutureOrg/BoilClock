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
    let nightModeEnabled = BehaviorSubject(value: ThemeType.currentTheme().isDark)
    
    /// 主要逻辑
    func transform(input: Input) -> Output {
        
        /// 组
        let elements = BehaviorRelay<[SettingsSection]>(value: [])
        ///
        input.trigger.map { () -> [SettingsSection] in
            
            /// 夜晚模式
            let nightModeModel = SettingsModel(type: .nightMode, leftImage: R.image.dc_ic_cell_night_mode.name, title: R.string.localizable.settingsPreferencesNightMode().localized(), detail: "", showDisclosure: false)
            let nightModeCellViewModel = SettingsSwitchCellViewModel(with: nightModeModel, isEnabled: self.nightModeEnabled.asDriver(onErrorJustReturn: false))
            
            nightModeCellViewModel.nightModeEnabled.bind(to: self.nightModeEnabled).disposed(by: self.rx.disposeBag)
            
            /// 主题
            let themeModel = SettingsModel(type: .theme, leftImage: R.image.dc_ic_cell_theme.name, title: R.string.localizable.settingsPreferencesTheme().localized(), detail: "", showDisclosure: true)
            let themeViewModel = ThemeViewModel(provider: self.provider)
            let themeCellViewModel = SettingsDisclosureCellViewModel(with: themeModel, destinationViewModel: themeViewModel)
            
            
            /// 触觉反馈
            let tapticEngineModel = SettingsModel(type: .tapticEngine, leftImage: R.image.dc_ic_cell_taptic_engine.name, title: R.string.localizable.settingsPreferencesHapticFeedback().localized(), detail: R.string.localizable.settingsPreferencesTapticEngine().localized(), showDisclosure: false)
            let tapticEngineCellViewModel = SettingsSwitchCellViewModel(with: tapticEngineModel, isEnabled: Driver.just(false))
            
            /// 音效
            let soundModel = SettingsModel(type: .sound, leftImage: R.image.dc_ic_cell_sound.name, title: R.string.localizable.settingsPreferencesSound().localized(), detail: "", showDisclosure: false)
            let soundCellViewModel = SettingsSwitchCellViewModel(with: soundModel, isEnabled: Driver.just(false))
            
            /// 语言
            let languageModel = SettingsModel(type: .language, leftImage: R.image.dc_ic_cell_language.name, title: R.string.localizable.settingsPreferencesLanguage().localized(), detail: "", showDisclosure: true)
            let languageViewModel = LanguageViewModel(provider: self.provider)
            let languageCellViewModel = SettingsDisclosureCellViewModel(with: languageModel, destinationViewModel: languageViewModel)
            
            return [
                SettingsSection.settings(title: R.string.localizable.settingsPreferencesSectionTitle().localized(), items: [
                    SettingsSectionItem.settingsSwitchItem(viewModel: nightModeCellViewModel),
                    SettingsSectionItem.settingsDisclosureItem(viewModel: themeCellViewModel),
                    SettingsSectionItem.settingsSwitchItem(viewModel: tapticEngineCellViewModel),
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
