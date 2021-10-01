//
//  WeatherModel.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import Foundation

struct Welcome: Codable {
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let main: String

    enum CodingKeys: String, CodingKey {
        case main
        
    }
}

