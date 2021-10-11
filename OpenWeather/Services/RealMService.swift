//
//  RealMService.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import Foundation
import RealmSwift

class RealMService: ObservableObject {
    
    //MARK: - Published vars
    @Published var cityName: String = ""
    @Published var cities: [City] = []
    
    //MARK: - Lets
    let service = NetworkService()
    
    //MARK: - Init
    init() {
        fetchData()
    }
    
    //MARK: - Functions for working with databse
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
    
    func getNewData() async {
        self.cities.indices.forEach { city in
            let service = NetworkService()
            service.getData(cityName: cities[city].name) { item in
                self.deleteData(object: self.cities[city])
                switch(item) {
                case .success(let result):
                    self.addData(name: result!.name,
                                 feelsLike: result!.main.feelsLike,
                                 sunrise: result!.sys.sunrise,
                                 sunset: result!.sys.sunset,
                                 temp: result!.main.temp,
                                 tempMin: result!.main.tempMin,
                                 tempMax: result!.main.tempMax,
                                 pressure: result!.main.pressure,
                                 humidity: result!.main.humidity,
                                 main: result!.weather.first!.main)
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                }
            }
        }
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


