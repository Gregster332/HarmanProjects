//
//  DBModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import SwiftUI
import RealmSwift

class City: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var name: String = ""
    @objc dynamic var sunrise: Int = 0
    @objc dynamic var sunset: Int = 0
    @objc dynamic var temp: Double = 0
    @objc dynamic var feelsLike: Double = 0
    @objc dynamic var tempMin: Double = 0
    @objc dynamic var tempMax: Double  = 0
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var main: String = ""
    @objc dynamic var lat: Double = 0
    @objc dynamic var lon: Double = 0
}

