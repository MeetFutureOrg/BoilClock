//
//  SettingsViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SettingsViewController: TableViewController {
    
    var viewModel: SettingsViewModel!
    var dataSource:RxTableViewSectionedReloadDataSource<SettingsSection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()

        languageChanged.subscribe(onNext: { [weak self] () in
            self?.navigationTitle = R.string.localizable.navigationTitleSettings.key.localized()
        }).disposed(by: rx.disposeBag)
        

        tableView.register(SettingsSwitchCell.self, forCellReuseIdentifier: Identifier.switchCellIdentifier)
        tableView.register(SettingsDisclosureCell.self, forCellReuseIdentifier: Identifier.disclosureCellIdentifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    
        let refresh = Observable.of(Observable.just(()),
                                    languageChanged.asObservable()).merge()
        
        let input = SettingsViewModel.Input(trigger: refresh,
                                            selection: tableView.rx.modelSelected(SettingsSectionItem.self).asDriver())
        let output = viewModel.transform(input: input)
        
        
        
        /// configure cell
        let dataSource = RxTableViewSectionedReloadDataSource<SettingsSection>(configureCell: { dataSource, tableView, indexPath, item in
            switch item {
            case .settingsDisclosureItem(let viewModel):
                
                let cell = (tableView.dequeueReusableCell(withIdentifier: Identifier.disclosureCellIdentifier, for: indexPath) as? SettingsDisclosureCell)!
                cell.bind(to: viewModel)
                return cell
            case .settingsSwitchItem(let viewModel):
                let cell = (tableView.dequeueReusableCell(withIdentifier: Identifier.switchCellIdentifier, for: indexPath) as? SettingsSwitchCell)!
                cell.bind(to: viewModel)
                return cell
            }
        }, titleForHeaderInSection: { dataSource, index in
            let section = dataSource[index]
            return section.title
        })
        
        self.dataSource = dataSource
        output.items.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output.selectedEvent.drive(onNext: { [weak self] (item) in
            switch item {
            case .settingsDisclosureItem(let viewModel):
                switch viewModel.type {
                case .theme:
                    if let destinationViewModel = viewModel.destinationViewModel as? ThemeViewModel {
                        self?.navigator.show(segue: .theme(viewModel: destinationViewModel), sender: self, transition: .navigation(type: .auto))
                    }
                case .language:
                    if let destinationViewModel = viewModel.destinationViewModel as? LanguageViewModel {
                        self?.navigator.show(segue: .language(viewModel: destinationViewModel), sender: self, transition: .navigation(type: .auto))
                    }
                case .icon:
                    if let destinationViewModel = viewModel.destinationViewModel as? IconViewModel {
                        self?.navigator.show(segue: .icon(viewModel: destinationViewModel), sender: self, transition: .navigation(type: .auto))
                    }

                default: break
                }
            default: break
            }
        }).disposed(by: rx.disposeBag)
    }
    
}

