//
//  ThemeViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/24.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

extension ThemeViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

class ThemeViewController: TableViewController {
    
    var viewModel: ThemeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        navigationTitle = "settings.preferences.theme.navigation.title".localized()
        tableView.register(ThemeCell.self, forCellReuseIdentifier: Identifier.themeCellIdentifier)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = ThemeViewModel.Input(refresh: Observable.just(()),
                                         selection: tableView.rx.modelSelected(ThemeCellViewModel.self).asDriver())
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(tableView.rx.items(cellIdentifier: Identifier.themeCellIdentifier, cellType: ThemeCell.self)) { tableView, viewModel, cell in
                cell.bind(to: viewModel)
            }.disposed(by: rx.disposeBag)
        
        output.selected.drive(onNext: { [weak self] (cellViewModel) in
            self?.navigationController?.popViewController(animated: true, {
                self?.showInfo(title: "settings.preferences.theme.choose.hud.title".localized(), body: "settings.preferences.theme.choose.hud.body".localized() + cellViewModel.theme.title)
            })
        }).disposed(by: rx.disposeBag)
    }

}
