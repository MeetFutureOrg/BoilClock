//
//  Device+Extension.swift
//  DreamClock
//
//  Created by Sun on 2018/12/14.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import DeviceKit

public extension Device {
    
    /// All Taptic Engine Capable Devices
    public static var allTapticEngineCapableDevices: [Device] {
        return [.iPhone6s,
                .iPhone6sPlus,
                .iPhone7,
                .iPhone7Plus,
                .iPhoneSE,
                .iPhone8,
                .iPhone8Plus,
                .iPhoneX,
                .iPhoneXs,
                .iPhoneXsMax,
                .iPhoneXr]
    }
}
