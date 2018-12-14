//
//  AlarmSchedulerProtocol.swift
//  DreamClock
//
//  Created by Sun on 2018/12/12.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import UserNotifications

protocol AlarmSchedulerProtocol {
    func setNotification(_ date: Date, onWeekdaysForNotify:[Int], snooze: Bool, onSnooze:Bool, soundName: String, index: Int)
    func setNotificationForSnooze(snoozeMinute: Int, soundName: String, index: Int)
    func setNotificationSettings()
    func reschedule()
    func checkNotification()
}
