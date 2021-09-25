//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import Foundation
import RealmSwift

class WeatherViewModel: ObservableObject {
    
    @Published var cityName: String = ""
    @Published var cities: [City] = []
    let service = NetworkService()
    
    init() {
        fetchData()
    }
    
//    func checkEmptyElements() {
//        citiesWelcome.indices.forEach { item in
//            cities.indices.forEach { itemString in
//                if citiesWelcome[itemString].name == cities[item].name {
//                    self.deleteData(object: self.cities[itemString])
//                    DispatchQueue.main.async {
//                        self.cities.remove(at: itemString)
//                    }
//                    self.fetchData()
//                }
//            }
//        }
//    }
//
//    func addCurrentCityCityInArray() {
//        if cityName != "" {
//            for city in cities.indices {
//                let _ = NetworkService().getData(cityName: cityName) { (item) in
//                        var index = 0
//                        guard let item = item else { return }
//                        if self.cities[city].name == item.name {
//                            index = city
//                            DispatchQueue.main.async {
//                                //self.citiesWelcome.insert(item, at: index)
//                                self.citiesWelcome.append(item)
//                            }
//
//                        }
//                    
//                }
//            }
//            citiesWelcome = citiesWelcome.sorted { $0.name < $1.name }
//        } else {
//            self.cities.indices.forEach { city in
//                let _ = NetworkService().getData(cityName: cities[city].name) { (item) in
//                    var index = 0
//                    guard let item = item else { return }
//
//                    DispatchQueue.main.async {
//                        self.citiesWelcome.append(item)
//                    }
//                    //self.citiesWelcome.append(item
//                }
//            }
//        }
//        //cityName = ""
//
//        //        if name != nil {
////            let _ = NetworkService().getData(cityName: name!) { item, response in
////                if response == 200 {
////                    self.addData()
////                    self.cities.indices.forEach { city in
////                        DispatchQueue.main.async {
////                            guard let item = item else { return }
////                            if self.cities[city].name == item.name {
////                                self.citiesWelcome.append(item)
////                            }
////                        }
////                    }
////
////                }
////            }
////        } else {
////            self.cities.indices.forEach { index in
////                let _ = NetworkService().getData(cityName: cities[index].name) { item, response in
////                    if response == 200 {
////                        guard let item = item else { return }
////                        if self.cities[index].name == item.name {
////                            DispatchQueue.main.async {
////                                self.citiesWelcome.append(item)
////                            }
////                        }
////                    }
////                }
////            }
////        }
//    }
//
    
    func addData(name: String, feelsLike: Double, sunrise: Int, sunset: Int, temp: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, main: String) {
        let city = City()
        city.name = name
        city.feelsLike = feelsLike
        city.sunrise = sunrise
        city.sunset = sunset
        city.temp = temp
        city.tempMin = tempMin
        city.tempMax = tempMax
        city.pressure = pressure
        city.humidity = humidity
        city.main = main
        
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write({
            dbRef.add(city)
            fetchData()
        })
    }
    
    func fetchData() {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(City.self)
        self.cities = results.compactMap { city -> City? in
            return city
        }.sorted { $0.name < $1.name }
    }
    
    func deleteData(object: City) {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write({
            dbRef.delete(object)
        })
        fetchData()
    }
    
    func deleteAll() {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {
            dbRef.delete(dbRef.objects(City.self))
        }
        fetchData()
    }
}


