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

class LanguageViewController: TableViewController {

    var viewModel: LanguageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func makeUI() {
        super.makeUI()
        
        print(R.string.localizable.settingsPreferencesLanguageNavigationTitle())
        navigationTitle = R.string.localizable.settingsPreferencesLanguageNavigationTitle()
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

                self?.navigationController?.popViewController(animated: true, {
                    let viewModel = MainTabBarViewModel(loggedIn: true, provider: provider)
                    self?.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: Application.shared.window!))
                    if let tabBarVC = Application.shared.window?.rootViewController as? MainTabBarController {
                        tabBarVC.selectedIndex = 2
                        if let strong = self {
                            
                                strong.showInfo(title: R.string.localizable.settingsPreferencesLanguageChooseHudTitle(), body: R.string.localizable.settingsPreferencesLanguageChooseHudBody() + Language.displayNameForLanguage(Language.currentLanguage()))

                        }
                    }
            })
            
        }).disposed(by: rx.disposeBag)
    }
}

