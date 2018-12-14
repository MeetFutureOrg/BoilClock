//
//  AlarmScheduler.swift
//  DreamClock
//
//  Created by Sun on 2018/12/13.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import Foundation
import UserNotifications
import SwiftDate

class AlarmScheduler: AlarmSchedulerProtocol {
    
    var alarmModel = Alarms()

    /// 实现 AlarmSchedulerProtocol 相关方法
    func setNotification(_ date: Date, onWeekdaysForNotify weekdays: [Int], snooze: Bool, onSnooze: Bool, soundName: String, index: Int) {
        
        /// 构造通知内容
        let content = UNMutableNotificationContent()
        content.body = Configs.Notification.defaultBody
        content.sound = UNNotificationSound(named: UNNotificationSoundName(soundName + ".mp3"))
        content.categoryIdentifier = Configs.Notification.alarmCategoryIdentifier
        let repeating = !weekdays.isEmpty
        content.userInfo = ["snooze": snooze, "index": index, "soundName": soundName, "repeating": repeating]
    
        /// 如果选择了工作日, 那么每周重复
        /// 阀门
        var trigger: UNTimeIntervalNotificationTrigger?
        if !weekdays.isEmpty && !onSnooze {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Calendar.Units.weeksOfYear.rawValue, repeats: true)
        }
        
        /// 构造通知
        var alarmNotification = UNNotificationRequest(identifier: Configs.Notification.alarmNotificationRequestIdentifier, content: content, trigger: trigger)
        
        /// 修正日期
        let datesForNotification = amendmentDate(date, onWeekdaysForNotify:weekdays)
        
        ///
        syncAlarm()
        
