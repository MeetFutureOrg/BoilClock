//
//  Navigator.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import Hero


protocol Navigatable {
    var navigator: Navigator! { get set }
}

class Navigator {
    static var `default` = Navigator()
    // MARK: - scene list, all app scenes
    enum Scene {
        case tabs(viewModel: MainTabBarViewModel)
        case theme(viewModel: ThemeViewModel)
        case language(viewModel: LanguageViewModel)
        case icon(viewModel: IconViewModel)
    }
    
    enum Transition {
        case root(in: UIWindow)
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }
    
    // MARK: - get a single VC
    func get(segue: Scene) -> UIViewController {
        switch segue {
        case .tabs(let viewModel):
            let tabRootVC = R.storyboard.main.mainTabBarController()!
            tabRootVC.navigator = self
            tabRootVC.viewModel = viewModel
            return tabRootVC
        case .theme(let viewModel):
            let themeVC = R.storyboard.main.themeViewController()!
            themeVC.navigator = self
            themeVC.viewModel = viewModel
            return themeVC
        case .language(let viewModel):
            let languageVC = R.storyboard.main.languageViewController()!
            languageVC.navigator = self
            languageVC.viewModel = viewModel
            return languageVC
        case let .icon(viewModel):
            let iconVC = R.storyboard.main.iconViewController()!
            iconVC.navigator = self
            iconVC.viewModel = viewModel
            return iconVC
        }
    }
    
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController()
        }
    }
    
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func injectTabBarControllers(in target: UITabBarController) {
        if let children = target.viewControllers {
            for vc in children {
                injectNavigator(in: vc)
            }
        }
    }
    
    // MARK: - invoke a single scene
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        let target = get(segue: segue)
        show(target: target, sender: sender, transition: transition)
    }
    
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        injectNavigator(in: target)
        
        switch transition {
        case .root(in: let window):
            window.rootViewController = target
//            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {

//            }, completion: nil)
            return
        case .custom: return
        default: break
        }
        
        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }
        
        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }
        
        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                //add controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .customModal(let type):
            //present modally with custom animation
            DispatchQueue.main.async {
                
                let nav = NavigationController(rootViewController: target)
                nav.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(nav, animated: true, completion: nil)
            }
            
            
        case .modal:
            //present modally
            DispatchQueue.main.async {
                let nav = NavigationController(rootViewController: target)
                sender.present(nav, animated: true, completion: nil)
            }
        case .detail:
            let nav = NavigationController(rootViewController: target)
            sender.showDetailViewController(nav, sender: nil)
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }
    
    private func injectNavigator(in target: UIViewController) {
        // view controller
        if var target = target as? Navigatable {
            target.navigator = self
            return
        }
        
        // navigation controller
        if let target = target as? UINavigationController, let root = target.viewControllers.first {
            injectNavigator(in: root)
        }
    }
}
