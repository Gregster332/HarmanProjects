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
import MapKit

class MainViewModel: ObservableObject {
    let locationManager = LocationManager.shared
    let realmService: RealmServiceSecond
    let networkService: NetworkService
    
    @Published var currentCity: City? = nil
    @Published var showAddView: Bool = false
    @Published var showSetiingsView: Bool = false
    @Published var showSheet: Bool = false
    @Published var showAttentionLabel: Bool = false
    @Published var showingAlert: Bool = false
    @Published var isThisNoInternetAttentionView: Bool = true
    @Published var flagForError: Bool = false
    @Published var searchItem: String = ""
    @Published var searcedCurrentCity: String = ""
    @Published var city: City? = nil
    @Published var cities: [City] = []
    @Published var result: GetResult = .NOTHING
    @AppStorage("language") var language = LocalizationService.shared.language
    @AppStorage("color") var color = ColorChangeService.shared.color
    
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    init(realm: RealmServiceSecond = .shared, service: NetworkService = .shared) {
        self.realmService = realm
        self.networkService = service
        fetchAllFromDB()
    }
    
    internal func fetchAllFromDB() {
        realmService.fetchAllFromDatabase { results in
            self.cities = results
        }
    }
    
    internal func addCityToDB(city: City?) {
        guard let city = city else { return }
        realmService.addCityToDatabase(city: city)
        realmService.fetchAllFromDatabase { results in
            self.cities = results
        }
    }
    
    internal func deleteCityFromDB(city: City) {
        realmService.deleteCityFromDataBase(city: city)
        realmService.fetchAllFromDatabase { result in
            self.cities = result
        }
    }
    
    internal func deleteAllFromDB() {
        realmService.deleteAllDatabase()
        realmService.fetchAllFromDatabase { result in
            self.cities = result
        }
    }
    
    private func updateItem(cityForDelete: City, cityForAdd: City) {
        realmService.updateItem(cityForDelete: cityForDelete, cityToAdd: cityForAdd)
        realmService.fetchAllFromDatabase { result in
            self.cities = result
        }
    }
    
    internal func getNewWeatherForAllCities() {
            self.cities.forEach { city in
                self.networkService.getData(cityName: city.name) { result in
                    switch(result) {
                    case .success(let item):
                        guard let item = item else { return }
                        self.updateItem(cityForDelete: city, cityForAdd: self.getCityFromWelcome(welcome: item)!)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
        realmService.fetchAllFromDatabase { results in
            self.cities = results
        }
    }
    
    
    internal func getCurrnetWeather() async {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location?.coordinate : CLLocationCoordinate2D()
            self.networkService.getDataByCoordinates(lat: coordinate?.latitude ?? 0, lon: coordinate?.longitude ?? 0) { item in
                switch(item) {
                case .success(let result):
                    self.city = self.getCityFromWelcome(welcome: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

    internal func getCityFromWelcome(welcome: Welcome?) -> City? {
        guard let welcome = welcome else { return nil }
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
        city.lat = welcome.coord.lat
        city.lon = welcome.coord.lon
        return city
    }
    
    internal func changeLanguage(to lang: Language) {
            self.language = lang
            LocalizationService.shared.language = lang
    }
    
    internal func changeColor(to col: Colors) {
            self.color = col
            ColorChangeService.shared.color = col
    }
    
    internal func addNewCityToDBBYName() {
        if checkSymbols(str: searcedCurrentCity) {
            networkService.getData(cityName: searcedCurrentCity) { result in
                switch(result) {
                case .success(let item):
                    self.addCityToDB(city: self.getCityFromWelcome(welcome: item)!)
                    self.fetchAllFromDB()
                    withAnimation(.easeInOut) {
                        self.result = .OK
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            searcedCurrentCity = ""
            UIApplication.shared.endEditing()
            showAddView.toggle()
        } else {
            showingAlert = true
            searcedCurrentCity = ""
        }
    }
    
    internal func checkSymbols(str: String) -> Bool {
        if str == "" || str == " " {
            return false
        }
        for chr in str {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && chr != " " && chr != "-") {
                return false
            }
        }
        return true
    }
}




