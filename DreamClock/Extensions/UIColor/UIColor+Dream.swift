//
//  UIColor+Dream.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import SwifterSwift

extension UIColor {
    
    static func primary() -> UIColor {
        return FlatUI.midnightBlue
    }
    
    static func primaryDark() -> UIColor {
        return FlatUI.wetAsphalt
    }
    
    static func secondary() -> UIColor {
        return FlatUI.alizarin
    }
    
    static func secondaryDark() -> UIColor {
        return FlatUI.pomegranate
    }
    
    static func separator() -> UIColor {
        return FlatUI.wetAsphalt
    }
    
    static func textBlack() -> UIColor {
        return FlatUI.wetAsphalt
    }
    
    static func textWhite() -> UIColor {
        return white
    }
    
    static func textGray() -> UIColor {
        return .gray
    }
}

// MARK: Randomizing Colors

extension UIColor {
    
    static func randomColor() -> UIColor {
        return .random
    }
}
