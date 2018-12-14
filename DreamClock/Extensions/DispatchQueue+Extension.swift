//
//  DispatchQueue+Extension.swift
//  DreamClock
//
//  Created by Sun on 2018/12/12.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation

extension DispatchQueue {
    class func mainSafeAsync(_ execute: @escaping (() -> ())) {
        if Thread.isMainThread {
            execute()
        } else {
            self.main.async(execute: execute)
        }
    }
}
