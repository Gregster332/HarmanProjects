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
        //completion(results)
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
        //let objects = dbRef.objects(City.self)
        try? dbRef.write {
            dbRef.deleteAll()
        }
    }
}
