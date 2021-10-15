//
//  File.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 01.10.2021.
//

import SwiftUI

class AddCityViewModel: ObservableObject {
    
    var language = LocalizationService.shared.language
    var color = ColorChangeService.shared.color
    
    let locationManager = LocationManager.shared
    let realmService = RealmServiceSecond.shared
    let networkService = NetworkService.shared
    
    @Published var currentCity: String = ""
    @Published var showingAlert: Bool = false
    
//    internal func addNewData(realmService: RealMService, showingAlert: inout Bool, showThisView: inout Bool) {
//        if checkSymbols(str: currentCity) {
//            let service = NetworkService()
//            service.getData(cityName: realmService.cityName) { item in
//                //print(item)
//                switch(item) {
//                case .success(let result):
//                    realmService.addData(name: result!.name,
//                                         feelsLike: result!.main.feelsLike,
//                                         sunrise: result!.sys.sunrise,
//                                         sunset: result!.sys.sunset,
//                                         temp: result!.main.temp,
//                                         tempMin: result!.main.tempMin,
//                                         tempMax: result!.main.tempMax,
//                                         pressure: result!.main.pressure,
//                                         humidity: result!.main.humidity,
//                                         main: result!.weather.first!.main)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//            showThisView.toggle()
//            realmService.cityName = ""
//            UIApplication.shared.endEditing()
//        } else {
//            showingAlert = true
//            realmService.cityName = ""
//        }
//    }
    
    internal func addNewCityToDBBYName() {
        if checkSymbols(str: currentCity) {
            networkService.getData(cityName: currentCity) { result in
                switch(result) {
                case .success(let item):
                    self.addCityToDB(city: self.getCityFromWelcome(welcome: item)!)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            currentCity = ""
            UIApplication.shared.endEditing()
            //showThisView.toggle()
        } else {
            showingAlert = true
            currentCity = ""
        }
    }
    
    private func getCityFromWelcome(welcome: Welcome?) -> City? {
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
    
    private func addCityToDB(city: City) {
        realmService.addCityToDatabase(city: city)
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
