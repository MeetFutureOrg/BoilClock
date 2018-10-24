//
//  SettingsDisclosureCellViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsDisclosureCellViewModel {
    
    let type: SettingsType
    let title: Driver<String>
    let imageName: Driver<String>
    let showDisclosure: Driver<Bool>
    
    let settingModel: SettingsModel
    let destinationViewModel: ViewModel?
    
    init(with settingModel: SettingsModel, destinationViewModel: ViewModel? = nil) {
        self.destinationViewModel = destinationViewModel
        self.settingModel = settingModel
        type = settingModel.type
        title = Driver.just("\(settingModel.title ?? "")")
        imageName = Driver.just("\(settingModel.leftImage ?? "")")
        showDisclosure = Driver.just(settingModel.showDisclosure)
    }
}

