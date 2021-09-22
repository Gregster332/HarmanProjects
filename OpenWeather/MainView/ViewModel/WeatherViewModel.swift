//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var array: [Welcome] = []
    
    func add(name: String) {
        let n = NetworkService()
        n.getData(cityName: name) { item in
            DispatchQueue.main.async {
                self.array.append(item)
            }
        }
    }
    
}
