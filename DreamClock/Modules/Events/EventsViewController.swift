//
//  EventsViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EventsViewController: TableViewController {
    
    var viewModel: EventsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        languageChanged.subscribe(onNext: { [weak self] () in
            self?.navigationTitle = R.string.localizable.navigationTitleEvents.key.localized()
        }).disposed(by: rx.disposeBag)
    }
}
