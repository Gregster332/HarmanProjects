//
//  NetworkService.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import Foundation


class NetworkService {
    
    func getData(cityName: String, completion: @escaping (Welcome?) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=c302a638f8f46f6a557e143a3a483647"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
//            if let httpResponse = response as? HTTPURLResponse {
                //print("statusCode: \(httpResponse.statusCode)")
//                if httpResponse.statusCode != 404 {
                    if let json = try? JSONDecoder().decode(Welcome.self, from: data) {
                        DispatchQueue.main.async {
                            completion(json)
                        }
                    } else {
                        completion(nil)
                    }
//                } else {
//                    DispatchQueue.main.async {
//                        completion(nil, httpResponse.statusCode)
//                    }
//                }
            
        }
        task.resume()
        
    }
    
}
