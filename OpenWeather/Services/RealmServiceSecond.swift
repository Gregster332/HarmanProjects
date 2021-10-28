//
//  RealmServiceSecond.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 13.10.2021.
//

import Foundation
import RealmSwift

class RealmServiceSecond {
    
    static let shared = RealmServiceSecond()
    
    func fetchAllFromDatabase(completion: @escaping ([City]) -> ()) {
        guard let dbRef = try? Realm() else { return }
        let results = dbRef.objects(City.self)
        if !results.isInvalidated {
            completion(results.compactMap { city -> City? in
                return city
            }.sorted { $0.name < $1.name })
        } else {
            completion([])
        }
    }
    
    func addCityToDatabase(city: City?) {
        guard let dbRef = try? Realm() else { return }
        guard let city = city else { return }
        try? dbRef.write {
            dbRef.add(city)
        }
    }
    
    func deleteCityFromDataBase(city: City) {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write({
            dbRef.delete(city)
        })
    }
    
    func deleteAllDatabase() {
        guard let dbRef = try? Realm() else { return }
        try? dbRef.write {
            dbRef.deleteAll()
        }
    }
    
    func updateItem(cityForDelete: City, cityToAdd: City) {
        deleteCityFromDataBase(city: cityForDelete)
        addCityToDatabase(city: cityToAdd)
    }
    
}
