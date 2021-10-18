//
//  DetailViewModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import UIKit
import SwiftUI

class DetailViewModel: ObservableObject {
    
    var language = LocalizationService.shared.language
    var color = ColorChangeService.shared.color
    
    
    internal func calculateWidth(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        print("\(UIScreen.main.bounds.height) height")
        print("\(UIScreen.main.bounds.width) width")
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 390
            } else if (800..<900).contains(screenHeight) {
                return 370
            } else if  (600..<700).contains(screenHeight) {
                return 350
            } else if (700..<800).contains(screenHeight) {
                return 370
            } else if (1000..<1400).contains(screenHeight) {
                return 500
            } else {
                return 300
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 600
            } else {
                return 500
            }
        }
       
    }
    
    internal func changeBG(description: String) -> [Color] {
        switch description {
        case "Clear": return [Color(#colorLiteral(red: 0.6320731044, green: 1, blue: 0.4726927876, alpha: 0.8470588235)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1))]
        case "Snow": return [Color(#colorLiteral(red: 0, green: 0.5195968151, blue: 1, alpha: 0.8470588235)), Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))]
        case "Rain": return [Color(#colorLiteral(red: 0.3781584501, green: 0.3847603202, blue: 0.403935194, alpha: 0.8470588235)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.3781584501, green: 0.3847603202, blue: 0.403935194, alpha: 0.8470588235))]
        case "Clouds": return [Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)), Color(#colorLiteral(red: 0.697870791, green: 0.7321204543, blue: 0.8117726445, alpha: 0.8470588235)), Color(#colorLiteral(red: 0.697870791, green: 0.7321204543, blue: 0.8117726445, alpha: 0.8470588235))]
        case "Tornado": return [Color(#colorLiteral(red: 0.585306108, green: 0.5849964023, blue: 0.598026216, alpha: 0.8470588235)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.585306108, green: 0.5849964023, blue: 0.598026216, alpha: 0.8470588235))]
        case "Shquall": return [Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.585306108, green: 0.5849964023, blue: 0.598026216, alpha: 0.8470588235)), Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))]
        default: return [Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.6176282167, green: 0.4858464003, blue: 0, alpha: 0.8470588235))]
        }
    }
    
    internal func calculateFont(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 32
            } else if (800..<900).contains(screenHeight) {
                return 30
            } else if  (600..<700).contains(screenHeight) {
                return 28
            } else if (700..<800).contains(screenHeight) {
                return 29
            } else if (1000..<1400).contains(screenHeight) {
                return 40
            } else {
                return 28
            }
        } else {
            if (300..<650).contains(screenHeight) {
                return 32
            } else {
                return 45
            }
        }
    }
    
}
