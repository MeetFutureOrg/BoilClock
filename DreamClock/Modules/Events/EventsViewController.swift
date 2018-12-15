//
//  EventsViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

class EventsViewController: TableViewController {
    
    var viewModel: EventsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            self.showInfo(title: Language.current(), body: nil)
        }
    }
    
    override func makeUI() {
        super.makeUI()
        navigationTitle = R.string.localizable.navigationTitleEvents()
    }
}
