//
//  Application.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class Application {
    
    static let shared = Application()
    var window: UIWindow?
    let navigator: Navigator
    
    private init() {
        navigator = Navigator.default
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        let viewModel = MainTabBarViewModel(loggedIn: true, provider: provider)
        navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: window))
    }
}
