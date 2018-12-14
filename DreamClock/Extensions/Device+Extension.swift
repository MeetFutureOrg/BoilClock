//
//  Device+Extension.swift
//  DreamClock
//
//  Created by Sun on 2018/12/14.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import DeviceKit

public extension Device {
    
    /// device support feedback level
    public enum Level {
        /// include iPhone6s and iPhone6s Plus
        case early
        /// after iPhone7, iPhone7 Plus....
        case improved
        /// before iPhone6s/iPhone6s Plus, and iPad ...
        case unsupported
    }
    
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
    
    /// Returns whether or not the device has Taptic Engine
    public var isTapticEngineCapable: Bool {
        return isOneOf(Device.allTapticEngineCapableDevices)
    }
    
    public var feedbackLevel: Level {
        if isTapticEngineCapable {
            switch self {
            case .iPhone6s, .iPhone6sPlus:
                return .early
            default:
                return .improved
            }
        }
        return .unsupported
    }
    
}

extension Device.Level: Equatable {
    
    /// Compares two devices feedback level
    ///
    /// - parameter lhs: A Level.
    /// - parameter rhs: Another Level.
    ///
    /// - returns: `true` iff the underlying identifier is the same.
    public static func == (lhs: Device.Level, rhs: Device.Level) -> Bool {
        return lhs.description == rhs.description
    }
}

extension Device.Level: CustomStringConvertible {
    /// A textual representation of the device.
    public var description: String {
        switch self {
        case .early: return "early"
        case .improved: return "improved"
        case .unsupported: return "unsupported"
        }
    }
}
