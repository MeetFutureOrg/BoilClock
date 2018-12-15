//
//  SoundManager.swift
//  DreamClock
//
//  Created by Sun on 2018/12/14.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import AudioToolbox

public class Sound {
    
    public static var isEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey:  Configs.UserDefaultsKeys.soundTrigger)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Configs.UserDefaultsKeys.soundTrigger)
        }
    }
    
    public static func play(_ url: URL) {
        var soundID: SystemSoundID = 2000
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        
    }
}
