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

    case events
    case clock
    case settings
    
    func controller(with viewModel: ViewModel) -> UIViewController {
        switch self {
        case .events:
            let vc = R.storyboard.main.eventsViewController()!
            vc.viewModel = viewModel as? EventsViewModel
            return NavigationController(rootViewController: vc)
        case .clock:
            let vc = R.storyboard.main.clockViewController()!
            vc.viewModel = viewModel as? ClockViewModel
            return NavigationController(rootViewController: vc)
        case .settings:
            let vc = R.storyboard.main.settingsViewController()!
            vc.viewModel = viewModel as? SettingsViewModel
            return NavigationController(rootViewController: vc)
        }
        
    }
    
    func getController(with viewModel: ViewModel) -> UIViewController {
        let vc = controller(with: viewModel)
        let item = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        
//        _ = themeService.rx
//            .bind({ $0.text }, to: item.rx.titleColor)
//            .bind({ $0.secondary }, to: item.rx.titleSelectedColor)
        
        vc.tabBarItem = item
        return vc
    }
    
    var image: UIImage? {
        switch self {
        case .events:   return R.image.dc_ic_calendar_add_outline_24_24x24_()
        case .clock:    return R.image.dc_ic_clock_outline_24_24x24_()
        case .settings: return R.image.dc_ic_settings_outline_24_24x24_()
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .events:   return R.image.dc_ic_calendar_add_filled_24_24x24_()
        case .clock:    return R.image.dc_ic_clock_filled_24_24x24_()
        case .settings: return R.image.dc_ic_settings_internal_filled_24_24x24_()
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
        hero.tabBarAnimationType = .zoomOut
        tabBar.hero.id = "TabBarID"
//        tabBar.isTranslucent = false
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
