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
    let realmService = RealmServiceSecond.shared
    let networkService = NetworkService.shared
    
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
    @AppStorage("language") var language = LocalizationService.shared.language
    @AppStorage("color") var color = ColorChangeService.shared.color
    
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    init() {
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
    
    internal func getNewWeatherForAllCities() {
        self.cities.forEach { city in
            networkService.getData(cityName: city.name) { result in
                switch(result) {
                case .success(let item):
                    guard let item = item else { return }
                    self.deleteCityFromDB(city: city)
                    self.addCityToDB(city: self.getCityFromWelcome(welcome: item))
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
        DispatchQueue.main.async {
            self.networkService.getDataByCoordinates(lat: coordinate?.latitude ?? 0, lon: coordinate?.longitude ?? 0) { item in
                switch(item) {
                case .success(let result):
                    self.city = self.getCityFromWelcome(welcome: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
        return city
    }
    
    internal func calculateFont(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        withAnimation(.easeInOut(duration: 1)) {
            if heightClass == .regular {
                if (900..<1000).contains(screenHeight) {
                    return 28
                } else if (800..<900).contains(screenHeight) {
                    return 25
                } else if  (600..<700).contains(screenHeight) {
                    return 23
                } else if (700..<800).contains(screenHeight) {
                    return 24
                } else if (1000..<1400).contains(screenHeight) {
                    return 35
                } else {
                    return 23
                }
            } else {
                if (300..<1000).contains(screenHeight) {
                    return 35
                } else {
                    return 50
                }
            }
        }
    }
    
    internal func calculateWidth(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        withAnimation(.easeInOut(duration: 1)) {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 390
            } else if (800..<900).contains(screenHeight) {
                return 370
            } else if  (600..<700).contains(screenHeight) {
                return 330
            } else if (700..<800).contains(screenHeight) {
                return 350
            } else if (1000..<1400).contains(screenHeight) {
                return 500
            } else {
                return 300
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 600
            } else {
                return 600
            }
        }
        }
       
    }
    
    internal func calculateHeight(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        withAnimation(.easeInOut(duration: 1)) {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 80
            } else if (800..<900).contains(screenHeight) {
                return 80
            } else if  (600..<700).contains(screenHeight) {
                return 80
            } else if (700..<800).contains(screenHeight) {
                return 80
            } else if (1000..<1400).contains(screenHeight) {
                return 80
            } else {
                return 80
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 60
            } else {
                return 80
            }
        }
        }
    }
    
    internal func calculateWidthForFramgment(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        withAnimation(.easeInOut(duration: 1)) {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 350
            } else if (800..<900).contains(screenHeight) {
                return 330
            } else if  (600..<700).contains(screenHeight) {
                return 290
            } else if (700..<800).contains(screenHeight) {
                return 310
            } else if (1000..<1400).contains(screenHeight) {
                return 440
            } else {
                return 270
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 500
            } else {
                return 500
            }
        }
        }
    }
    
    internal func calculateWidthForButton(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        withAnimation(.easeInOut(duration: 1)) {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 140
            } else if (800..<900).contains(screenHeight) {
                return 120
            } else if  (600..<700).contains(screenHeight) {
                return 80
            } else if (700..<800).contains(screenHeight) {
                return 100
            } else if (1000..<1400).contains(screenHeight) {
                return 160
            } else {
                return 80
            }
        } else {
            if (300..<1000).contains(screenHeight) {
                return 190
            } else {
                return 190
            }
        }
        }
    }
    
    internal func calculateFontSettings(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
        withAnimation(.easeInOut(duration: 1)) {
        if heightClass == .regular {
            if (900..<1000).contains(screenHeight) {
                return 32
            } else if (800..<900).contains(screenHeight) {
                return 30
            } else if  (600..<700).contains(screenHeight) {
                return 28
            } else if (700..<800).contains(screenHeight) {
                return 29
            } else if (1000..<1400).contains(screenHeight) {
                return 40
            } else {
                return 27
            }
        } else {
            if (300..<650).contains(screenHeight) {
                return 25
            } else {
                return 40
            }
        }
        }
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
    
    private func checkSymbols(str: String) -> Bool {
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




