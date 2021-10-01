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
    
    internal func calculateWidth(heightClass: UserInterfaceSizeClass?) -> CGFloat {
        print("\(UIScreen.main.bounds.height) height")
        print("\(UIScreen.main.bounds.width) width")
        if heightClass == .regular {
            if (900..<1000).contains(UIScreen.main.bounds.height) {
                return 390
            } else if (800..<900).contains(UIScreen.main.bounds.height) {
                return 370
            } else if  (600..<700).contains(UIScreen.main.bounds.height) {
                return 350
            } else if (700..<800).contains(UIScreen.main.bounds.height) {
                return 370
            } else if (1000..<1400).contains(UIScreen.main.bounds.height) {
                return 500
            } else {
                return 300
            }
        } else {
            if (300..<1000).contains(UIScreen.main.bounds.height) {
                return 600
            } else {
                return 500
            }
        }
       
    }
    
    internal func calculateFont(heightClass: UserInterfaceSizeClass?) -> CGFloat {
        if heightClass == .regular {
            if (900..<1000).contains(UIScreen.main.bounds.height) {
                return 28
            } else if (800..<900).contains(UIScreen.main.bounds.height) {
                return 25
            } else if  (600..<700).contains(UIScreen.main.bounds.height) {
                return 23
            } else if (700..<800).contains(UIScreen.main.bounds.height) {
                return 24
            } else if (1000..<1400).contains(UIScreen.main.bounds.height) {
                return 35
            } else {
                return 23
            }
        } else {
            if (300..<650).contains(UIScreen.main.bounds.height) {
                return 35
            } else {
                return 50
            }
        }
    }
    
}
