//
//  IconCellViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/12/17.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IconCellViewModel {
    
    let iconName: Driver<String>
    let imageName: Driver<String>
    
    let icon: Icon
    
    init(with icon: Icon) {
        self.icon = icon
        iconName = Driver.just(icon.iconName)
        imageName = Driver.just(icon.imageName)
    }
}
