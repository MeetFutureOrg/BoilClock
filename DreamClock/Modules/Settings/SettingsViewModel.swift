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
    
    /// 触觉反馈开关
    let hapticTrigger = BehaviorSubject(value: TapticEngine.isEnabled)
    
    /// 音效开关
    let soundTrigger = BehaviorSubject(value: TapticEngine.isEnabled)
    
    /// 主要逻辑
    func transform(input: Input) -> Output {
        
        /// 组
        let elements = BehaviorRelay<[SettingsSection]>(value: [])
        ///
        input.trigger.map { () -> [SettingsSection] in
            
            // MARK: - 偏好
            /// 夜晚模式
            let nightModeModel = SettingsModel(type: .nightMode, leftImage: R.image.dc_ic_cell_night_mode.name, title: "settings.preferences.nightMode".localized(), detail: "", showDisclosure: false)
            let nightModeCellViewModel = SettingsSwitchCellViewModel(with: nightModeModel, isEnabled: self.nightModeEnabled.asDriver(onErrorJustReturn: false))
            
            nightModeCellViewModel.featureTrigger.bind(to: self.nightModeEnabled).disposed(by: self.rx.disposeBag)
            
            /// 主题
            let themeModel = SettingsModel(type: .theme, leftImage: R.image.dc_ic_cell_theme.name, title: "settings.preferences.theme".localized(), detail: "", showDisclosure: true)
            let themeViewModel = ThemeViewModel(provider: self.provider)
            let themeCellViewModel = SettingsDisclosureCellViewModel(with: themeModel, destinationViewModel: themeViewModel)
            
            
            /// 触觉反馈
            let hapticFeedbackModel = SettingsModel(type: .haptic, leftImage: R.image.dc_ic_cell_haptic_feedback.name, title: "settings.preferences.hapticFeedback".localized(), detail: "settings.preferences.tapticEngine".localized(), showDisclosure: false)
            let hapticFeedbackCellViewModel = SettingsSwitchCellViewModel(with: hapticFeedbackModel, isEnabled: self.hapticTrigger.asDriver(onErrorJustReturn: false))
            hapticFeedbackCellViewModel.featureTrigger.bind(to: self.hapticTrigger).disposed(by: self.rx.disposeBag)
            
            /// 音效
            let soundModel = SettingsModel(type: .sound, leftImage: R.image.dc_ic_cell_sound.name, title: "settings.preferences.sound".localized(), detail: "", showDisclosure: false)
            let soundCellViewModel = SettingsSwitchCellViewModel(with: soundModel, isEnabled: self.soundTrigger.asDriver(onErrorJustReturn: false))
            soundCellViewModel.featureTrigger.bind(to: self.soundTrigger).disposed(by: self.rx.disposeBag)
            
            /// 语言
            let languageModel = SettingsModel(type: .language, leftImage: R.image.dc_ic_cell_language.name, title: "settings.preferences.language".localized(), detail: "", showDisclosure: true)
            let languageViewModel = LanguageViewModel(provider: self.provider)
            let languageCellViewModel = SettingsDisclosureCellViewModel(with: languageModel, destinationViewModel: languageViewModel)
            
            // MARK: - 个性化
            /// 图标
            let iconModel = SettingsModel(type: .icon, leftImage: <#T##String#>, title: <#T##String?#>, detail: <#T##String?#>, showDisclosure: <#T##Bool#>)
            
            return [
                SettingsSection.preferences(title: "settings.preferences.section.title".localized(), items: [
                    SettingsSectionItem.settingsSwitchItem(viewModel: nightModeCellViewModel),
                    SettingsSectionItem.settingsDisclosureItem(viewModel: themeCellViewModel),
                    SettingsSectionItem.settingsSwitchItem(viewModel: hapticFeedbackCellViewModel),
                    SettingsSectionItem.settingsSwitchItem(viewModel: soundCellViewModel),
                    SettingsSectionItem.settingsDisclosureItem(viewModel: languageCellViewModel)
                    ]),
                SettingsSection.personalization(title: <#T##String#>, items: <#T##[SettingsSectionItem]#>)
            ]
            
            }.bind(to: elements).disposed(by: rx.disposeBag)
        
        /// cell 点击事件
        let selectedEvent = input.selection
        
        /// 夜晚模式开关逻辑
        nightModeEnabled.subscribe(onNext: { isEnabled in
            TapticEngine.impact.feedback(.medium)
            var theme = ThemeType.currentTheme()
            if theme.isDark != isEnabled {
                theme = theme.toggled()
                themeService.set(theme)
            }
        }).disposed(by: rx.disposeBag)

        /// 触觉反馈开关逻辑
        hapticTrigger.subscribe(onNext: { trigger in
            TapticEngine.impact.feedback(.medium)
            if TapticEngine.isEnabled != trigger {
                TapticEngine.toggle()
            }
        }).disposed(by: rx.disposeBag)
        
        soundTrigger.subscribe(onNext: { trigger in
            
        }).disposed(by: rx.disposeBag)
        
        return Output(items: elements, selectedEvent: selectedEvent)
    }
    
    
}