        for d in datesForNotification {
            if onSnooze {
                alarmModel.alarms[index].date = AlarmScheduler.amendmentSecondComponent(date: alarmModel.alarms[index].date)
            } else {
                alarmModel.alarms[index].date = d
            }
            
            
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(Calendar.current.range(of: .weekOfYear, in: .year, for: d)?.count ?? 52), repeats: true)
            alarmNotification = UNNotificationRequest(identifier: Configs.Notification.alarmNotificationRequestIdentifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(alarmNotification) { (error) in
                if let error = error {
                    print("error = \(error.localizedDescription)")
                }
            }
        }
        setNotificationSettings()
    }
    
    func setNotificationSettings() {
        var snoozeEnabled: Bool = false
        UNUserNotificationCenter.current().getPendingNotificationRequests { [unowned self] (request) in
            if let result = self.latestTriggerWith(notificationRequests: request) {
                let i = result.1
                snoozeEnabled = self.alarmModel.alarms[i].snoozeEnabled
            }
        }
       
        /// 指定通知类型
        let authorizationOptions: UNAuthorizationOptions = [.alert, .sound]
        
        /// 指定通知动作
        let stopAction = UNNotificationAction(identifier: Configs.Notification.alarmStopActionIdentifier, title: "OK", options: [.destructive])
        
        let snoozeAction = UNNotificationAction(identifier: Configs.Notification.alarmSnoozeActionIdentifier, title: "Snooze", options: [.destructive])
        
        /// 假如小睡没开, 那么不显示此按钮
        let actionsArray = snoozeEnabled ? [UNNotificationAction](arrayLiteral: snoozeAction, stopAction) : [UNNotificationAction](arrayLiteral: stopAction)
        
        /// 指定上边动作关联的 category
        let alarmCategory = UNNotificationCategory(identifier: Configs.Notification.alarmCategoryIdentifier, actions: actionsArray, intentIdentifiers: [Configs.Notification.alarmSnoozeActionIdentifier, Configs.Notification.alarmStopActionIdentifier], options: [.customDismissAction])
        
        UNUserNotificationCenter.current().setNotificationCategories(Set(arrayLiteral: alarmCategory))
        /// 注册通知设置
        UNUserNotificationCenter.current().requestAuthorization(options: authorizationOptions) { (granted, error) in
            if granted {
                print("允许推送")
            }
        }
    }
    
    private func amendmentDate(_ date: Date, onWeekdaysForNotify weekdays:[Int]) -> [Date] {
        var correctedDate: [Date] = [Date]()
        let calendar = Calendar(identifier: Calendar.Identifier.republicOfChina)
        let now = Date()
        let flags: NSCalendar.Unit = [NSCalendar.Unit.weekday, NSCalendar.Unit.weekdayOrdinal, NSCalendar.Unit.day]
        let dateComponents = (calendar as NSCalendar).components(flags, from: date)
        let weekday:Int = dateComponents.weekday!
        
        //no repeat
        if weekdays.isEmpty{
            //scheduling date is eariler than current date
            if date < now {
                //plus one day, otherwise the notification will be fired righton
                correctedDate.append((calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: 1, to: date, options:.matchStrictly)!)
            }
            else { //later
                correctedDate.append(date)
            }
            return correctedDate
        }
            //repeat
        else {
            let daysInWeek = 7
            correctedDate.removeAll(keepingCapacity: true)
            for wd in weekdays {
                
                var wdDate: Date!
                //schedule on next week
                if compare(weekday: wd, with: weekday) == .before {
                    wdDate =  (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: wd+daysInWeek-weekday, to: date, options:.matchStrictly)!
                }
                    //schedule on today or next week
                else if compare(weekday: wd, with: weekday) == .same {
                    //scheduling date is eariler than current date, then schedule on next week
                    if date.compare(now) == ComparisonResult.orderedAscending {
                        wdDate = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: daysInWeek, to: date, options:.matchStrictly)!
                    }
                    else { //later
                        wdDate = date
                    }
                }
                    //schedule on next days of this week
                else { //after
                    wdDate =  (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: wd-weekday, to: date, options:.matchStrictly)!
                }
                
                //fix second component to 0
                wdDate = AlarmScheduler.amendmentSecondComponent(date: wdDate, calendar: calendar)
                correctedDate.append(wdDate)
            }
            return correctedDate
        }
    }
    
    public static func amendmentSecondComponent(date: Date, calendar: Calendar = Calendar(identifier: Calendar.Identifier.republicOfChina))->Date {
        let second = calendar.component(.second, from: date)
        let d = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.second, value: -second, to: date, options:.matchStrictly)!
        return d
    }
    
    
    
    func setNotificationForSnooze(snoozeMinute: Int, soundName: String, index: Int) {
        let calendar = Calendar(identifier: Calendar.Identifier.republicOfChina)
        let now = Date()
        let snoozeTime = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.minute, value: snoozeMinute, to: now, options:.matchStrictly)!
        setNotification(snoozeTime, onWeekdaysForNotify: [Int](), snooze: true, onSnooze:true, soundName: soundName, index: index)
    }
    
    func reschedule() {
        //cancel all and register all is often more convenient
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        syncAlarm()
        for i in 0..<alarmModel.count {
            let alarm = self.alarmModel.alarms[i]
            if alarm.enabled {
                setNotification(alarm.date as Date, onWeekdaysForNotify: alarm.repeatWeekdays, snooze: alarm.snoozeEnabled, onSnooze: false, soundName: alarm.mediaLabel, index: i)
            }
        }
    }
    
    // workaround for some situation that alarm model is not setting properly (when app on background or not launched)
    func checkNotification() {
        alarmModel = Alarms()
        UNUserNotificationCenter.current().getPendingNotificationRequests { [unowned self] (request) in
            if request.isEmpty {
                for i in 0..<self.alarmModel.count {
                    self.alarmModel.alarms[i].enabled = false
                }
            } else {
                for (i, alarm) in self.alarmModel.alarms.enumerated() {
                    var isOutDated = true
                    if alarm.onSnooze {
                        isOutDated = false
                    }
                    for req in request {
                        if let trigger = req.trigger as? UNTimeIntervalNotificationTrigger {
                            if alarm.date >= Date(timeIntervalSinceNow: trigger.timeInterval) {
                                isOutDated = false
                            }
                        }
                    }
                    if isOutDated {
                        self.alarmModel.alarms[i].enabled = false
                    }
                }
            }
        }
    }
    
    private func syncAlarm() {
        alarmModel = Alarms()
    }
    
    private enum weekdaysComparisonResult {
        case before
        case same
        case after
    }
    
    private func compare(weekday w1: Int, with w2: Int) -> weekdaysComparisonResult
    {
        if w1 != 1 && w2 == 1 {return .before}
        else if w1 == w2 {return .same}
        else {return .after}
    }
    
    private func latestTriggerWith(notificationRequests requests: [UNNotificationRequest]) -> (Date, Int)? {
        if requests.isEmpty {
            return nil
        }
        var minIndex = -1
        guard let request = requests.first else {
            return nil
        }
        
        guard let minTrigger = request.trigger as? UNTimeIntervalNotificationTrigger else { return nil }
        
        var minInterval = minTrigger.timeInterval
        
        
        for request in requests {
            let index = request.content.userInfo["index"] as! Int
            guard let trigger = request.trigger as? UNTimeIntervalNotificationTrigger else { return nil }
            
            if trigger.timeInterval <= minInterval {
                minInterval = trigger.timeInterval
                minIndex = index
            }
        }
        return (Date(timeInterval: minInterval, since: Date()), minIndex)
    }
}
