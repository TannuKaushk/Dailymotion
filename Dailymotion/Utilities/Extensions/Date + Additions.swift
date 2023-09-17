//
//  Date + Additions.swift
//  Dailymotion
//
//  Created by Tannu Kaushik on 17/09/23.
//

import Foundation
import UIKit

class Utility  {
    /**
     Method to get date from dateTimestamp
     */
    static func getDateAndTimeStamp(timestamp: Int64) -> String? {
        let dateFormatter = DateFormatter()
        let unixTimeStamp: Double = Double(timestamp)
        let exactDate = NSDate(timeIntervalSince1970: unixTimeStamp)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: exactDate as Date)
    }
    
    //MARK: Date Formate for Message List
    static func getElapsedInterval(FromDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        olDateFormatter.locale = Locale(identifier: "fr")
        let oldDate = olDateFormatter.date(from: FromDate)
        var interval = Calendar.current.dateComponents([.year], from: oldDate ?? Date(), to: Date()).year!
        if interval > 0 {
            return interval == 1 ? "il y a \(interval)" + " année" : "il y a \(interval)" + " années"
        }
        
        interval = Calendar.current.dateComponents([.month], from: oldDate ?? Date(), to: Date()).month!
        if interval > 0 {
            return interval == 1 ? "il y a \(interval)" + " mois" : "il y a \(interval)" + " mois"
        }
        
        interval = Calendar.current.dateComponents([.day], from: oldDate ?? Date(), to: Date()).day!
        if interval > 0 {
            return interval == 1 ? "il y a \(interval)" + " jour" : "il y a \(interval)" + " jour"
        }
        
        interval = Calendar.current.dateComponents([.hour], from: oldDate ?? Date(), to: Date()).hour!
        if interval > 0 {
            return interval == 1 ? "il y a \(interval)" + " heure" : "il y a \(interval)" + " heures"
        }
        
        interval = Calendar.current.dateComponents([.minute], from: oldDate ?? Date(), to: Date()).minute!
        if interval > 0 {
            return interval == 1 ? "il y a \(interval)" + " minute" : "il y a \(interval)" + " minutes"
        }
        
        
        return "maintenant"
    }
}
