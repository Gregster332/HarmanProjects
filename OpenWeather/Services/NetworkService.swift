//
//  NetworkService.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

class NetworkService {
    //
    //MARK: - Get data by city name
    func getData(cityName: String, completion: @escaping (Result<Welcome?, NetworkError>) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            if (response as! HTTPURLResponse).statusCode == 200 {
                guard let data = data else { return }
                if let json = try? JSONDecoder().decode(Welcome.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(json))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.badURL))
                }
            }
        }
        task.resume()
    }
    
    //MARK: - Get data by coordinates
    func getDataByCoordinates(lat: Double, lon: Double, completion: @escaping (Result<Welcome?, NetworkError>) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //guard error == nil else { return }
            if (response as! HTTPURLResponse).statusCode == 200 || error != nil {
                guard let data = data else { return }
                if let json = try? JSONDecoder().decode(Welcome.self, from: data) {
                    DispatchQueue.main.async {
                        completion(.success(json))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.badURL))
                }
            }
        }
        task.resume()
    }
}
