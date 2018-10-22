//
//  NavigationController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hero.isEnabled = true
        hero.modalAnimationType = .autoReverse(presenting: .fade)
        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))
        
//        navigationBar.isTranslucent = false
        hidesBottomBarWhenPushed = true
        //        navigationBar.backIndicatorImage = R.image.icon_navigation_back()
        //        navigationBar.backIndicatorTransitionMaskImage = R.image.icon_navigation_back()
        
    }
}
