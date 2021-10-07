//
//  File.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 01.10.2021.
//

import SwiftUI

class AddCityViewModel: ObservableObject {
    
    internal func addNewData(realmService: RealMService, showingAlert: inout Bool, showThisView: inout Bool) {
        if checkSymbols(str: realmService.cityName) {
            let service = NetworkService()
            
            service.getData(cityName: realmService.cityName) { item in
                //print(item)
                switch(item) {
                case .success(let result):
                    realmService.addData(name: result!.name,
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
                }
            }
            showThisView.toggle()
            realmService.cityName = ""
            UIApplication.shared.endEditing()
        } else {
            showingAlert = true
            realmService.cityName = ""
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
    
//    internal func changeColor(color: String) -> Color {
//        
//    }
    
}
