//
//  IconViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/12/18.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class IconViewController: TableViewController {

    
    var viewModel: IconViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationTitle = "settings.personalization.icon.navigation.title".localized()
        tableView.register(IconCell.self, forCellReuseIdentifier: Identifier.iconCellIdentifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = IconViewModel.Input(trigger: Observable.just(()),
                                         selection: tableView.rx.modelSelected(IconCellViewModel.self).asDriver())
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(tableView.rx.items(cellIdentifier: Identifier.iconCellIdentifier, cellType: IconCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }.disposed(by: rx.disposeBag)
        
        output.selected.drive(onNext: { [weak self] (cellViewModel) in
//            self?.navigationController?.popViewController(animated: true, {
//                self?.showInfo(title: "settings.preferences.theme.choose.hud.title".localized(), body: "settings.preferences.theme.choose.hud.body".localized() + cellViewModel.theme.title)
//            })
        }).disposed(by: rx.disposeBag)
    }

}
