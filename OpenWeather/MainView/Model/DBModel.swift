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
}

