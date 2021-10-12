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
    
    //MARK: - Get data by city name
    func getData(cityName: String, completion: @escaping (Result<Welcome?, NetworkError>) -> ()) {
        let urlString = "\(Constants.URLS.baseUrl)q=\(cityName)&appid=\(Constants.ApiKeys.apiKey)"
        guard let url = URL(string: urlString) else { return }
        doTask(url: url) { result in
            completion(result)
        }
    }
    
    //MARK: - Get data by coordinates
    func getDataByCoordinates(lat: Double, lon: Double, completion: @escaping (Result<Welcome?, NetworkError>) -> ()) {
        let urlString = "\(Constants.URLS.baseUrl)lat=\(lat)&lon=\(lon)&appid=\(Constants.ApiKeys.apiKey)"
        guard let url = URL(string: urlString) else { return }
        doTask(url: url) { result in
            completion(result)
        }
    }
    
    private func doTask(url: URL, completion: @escaping (Result<Welcome?, NetworkError>) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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




