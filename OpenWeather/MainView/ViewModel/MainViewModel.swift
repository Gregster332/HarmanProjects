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
    @Published var showAddView: Bool = false
    @Published var showSetiingsView: Bool = false
    @Published var showSheet: Bool = false
    @Published var showAttentionLabel: Bool = false
    @Published var isThisNoInternetAttentionView: Bool = true
    
    let locationManager = LocationManager()
    let realmService = RealMService()
    
    internal func getCurrnetWeather() async {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location?.coordinate : CLLocationCoordinate2D()
        let service = NetworkService()
        DispatchQueue.main.async {
            service.getDataByCoordinates(lat: coordinate?.latitude ?? 0, lon: coordinate?.longitude ?? 0) { item in
                switch(item) {
                case .success(let result):
                    self.getCityFromWelcome(welcome: result)
                    print("okk")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
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
    
    internal func calculateFont(heightClass: UserInterfaceSizeClass?, screenHeight: CGFloat) -> CGFloat {
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


