//
//  ViewModelType.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    
    let provider: DreamAPI
    
    var page = 1
    
    init(provider: DreamAPI) {
        self.provider = provider
    }
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
    }
}
