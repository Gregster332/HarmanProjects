//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import Foundation
import RealmSwift
import CoreLocation
import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var currentCity: City? = nil
    
    internal func getCityFromWelcome(welcome: Welcome?) {
        guard let welcome = welcome else { return }
        let city = City()
        city.feelsLike = welcome.main.feelsLike
        city.humidity = welcome.main.humidity
        city.main = welcome.weather.last!.main
        city.name = welcome.name
        city.pressure = welcome.main.pressure
        city.sunrise = welcome.sys.sunrise
        city.sunset = welcome.sys.sunset
        city.temp = welcome.main.temp
        city.tempMax = welcome.main.tempMax
        city.tempMin = welcome.main.tempMin
        currentCity = city
    }
    
//    //MARK: - Published vars
//    @Published var cityName: String = ""
//    @Published var cities: [City] = []
//    
//    //MARK: - Lets
//    let service = NetworkService()
//    
//    //MARK: - Init
//    init() {
//        fetchData()
//    }
//    
//    //MARK: - Functions for working with databse
//    func addData(name: String, feelsLike: Double, sunrise: Int, sunset: Int, temp: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, main: String) {
//        let city = City()
//        city.name = name
//        city.feelsLike = feelsLike
//        city.sunrise = sunrise
//        city.sunset = sunset
//        city.temp = temp
//        city.tempMin = tempMin
//        city.tempMax = tempMax
//        city.pressure = pressure
//        city.humidity = humidity
//        city.main = main
//        
//        guard let dbRef = try? Realm() else { return }
//        try? dbRef.write({
//            dbRef.add(city)
//            fetchData()
//        })
//    }
//    
//    func getNewData() {
//        self.cities.indices.forEach { city in
//            let service = NetworkService()
//            service.getData(cityName: cities[city].name) { item in
//                guard let item = item else { return }
//                self.deleteData(object: self.cities[city])
//                self.addData(name: item.name,
//                             feelsLike: item.main.feelsLike,
//                             sunrise: item.sys.sunrise,
//                             sunset: item.sys.sunset,
//                             temp: item.main.temp,
//                             tempMin: item.main.tempMin,
//                             tempMax: item.main.tempMax,
//                             pressure: item.main.pressure,
//                             humidity: item.main.humidity,
//                             main: item.weather.first!.main)
//            }
//        }
//    }
//    
//    func fetchData() {
//        guard let dbRef = try? Realm() else { return }
//        let results = dbRef.objects(City.self)
//        self.cities = results.compactMap { city -> City? in
//            return city
//        }.sorted { $0.name < $1.name }
//    }
//    
//    func deleteData(object: City) {
//        guard let dbRef = try? Realm() else { return }
//        try? dbRef.write({
//            dbRef.delete(object)
//        })
//        fetchData()
//    }
//    
//    func deleteAll() {
//        guard let dbRef = try? Realm() else { return }
//        try? dbRef.write {
//            dbRef.delete(dbRef.objects(City.self))
//        }
//        fetchData()
//    }
}


