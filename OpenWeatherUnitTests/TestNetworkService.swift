//
//  TestNetworkService.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather

class TestNetworkService: XCTestCase {
    
    var session: URLSession!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
    }
    
    func test_get_city_by_name() throws {
        
        let service = NetworkService(session: session)
        
        let sampleData = Welcome(coord: Coord(lon: 0, lat: 0), weather: [Weather(main: "Clouds")],
                                 main: Main(temp: 1,
                                            feelsLike: 1,
                                            tempMin: 1,
                                            tempMax: 1,
                                            pressure: 1,
                                            humidity: 1),
                                 sys: Sys(sunrise: 1,
                                          sunset: 1),
                                 name: "Moscow")
        let mockData = try JSONEncoder().encode(sampleData)
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, nil)
        }
        
        
        service.getData(cityName: "") { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(item?.name, "Moscow")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.badURL)
            }
        }
    }
    
    func test_get_data_by_coordinates() throws {
        let service = NetworkService(session: session)
        
        let sampleData = Welcome(coord: Coord(lon: 0, lat: 0), weather: [Weather(main: "Clouds")],
                                 main: Main(temp: 1,
                                            feelsLike: 1,
                                            tempMin: 1,
                                            tempMax: 1,
                                            pressure: 1,
                                            humidity: 1),
                                 sys: Sys(sunrise: 1,
                                          sunset: 1),
                                 name: "Paris")
        let mockData = try JSONEncoder().encode(sampleData)
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, nil)
        }
        
        service.getDataByCoordinates(lat: 0, lon: 0) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(item?.name, "Paris")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.badURL)
            }
        }
    }
    
    func test_get_city_by_name_with_failure() throws {
        let service = NetworkService(session: session)
        
        let sampleData = NetworkError.badURL
        let error = NetworkError.badURL
        let mockData = try JSONEncoder().encode(sampleData)
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, error)
        }
        
        service.getData(cityName: "") { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(item?.name, "Moscow")
            case .failure(let error):
                XCTAssertEqual(error.hashValue, NetworkError.badURL.hashValue)
            }
        }
    }
    
}
