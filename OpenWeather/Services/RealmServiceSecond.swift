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
    
   // private let realm: Realm
    
//    private init() {
//        self.realm = try! Realm()
//    }
    
    func fetchAllFromDatabase(completion: @escaping ([City]) -> ()) {
        guard let dbRef = try? Realm() else { return }
        //var allData = [City]()
        let results = dbRef.objects(City.self)
        print("lolololo")
        completion(Array(results))
    }
    
    func addCityToDatabase(city: City?) {
        guard let dbRef = try? Realm() else { return }
        guard let city = city else { return }
        let currentCity = city
        try? dbRef.write {
            dbRef.add(currentCity)
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
        let objects = dbRef.objects(City.self)
        objects.forEach { city in
        try? dbRef.write {
            dbRef.delete(city)
        }
        }
    }
}
