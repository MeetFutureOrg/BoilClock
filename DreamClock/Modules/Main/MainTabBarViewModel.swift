//
//  MainTabBarViewModel.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
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
        
        
        let tabBarItems = loggedIn.map { _ -> [MainTabBarItem] in
            return [.events, .alarm, .records, .settings]
            }.asDriver(onErrorJustReturn: [])
        
        return Output(tabBarItems: tabBarItems)
    }
    
    func viewModel(for tabBarItem: MainTabBarItem) -> ViewModel {
        switch tabBarItem {
        case .events:   return EventsViewModel(provider: provider)
        case .alarm:    return AlarmViewModel(provider: provider)
        case .records:  return RecordsViewModel(provider: provider)
        case .settings: return SettingsViewModel(provider: provider)
            
        }
    }
}

