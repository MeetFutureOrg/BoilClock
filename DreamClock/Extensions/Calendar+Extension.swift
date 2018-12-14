//
//  Calendar+Extension.swift
//  DreamClock
//
//  Created by Sun on 2018/12/13.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation

extension Calendar {
    enum Units: TimeInterval {
        case weeksOfYear
        case daysOfMonth
        var rawValue: TimeInterval {
            switch self {
            case .weeksOfYear:
                if let range = Calendar.current.range(of: .weekOfYear, in: .year, for: Date()) {
                    return TimeInterval(range.count)
                }
                return 52
            case .daysOfMonth:
                if let range = Calendar.current.range(of: .day, in: .month, for: Date()) {
                    return TimeInterval(range.count)
                }
                return 30
            }
        }
    }
}
