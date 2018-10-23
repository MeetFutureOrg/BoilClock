//
//  UIFont+Dream.swift
//  DreamClock
//
//  Created by Sun on 2018/10/23.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UIKit

// MARK: DreamClock Fonts

extension UIFont {
    
    static func navigationTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }
    
    static func titleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 17.0)
    }
    
    static func descriptionFont() -> UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }
}

// MARK: All Fonts

extension UIFont {
    
    static func allSystemFontsNames() -> [String] {
        var fontsNames = [String]()
        let fontFamilies = UIFont.familyNames
        for fontFamily in fontFamilies {
            let fontsForFamily = UIFont.fontNames(forFamilyName: fontFamily)
            for fontName in fontsForFamily {
                fontsNames.append(fontName)
            }
        }
        return fontsNames
    }
}

// MARK: Randomizing Fonts

extension UIFont {
    
    static func randomFont(ofSize size: CGFloat) -> UIFont {
        let allFontsNames = UIFont.allSystemFontsNames()
        let randomFontIndex = Int.random(in: 0..<allFontsNames.count)
        let randomFontName = allFontsNames[randomFontIndex]
        return UIFont(name: randomFontName, size: size)!
    }
}

