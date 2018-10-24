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

class LanguageViewController: TableViewController {

    var viewModel: LanguageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    
    override func makeUI() {
        super.makeUI()
        navigationTitle = "settings.preferences.language.navigation.title".localized()
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
            self?.navigator.pop(sender: self)
        }).disposed(by: rx.disposeBag)
    }
    

}
