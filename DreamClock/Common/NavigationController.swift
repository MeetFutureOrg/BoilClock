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
        

        
        
//        hero.isEnabled = true
//        hero.modalAnimationType = .autoReverse(presenting: .fade)
//        hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .left))
        
//        navigationBar.isTranslucent = false
        
        //        navigationBar.backIndicatorImage = R.image.icon_navigation_back()
        //        navigationBar.backIndicatorTransitionMaskImage = R.image.icon_navigation_back()
        navigationBar.theme.tintColor = themeService.attribute { $0.secondary }
        navigationBar.theme.barTintColor = themeService.attribute { $0.primaryDark }
        navigationBar.theme.titleTextAttributes = themeService.attribute { [NSAttributedString.Key.foregroundColor: $0.text] }
    }
}

extension NavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 { viewController.hidesBottomBarWhenPushed = true }
        super.pushViewController(viewController, animated: animated)
    }
}
