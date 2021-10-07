//
//  ColorChangeService.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 07.10.2021.
//

import SwiftUI


class ColorChangeService {
    
    static let shared = ColorChangeService()
    static let changeColor = Notification.Name("changedLanguage")
    
    var color: Colors {
        get {
            guard let changeColor = UserDefaults.standard.string(forKey: "color") else {
                return .green
            }
            return Colors(rawValue: changeColor) ?? .green
        }
        set {
            if newValue != color {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "color")
                NotificationCenter.default.post(name: ColorChangeService.changeColor, object: nil)
            }
        }
    }
    
    public func changeColor(color: String) -> Color {
        if color == "green" {
            return Color.green
        } else if color == "pink" {
            return Color.pink
        } else {
            return Color.purple
        }
    }
}
