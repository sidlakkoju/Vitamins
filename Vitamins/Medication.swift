//
//  Medications.swift
//  Vitamins
//
//  Created by Siddharth Lakkoju on 12/26/21.
//

import Foundation
import CoreImage
import SwiftUI
import UserNotifications

//should add codeable conformation to save
struct Medication: Codable {
    let id: String
    var title: String
    var theme: Theme
    var vitTaken: Bool
    
    var remHour: Int
    var remMinute: Int
    
    var history: [History] = []
    

    
    
//  When a new medication is made initialize ->
//      Constant Parameters ->
//          - vitTaken = false
//          - id = UUID()
//      User Defined Parameters
//          - theme: Theme
//          - title: String
    init(title: String, theme: Theme, remHour: Int, remMinute: Int ) {
        self.title = title
        self.theme = theme
        self.remHour = remHour
        self.remMinute = remMinute
        
        self.vitTaken = false
        self.id = UUID().uuidString
    }
}

extension Medication {
    struct Data {
        var title: String = ""
        var theme: Theme = .kindaBlue
        var vitTaken: Bool = false
        var remHour: Int = 0;
        var remMinute: Int = 0;
        
        func hourToString() -> String {
            let hour: String
            
            if (remHour < 12) {
                if (remHour == 0) {
                    hour = "12"
                }
                else if (remHour < 10) {
                    hour = "0" + String(remHour)
                }
                else {
                    hour = String(remHour)
                }
            }
            else {
                if (remHour == 12) {
                    hour = String(remHour)
                }
                else {
                    
                    if (remHour - 12 < 10) {
                        hour = "0" + String(remHour - 12)
                    }
                    else  {
                        hour = String(remHour - 12)
                    }
                }
            }
            
            return hour
        }
        
        func minuteToString() -> String {
            let minute: String
            if (remMinute < 10) {
                minute = "0" + String(remMinute)
            }
            else {
                minute = String(remMinute)
            }
            
            return minute
        }
        
        func timeDayString() -> String {
            let timeDay: String
          
            if (remHour < 12) {
                timeDay = "AM"
            }
            else {
                timeDay = "PM"
            }
            
            return timeDay
        }
        
        func timeToString() -> String {
            return hourToString() + ":" + minuteToString() + " " + timeDayString()
        }
    }
    
    var data: Data {
        Data(title: title, theme: theme, vitTaken: vitTaken, remHour: remHour, remMinute: remMinute)
        
    }
    
    mutating func update(from data: Data) {
        title = data.title
        theme = data.theme
        vitTaken = data.vitTaken
        remHour = data.remHour
        remMinute = data.remMinute
    }
    
    init(data: Data) {
        id = UUID().uuidString
        
        title = data.title
        theme = data.theme
        vitTaken = data.vitTaken
        remHour = data.remHour
        remMinute = data.remMinute
    }
}

// Notifications
extension Medication {
    func scheduleNotification () {
        // Time of day at which the notification should be delivered (remHour:remMinute)
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = self.remHour
        dateComponents.minute = self.remMinute
        
        // Content of the notification
        let content = UNMutableNotificationContent()
        content.title = self.title + " Time!"
        content.body = "It's time to take " + self.title + "! :)"
        content.sound = UNNotificationSound.default
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let request = UNNotificationRequest(identifier: self.id,
                    content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
    
    func cancelNotification () {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.id])
    }
    
}

extension Medication {
    static var sampleData: [Medication] =
    [
        Medication(title: "Swipe up and add a new Med!", theme: .kindaBlue, remHour: 10, remMinute: 55),
        Medication(title: "Vitamin D", theme: .kindaBlue, remHour: 10, remMinute: 55),
        Medication(title: "Drug D", theme: .kindaBlue, remHour: 10, remMinute: 55),
    ]
    
}
