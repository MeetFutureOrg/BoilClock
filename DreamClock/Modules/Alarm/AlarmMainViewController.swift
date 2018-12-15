//
//  AlarmMainViewController.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import IGListKit

class AlarmMainViewController: ViewController {
    
    var viewModel: AlarmViewModel!
    
    lazy private var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    }()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func makeUI() {
        super.makeUI()
        navigationTitle = R.string.localizable.navigationTitleAlarm().localized()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        
        rx.viewDidLayoutSubviews.asDriver()
            .drive(onNext: { [unowned self] _ in
                self.collectionView.frame = self.view.bounds
            }).disposed(by: rx.disposeBag)
        
        adapter.rx.setDataSource(dataSource)
            .disposed(by: rx.disposeBag)
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationTitle = "navigation.title.alarm".localized()
    }
    
    
    final class DataSource: NSObject, ListAdapterDataSource, RxListAdapterDataSource {
        
        typealias Element = [Alarm]
        
        var elements: Element = []
        
        func listAdapter(_ adapter: ListAdapter, observedEvent: Event<[Alarm]>) {
            if case .next(let alarms) = observedEvent {
                elements = alarms
                adapter.performUpdates(animated: true)
            }
        }
        
        func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
            return elements
        }
        
        func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
            return AlarmListController()
        }
        
        func emptyView(for listAdapter: ListAdapter) -> UIView? {
            return nil
        }
    }
    
}
