//
//  SettingsViewModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 06.10.2021.
//

import UIKit
import SwiftUI

class SettingViewModel: ObservableObject {
    
    internal func calculateWidth(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {

        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 390
            } else if (800..<900).contains(screenHeight) {
                return 370
            } else if  (600..<700).contains(screenHeight) {
                return 330
            } else if (700..<800).contains(screenHeight) {
                return 350
            } else if (1000..<1400).contains(screenHeight) {
                return 500
            } else {
                return 300
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 600
            } else {
                return 600
            }
        }
       
    }
    
    internal func calculateHeight(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 80
            } else if (800..<900).contains(screenHeight) {
                return 80
            } else if  (600..<700).contains(screenHeight) {
                return 80
            } else if (700..<800).contains(screenHeight) {
                return 80
            } else if (1000..<1400).contains(screenHeight) {
                return 80
            } else {
                return 80
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 60
            } else {
                return 80
            }
        }
       
    }
    
    internal func calculateWidthForFramgment(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 350
            } else if (800..<900).contains(screenHeight) {
                return 330
            } else if  (600..<700).contains(screenHeight) {
                return 290
            } else if (700..<800).contains(screenHeight) {
                return 310
            } else if (1000..<1400).contains(screenHeight) {
                return 440
            } else {
                return 270
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 500
            } else {
                return 500
            }
        }
       
    }
    
    internal func calculateWidthForButton(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {

        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 140
            } else if (800..<900).contains(screenHeight) {
                return 120
            } else if  (600..<700).contains(screenHeight) {
                return 80
            } else if (700..<800).contains(screenHeight) {
                return 100
            } else if (1000..<1400).contains(screenHeight) {
                return 160
            } else {
                return 80
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 190
            } else {
                return 190
            }
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
                return 27
            }
        } else {
            if (300..<650).contains(screenHeight) {
                return 25
            } else {
                return 40
            }
        }
    }
    
    internal func changeColor(color: String) -> Color {
        if color == "green" {
            return Color.green
        } else if color == "pink" {
            return Color.pink
        } else {
            return Color.purple
        }
    }
    
}
