//
//  ThemeCellViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ThemeCellViewModel {
    
    let title: Driver<String>
    let imageColor: Driver<UIColor>
    
    let theme: ColorTheme
    
    init(with theme: ColorTheme) {
        self.theme = theme
        title = Driver.just(theme.title)
        imageColor = Driver.just(theme.color)
    }
}
