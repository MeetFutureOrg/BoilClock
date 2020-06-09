//
//  UIColor+Dream.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import ChameleonFramework

extension UIColor {
    
    static func primary() -> UIColor {
        return flatBlack()
    }
    
    static func primaryDark() -> UIColor {
        return flatBlackDark()
    }
    
    static func secondary() -> UIColor {
        return flatRed()
    }
    
    static func secondaryDark() -> UIColor {
        return flatRedDark()
    }
    
    static func separator() -> UIColor {
        return flatBlackDark()
    }
    
    static func textBlack() -> UIColor {
        return flatBlackDark()
    }
    
    static func textWhite() -> UIColor {
        return white
    }
    
    static func textGray() -> UIColor {
        return .gray
    }
}

// MARK: Averaging a Color

extension UIColor {
    
    static func averageColor(fromImage image: UIImage) -> UIColor {
        return AverageColorFromImage(image)
    }
}

// MARK: Randomizing Colors

extension UIColor {
    
    static func randomColor() -> UIColor {
        return randomFlat()
    }
}
