//
//  LanguageViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwifterSwift
import Localize_Swift

class LanguageViewController: TableViewController {

    var viewModel: LanguageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func makeUI() {
        super.makeUI()
        navigationTitle = R.string.localizable.settingsPreferencesLanguageNavigationTitle().localized()
        tableView.register(LanguageCell.self, forCellReuseIdentifier: Identifier.languageCellIdentifier)
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = LanguageViewModel.Input(trigger: Observable.just(()),
                                         selection: tableView.rx.modelSelected(LanguageCellViewModel.self).asDriver())
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(tableView.rx.items(cellIdentifier: Identifier.languageCellIdentifier, cellType: LanguageCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }.disposed(by: rx.disposeBag)
        
        output.selected.drive(onNext: { [weak self] (cellViewModel) in
//            self?.startAnimating()
//            SwifterSwift.delay(milliseconds: 3000, completion: {
//                self?.stopAnimating()
                self?.navigationController?.popViewController(animated: true, {
                    let viewModel = MainTabBarViewModel(loggedIn: true, provider: provider)
                    self?.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: Application.shared.window!))
                    if let tabBarVC = Application.shared.window?.rootViewController as? MainTabBarController {
                        tabBarVC.selectedIndex = 2
                        if let strong = self {
//                            SwifterSwift.delay(milliseconds: 3000, completion: {
                            
                                strong.showInfo(title: R.string.localizable.settingsPreferencesLanguageChooseHudTitle().localized(), body: R.string.localizable.settingsPreferencesLanguageChooseHudBody().localized() + Localize.displayNameForLanguage(Localize.currentLanguage()))
//                            })
                        }
                    }
//                })
            })
            
        }).disposed(by: rx.disposeBag)
    }
}

extension LanguageViewController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}
