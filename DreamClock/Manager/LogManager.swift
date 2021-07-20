//
//  LogManager.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import CocoaLumberjack

public func logDebug(_ message: @autoclosure () -> String) {
    DDLog(.debug, .debug, message)
}

public func logError(_ message: @autoclosure () -> String) {
    DDLog(.error, .error, message)
}

public func logInfo(_ message: @autoclosure () -> String) {
    DDLog(.info, .info, message)
}

public func logVerbose(_ message: @autoclosure () -> String) {
    DDLog(.verbose, .verbose, message)
}

public func logWarn(_ message: @autoclosure () -> String) {
    DDLog(.warning, .warning, message)
}

private func DDLog(_ level: DDLogLevel, _ flag: DDLogFlag, _ message: () -> String) {
    let args: [CVarArg] = [message()]
    withVaList(args) {
        DDLog.sharedInstance.log(asynchronous: true, level: .debug, flag: .debug, context: 0, file: #file, function: #function, line: #line, tag: nil, format: "%s", arguments: $0)
    }
}
