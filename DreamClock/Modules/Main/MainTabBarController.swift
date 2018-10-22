//
//  MainTabBarController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift

let provider = API.shared

enum MainTabBarItem: Int {
    case clock
    func controller(with viewModel: ViewModel) -> UIViewController {
        switch self {
        case .clock:
            let vc = ClockViewController()
            vc.viewModel = viewModel as? ClockViewModel
            return NavigationController(rootViewController: vc)
        }
    }
    
    func getController(with viewModel: ViewModel) -> UIViewController {
        let vc = controller(with: viewModel)
        let item = UITabBarItem(title: nil, image: image, tag: rawValue)
        
        _ = themeService.rx
            .bind({ $0.text }, to: item.rx.titleColor)
            .bind({ $0.secondary }, to: item.rx.titleSelectedColor)
        
        vc.tabBarItem = item
        return vc
    }
    
    var image: UIImage? {
        switch self {
        case .clock: return R.image.icon_tabbar_clock()
        }
    }
}

class MainTabBarController: UITabBarController, Navigatable {
    
    var viewModel: MainTabBarViewModel!
    var navigator: Navigator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    func setup() {
        // Configure tab bar
        hero.isEnabled = true
        tabBar.hero.id = "TabBarID"
        tabBar.isTranslucent = false
        
        themeService.rx
            .bind({ $0.secondary }, to: tabBar.rx.tintColor)
            .disposed(by: rx.disposeBag)
    }
    
    func bindViewModel() {
        let input = MainTabBarViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.tabBarItems.drive(onNext: { [weak self] (tabBarItems) in
            if let strongSelf = self {
                let controllers = tabBarItems.map({ item in
                    item.getController(with: strongSelf.viewModel.viewModel(for: item))
                })
                strongSelf.setViewControllers(controllers, animated: false)
            }
        }).disposed(by: rx.disposeBag)
    }
}
