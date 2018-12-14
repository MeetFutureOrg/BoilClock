//
//  AppDelegate.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit
import RxSwift
import AudioToolbox
import AVFoundation
import UserNotifications
import UserNotificationsUI
import SwifterSwift
import Localize_Swift
import SwiftMessages

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    var window: UIWindow?
    private var center: UNUserNotificationCenter = {
        return .current()
    }()
    private var defaults: Defaults {
        return Defaults.shared
    }
    
    var audioPlayer: AVAudioPlayer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var error: NSError?
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
        } catch let error1 as NSError{
            error = error1
            fatalError("could not set session. err:\(error!.localizedDescription)")
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error1 as NSError{
            error = error1
            fatalError("could not active session. err:\(error!.localizedDescription)")
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else { return false }
        
        let libsManager = LibsManager.shared
        libsManager.setupLibs(with: window)
        
        // Show initial screen
        Application.shared.presentInitialScreen(in: window)
        window.makeKeyAndVisible()
        
        authorizeNotificationPermission()
        
        
        return true
    }
    
    // Notification
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        requestNotificationAuthorizationStatus()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}



extension AppDelegate: UNUserNotificationCenterDelegate {
    
    /// app 在后台时接到通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    /// app 在后台接到通知时, 处理小睡动作
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
}

extension AppDelegate: AlarmApplicationProtocol {
    func playSound(_ name: String) {
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        AudioServicesAddSystemSoundCompletion(SystemSoundID(kSystemSoundID_Vibrate),nil,
                                              nil,
                                              { (_:SystemSoundID, _:UnsafeMutableRawPointer?) -> Void in
                                                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        },
                                              nil)
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!)
        
        var error: NSError?
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        
        guard let audioPlayer = audioPlayer else { return }
        
        if let err = error {
            print("audioPlayer error \(err.localizedDescription)")
            return
        } else {
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

extension AppDelegate: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        
    }
}


extension AppDelegate {

    class func isFirstLaunch() -> Bool {
        
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: Configs.UserDefaultsKeys.hasBeenLaunched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: Configs.UserDefaultsKeys.hasBeenLaunched)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    class func isFirstLaunchOfNewVersion() -> Bool {
        
        guard let infoDictionary = Bundle.main.infoDictionary else { return true }
        guard let majorVersion = infoDictionary[Configs.UserDefaultsKeys.mojorVersion] as? String else { return true }
        
        
        let lastLaunchVersion = UserDefaults.standard.string(forKey:
            Configs.UserDefaultsKeys.hasBeenLaunchedOfNewVersion)
        
        let isFirstLaunchOfNewVersion = majorVersion != lastLaunchVersion
        if isFirstLaunchOfNewVersion {
            UserDefaults.standard.set(majorVersion, forKey:
                Configs.UserDefaultsKeys.hasBeenLaunchedOfNewVersion)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunchOfNewVersion
    }
}

extension AppDelegate {
    
    private func authorizeNotificationPermission() {
        center.requestAuthorization(options: [.sound, .alert]) { [unowned self] (granted, error) in
            if !granted {
                DispatchQueue.mainSafeAsync {
                    if let rootVC = self.window?.rootViewController {
                        let title = R.string.localizable.applicationNotificationPermissionDenyHudTitle().localized()
                        let body = R.string.localizable.applicationNotificationPermissionDenyHudBody().localized()
                        let buttonTitle = R.string.localizable.applicationNotificationPermissionDenyHudRedirectionTitle().localized()
                        rootVC.showError(title: title, body: body, duration: .forever, buttonTitle: buttonTitle, buttonTapHandler: { [weak self] _ in
                            self?.openAppSettings()
                        })
                    }
                }
            }
        }
    }
    
    private func openAppSettings() {
        let url = URL(string: UIApplication.openSettingsURLString)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    private func requestNotificationAuthorizationStatus() {
        center.getNotificationSettings { [unowned self] (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                DispatchQueue.main.async {
                    if let rootVC = self.window?.rootViewController {
                        rootVC.hideAllMessage()
                    }
                }
            default:
                self.authorizeNotificationPermission()
            }
        }
    }
    
    private func authorizeSucceed() {
        DispatchQueue.mainSafeAsync {
            if let rootVC = self.window?.rootViewController {
                let title = R.string.localizable.applicationNotificationPermissionAllowedHudTitle().localized()
                let body = R.string.localizable.applicationNotificationPermissionAllowedHudTitle().localized()
                rootVC.showSuccess(title: title, body: body)
            }
        }
    }
}
