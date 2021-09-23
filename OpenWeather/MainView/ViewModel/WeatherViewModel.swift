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
    @Published var citiesWelcome: [Welcome] = []
    let service = NetworkService()
    
    init() {
        fetchData()
        self.citiesWelcome.sort { $0.name > $1.name }
    }
    
    func addCurrentCityCityInArray(name: String?) {
        if name != nil {
            let _ = NetworkService().getData(cityName: cityName) { item in
                DispatchQueue.main.async {
                    self.citiesWelcome.append(item)
                }
            }
        } else {
            self.cities.forEach { city in
                let _ = NetworkService().getData(cityName: city.name) { item in
                    DispatchQueue.main.async {
                        self.citiesWelcome.append(item)
                    }
                }
            }
        }
        cityName = ""
    }
    
    
    func addData() {
        let city = City()
        city.name = cityName
        
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
        }
    }
    
    func deleteData(object: City) {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write({
            dbRef.delete(object)
        })
        fetchData()
    }
}


