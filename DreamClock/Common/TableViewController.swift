//
//  TableViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: ViewController, UIScrollViewDelegate {

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.emptyDataSetSource = self
        view.emptyDataSetDelegate = self
        view.rx.setDelegate(self).disposed(by: rx.disposeBag)
        return view
    }()
    
    var clearsSelectionOnViewWillAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if clearsSelectionOnViewWillAppear == true {
            deselectSelectedRow()
        }
    }
    
    override func makeUI() {
        super.makeUI()
        
        stackView.spacing = 0
        stackView.addArrangedSubview(tableView)
        tableView.backgroundColor = .clear
        
        let updateEmptyDataSet = Observable.of(isLoading.mapToVoid().asObservable(), emptyDataSetImageTintColor.mapToVoid()).merge()
        updateEmptyDataSet.subscribe(onNext: { [weak self] () in
            self?.tableView.reloadEmptyDataSet()
        }).disposed(by: rx.disposeBag)
        
        themeService.rx
            .bind({ $0.separator }, to: tableView.rx.separatorColor)
            .disposed(by: rx.disposeBag)
    }
    
    override func updateUI() {
        super.updateUI()
    }
}

extension TableViewController {
    
    func deselectSelectedRow() {
        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
            selectedIndexPaths.forEach({ (indexPath) in
                tableView.deselectRow(at: indexPath, animated: false)
            })
        }
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            themeService.rx
                .bind({ $0.text }, to: view.textLabel!.rx.textColor)
                .disposed(by: rx.disposeBag)
        }
    }
}
