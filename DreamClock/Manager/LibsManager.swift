//
//  LibsManager.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import SnapKit
import IQKeyboardManagerSwift
import CocoaLumberjack
import Kingfisher
import FLEX
import NVActivityIndicatorView
import NSObject_Rx
import RxViewController
import RxSwift
import RxOptional
import RxGesture
import SwifterSwift
import SwiftDate
import Hero
import SwiftMessages
import netfox

struct LibsManager {
    
    static let shared = LibsManager()
    private let disposeBag = DisposeBag()
    
    func setupLibs(with window: UIWindow) {
        let libsManager = LibsManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupTheme(with: window)
        libsManager.setupKeyboardManager()
        libsManager.setupActivityView()
        libsManager.setupLanguageService()
#if DEBUG
        libsManager.setupFLEX()
        libsManager.setupNetfox()
#endif
    }
    
    func setupLanguageService() {
//        Language.languageService.observeLanguageChange()
    }
    
    func setupTheme(with window: UIWindow) {
        
        themeService.rx
            .bind({ $0.statusBarStyle }, to: UIApplication.shared.rx.statusBarStyle)
            .disposed(by: disposeBag)
   
    }
    
    func setupActivityView() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballRotateChase
        NVActivityIndicatorView.DEFAULT_COLOR = .secondary()
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
    }
    
    func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.maxDiskCacheSize = UInt(500 * 1024 * 1024) // 500 MB
        
        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.maxCachePeriodInSecond = TimeInterval(60 * 60 * 24 * 7) // 1 week
        
        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
    
    func setupCocoaLumberjack() {
        DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }
    
    func setupFLEX() {
        FLEXManager.shared().isNetworkDebuggingEnabled = true
    }
    
    func setupNetfox() {
        NFX.sharedInstance().start()
    }
   
}

extension LibsManager {
    
    func showFlex() {
        FLEXManager.shared().showExplorer()
    }
    
    func removeKingfisherCache(completion handler: (() -> Void)?) {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache {
            handler?()
        }
    }
}

