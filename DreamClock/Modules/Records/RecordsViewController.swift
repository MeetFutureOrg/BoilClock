//
//  RecordsViewController.swift
//  DreamClock
//
//  Created by Kystar's Mac Book Pro on 2021/7/20.
//  Copyright © 2021 FlyWake Studio. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources
import IGListKit

class RecordsViewController: ViewController {

    var viewModel: RecordsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
        languageChanged.subscribe(onNext: { [weak self] () in
            self?.navigationTitle = R.string.localizable.navigationTitleRecords.key.localized()
        }).disposed(by: rx.disposeBag)
    }

}
