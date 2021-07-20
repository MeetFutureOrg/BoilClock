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

//tableView代理实现
extension LanguageViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

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
    }
}

