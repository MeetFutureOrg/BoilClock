//
//  RxIGListKit.swift
//  DreamClock
//
//  Created by Sun on 2018/12/13.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import IGListKit
import RxCocoa
import RxSwift

protocol RxListAdapterDataSource {
    associatedtype Element
    func listAdapter(_ adapter: ListAdapter, observedEvent: Event<Element>) -> Void
}

extension Reactive where Base: ListAdapter {
    func items<DataSource: RxListAdapterDataSource & ListAdapterDataSource, O: ObservableType>(dataSource: DataSource)
        -> (_ source: O)
        -> Disposable where DataSource.Element == O.Element {
            
            return { source in
                let subscription = source
                    .subscribe { dataSource.listAdapter(self.base, observedEvent: $0) }
                
                return Disposables.create {
                    subscription.dispose()
                }
            }
    }
    
    func setDataSource<DataSource: RxListAdapterDataSource & ListAdapterDataSource>(_ dataSource: DataSource) -> Disposable {
        base.dataSource = dataSource
        return Disposables.create()
    }
}
