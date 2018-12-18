//
//  IconViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/12/17.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources


class IconViewModel: ViewModel, ViewModelType {
    
    
    struct Input {
        let trigger: Observable<Void>
        let selection: Driver<IconCellViewModel>
    }
    
    struct Output {
        let items: Driver<[IconCellViewModel]>
        let selected: Driver<IconCellViewModel>
    }
    
    func transform(input: Input) -> Output {
        
        let allIconInfo = IconManager.makeAllIconInfo()
        
        let elements = input.trigger
            .map { allIconInfo }
            .map { $0.map { IconCellViewModel(with: $0) } }
            .asDriver(onErrorJustReturn: [])
        
        let selected = input.selection
        
        selected.drive(onNext: { (cellViewModel) in
            IconManager.setIcon(name: cellViewModel.icon.iconName)
        }).disposed(by: rx.disposeBag)
        
        return Output(items: elements,
                      selected: selected)
    }
    
    
}
