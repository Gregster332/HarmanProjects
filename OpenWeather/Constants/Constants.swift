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
        static public let lowerLimit: CGFloat = 50
        static public let percentage: CGFloat = 100
        static public let rectangleFullWidth: CGFloat = 230
        static public let zero: CGFloat = 0
        static public let multiplyValueForRecatgle: CGFloat = 2.55
    }
    
    class Offsets {
        static public let viewOffset: CGFloat = -1000
        static public let zeroOffset: CGFloat = 0
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
        static public let plusForTemperatureDescriptionCellMainTextFont: CGFloat = 20
        static public let plusForTemperatureDescriptionCellCityTextFont: CGFloat = 3
        static public let plusForSettingsViewDeleteButtonFont: CGFloat = 10
        static public let plusForSettingsViewLanguageChangeButtonFont: CGFloat = 5
    }
    
    class CornerRadiuses {
        static public let attentionViewCornerRadius: CGFloat = 20
        static public let settingsViewDeleteAllCornerRaduis: CGFloat = 10
        static public let addCityViewTextFieldCornerRaduis: CGFloat = 15
    }
    
    class Deegrees {
        static public let TempViewDegrees: Double = -90
    }
    
    class AsyncSeconds {
        static public let asyncHalfSecond = 0.5
        static public let asyncSecond = 1.0
        static public let asyncTwoSecond = 2.0
    }
    
    class Blurs {
        static public let mainViewBlur: CGFloat = 2
        static public let zeroBlur: CGFloat = 0
        static public let detailViewBlur: CGFloat = 10
    }
    
    class Widths {
        static public let attentionViewOkButtonWidth: CGFloat = 40
        static public let attentionViewWidth: CGFloat = 300
        static public let settingsViewLanguageButtonWidth: CGFloat = 60
        static public let settingsViewBrushButtonWidth: CGFloat = 50
        static public let addCityViewTextFieldViewWidth1: CGFloat = 290
        static public let addCityViewTextFieldViewWidth2: CGFloat = 500
        static public let addCityViewSearchButtonWidth: CGFloat = 140
        static public let addCityViewWidth: CGFloat = 300
        static public let tempViewWidth: CGFloat = 150
        static public let tempViewWidth2: CGFloat = 165
    }
    
    class Heights {
        static public let attentionViewOkButtonHeight: CGFloat = 30
        static public let attentionViewHeight: CGFloat = 180
        static public let settingsViewDeleteButtonHeight: CGFloat = 50
        static public let settingsViewLanguageButtonHeight: CGFloat = 60
        static public let settingsViewHeight1: CGFloat = 450
        static public let settingsViewHeight2: CGFloat = 350
        static public let addCityViewTextFieldViewHeigh: CGFloat = 100
        static public let settingsViewHeight3: CGFloat = 400
        static public let settingsViewHeight4: CGFloat = 300
        static public let fragmentViewHeight: CGFloat = 140
        static public let tempViewHeight: CGFloat = 150
        static public let tempViewHeight2: CGFloat = 165
    }
    
    class Spacings {
        static public let temperatureDescriptionViewMainHstackSpacing: CGFloat = 50
        static public let zeroSpacing: CGFloat = 0
        static public let settingsViewMainVStackSpacing: CGFloat = 40
        static public let settingsViewMainHStackSpacing: CGFloat = 60
        static public let addCityViewMainVSatckSpacing: CGFloat = 20
        static public let detailViewCurrentCityInfoSpacing: CGFloat = 10
        static public let fragmentViewSpacing: CGFloat = 30
    }
    
    class UnitPoints {
        static public let x1: CGFloat = 4
        static public let x2: CGFloat = 0
        static public let y1: CGFloat = 0
        static public let y2: CGFloat = -2
    }
    
    class Trimms {
        static public let zeroTrim = 0.0
    }
    
    class LineWidths {
        static public let tempViewLineWidth: CGFloat = 15
    }
    
    class Dashes {
        static public let tempViewDash: CGFloat = 3
    }
}
