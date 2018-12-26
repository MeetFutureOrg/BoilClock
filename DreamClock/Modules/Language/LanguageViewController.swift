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
    
        languageChanged.subscribe(onNext: { [weak self] () in
            self?.navigationTitle = R.string.localizable.settingsPreferencesLanguageNavigationTitle.key.localized()
        }).disposed(by: rx.disposeBag)
        
        tableView.register(LanguageCell.self, forCellReuseIdentifier: Identifier.languageCellIdentifier)
//        navigationTitle = "settings.preferences.language.navigation.title".localized()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let refresh = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        
        let input = LanguageViewModel.Input(trigger: refresh,
                                         selection: tableView.rx.modelSelected(LanguageSectionItem.self).asDriver())
        let output = viewModel.transform(input: input)
        
        /// configure cell
        let dataSource = RxTableViewSectionedReloadDataSource<LanguageSection>(configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case .languageItem(let viewModel):
                
                let cell = (tableView.dequeueReusableCell(withIdentifier: Identifier.languageCellIdentifier, for: indexPath) as? LanguageCell)!
                cell.bind(to: viewModel)
                return cell
            }
        })
        
        output.items.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
//        output.items
//            .drive(tableView.rx.items(cellIdentifier: Identifier.languageCellIdentifier, cellType: LanguageCell.self)) { tableView, viewModel, cell in
//                cell.bind(to: viewModel)
//            }.disposed(by: rx.disposeBag)
        
//        output.selected.drive(onNext: { [weak self] (cellViewModel) in

//                self?.navigationController?.popViewController(animated: true, {
//                    let viewModel = MainTabBarViewModel(loggedIn: true, provider: provider)
//                    self?.navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: Application.shared.window!))
//                    if let tabBarVC = Application.shared.window?.rootViewController as? MainTabBarController {
//                        tabBarVC.selectedIndex = 2
//                        if let strong = self {
//                            strong.showInfo(title: "settings.preferences.language.choose.hud.title".localized(), body: "settings.preferences.language.choose.hud.body".localized() + Language.displayName(for: Language.current()))
//
//                        }
//                    }
//            })
            
//        }).disposed(by: rx.disposeBag)
    }
}

