//
//  Date+Extension.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import Foundation

extension Date {
    func timeIn24HourFormat() -> String {
           let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
           formatter.dateStyle = .none
           formatter.dateFormat = "HH:mm"
           return formatter.string(from: self)
       }
}
