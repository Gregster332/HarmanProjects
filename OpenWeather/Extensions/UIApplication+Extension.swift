//
//  UIApplication+Extension.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
