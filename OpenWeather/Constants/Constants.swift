//
//  Constants.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import SwiftUI

class Constants {
    
    class ApiKeys {
        static public let apiKey = "c302a638f8f46f6a557e143a3a483647"
    }
    
    class MathContants {
        static public let toCelsius = 273
        static public let maxWidthOfPressureRectangle = 1050
        static public let minWidthOfPressureRectangle = 950
    }
    
    class Offsets {
        static public let viewOffset: CGFloat = -1000
    }
    
    class URLS {
        static public let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    }
    
    class Colors {
        static public let settingsViewColor = Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        static public let addCityViewColor = Color.blue.opacity(0.3)
        static public let attentionForeground = Color(#colorLiteral(red: 0.832, green: 0.8, blue: 0.1, alpha: 1))
    }
    
    class Fonts {
        static public let attentionFont: CGFloat = 25
        static public let refreshFont: CGFloat = 23
        static public let temperatureDescriptionCellFont: CGFloat = 20
        static public let addCityViewEnterCityFont: CGFloat = 30
    }
    
    class CornerRadiuses {
        static public let attentionViewCornerRadius: CGFloat = 20
        static public let settingsViewDeleteAllCornerRaduis: CGFloat = 10
        static public let addCityViewTextFieldCornerRaduis: CGFloat = 15
    }
    
    class Deegrees {
        static public let TempViewDegrees: Double = -90
    }
}
