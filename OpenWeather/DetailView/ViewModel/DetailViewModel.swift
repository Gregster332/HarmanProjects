//
//  DetailViewModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import UIKit
import SwiftUI

class DetailViewModel: ObservableObject {
    
    //@Published var heightClass: UserInterfaceSizeClass? = nil
    
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
