//
//  MainTabBarViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import RxCocoa
import RxSwift

class MainTabBarViewModel: ViewModel, ViewModelType {
    
    struct Input { }
    
    struct Output {
        let tabBarItems: Driver<[MainTabBarItem]>
    }
    
    let loggedIn: BehaviorRelay<Bool>
    
    init(loggedIn: Bool, provider: DreamAPI) {
        self.loggedIn = BehaviorRelay(value: loggedIn)
        super.init(provider: provider)
    }
    
    func transform(input: Input) -> Output {
        
        
        let tabBarItems = loggedIn.map { (loggedIn) -> [MainTabBarItem] in
            return [.clock]
            }.asDriver(onErrorJustReturn: [])
        
        return Output(tabBarItems: tabBarItems)
    }
    
    func viewModel(for tabBarItem: MainTabBarItem) -> ViewModel {
        switch tabBarItem {
        case .clock:
            let viewModel = ClockViewModel(provider: provider)
            return viewModel
        }
    }
}

