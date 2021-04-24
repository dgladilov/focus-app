//
//  String + Extension.swift
//  Focus
//
//  Created by Dmitry Gladilov on 25.04.2021.
//

import Foundation

extension String {
    static func secondsToString(seconds: Int16) -> String {
        let hours = seconds / 3600
        let minutes = seconds % 3600 / 60
        let time = hours == 0 ? String(format: "%02dm", minutes) : String(format: "\(hours)h %02dm", minutes)
        return time
    }
    
    static func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}
