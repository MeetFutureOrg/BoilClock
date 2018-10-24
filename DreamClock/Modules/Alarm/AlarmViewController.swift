//
//  AlarmViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AlarmViewController: TableViewController {
    
    var viewModel: AlarmViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func makeUI() {
        super.makeUI()
        navigationTitle = "navigation.title.alarm".localized()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
}
