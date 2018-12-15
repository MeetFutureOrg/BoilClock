//
//  SettingsSwitchCellViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsSwitchCellViewModel {
    
    let type: SettingsType
    let title: Driver<String>
    let detail: Driver<String>
    let imageName: Driver<String>
    let showDisclosure: Driver<Bool>
    let isEnabled: Driver<Bool>
    
    let settingModel: SettingsModel
    let destinationViewModel: ViewModel?
    
    let featureTrigger = PublishSubject<Bool>()
    
    
    init(with settingsModel: SettingsModel, isEnabled: Driver<Bool>, destinationViewModel: ViewModel? = nil) {
        self.destinationViewModel = destinationViewModel
        self.settingModel = settingsModel
        type = settingsModel.type
        title = Driver.just("\(settingsModel.title ?? "")")
        detail = Driver.just("\(settingsModel.detail ?? "")")
        imageName = Driver.just(settingsModel.leftImage)
        showDisclosure = Driver.just(settingsModel.showDisclosure)
        self.isEnabled = isEnabled
//        nightModeEnabled = PublishSubjec
    }
}
