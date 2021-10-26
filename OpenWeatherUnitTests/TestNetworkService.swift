//
//  TestNetworkService.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather

class TestNetworkService: XCTestCase {

//    var sut: NetworkService!
//
//    override func setUp() {
//        sut = NetworkService()
//    }
//
//    override func tearDown() {
//        sut = nil
//        //RealmServiceSecond.shared.deleteAllDatabase()
//    }
//
//    func test_NetworkService_getData_method() {
//        sut.getData(cityName: "Moscow") { item in
//            sleep(1)
//            switch(item) {
//            case .success(let result): XCTAssertTrue(result != nil)
//            case .failure(let error): XCTAssertTrue(error.localizedDescription == "")
//            }
//        }
//    }
//
//    func test_NetworkService_getData_method_with_wrong_city() {
//        sut.getData(cityName: "Moscow") { item in
//            sleep(1)
//            switch(item) {
//            case .success(let result): XCTAssertTrue(result == nil)
//            case .failure(let error): XCTAssertTrue(error.localizedDescription != "")
//            }
//        }
//    }
//
//    func test_NetworkService_getDataByCoordinates_method() {
//        sut.getDataByCoordinates(lat: 56.987667, lon: 48.007890) { item in
//            sleep(1)
//            switch(item) {
//            case .success(let result): XCTAssertTrue(result != nil)
//            case .failure(let error): XCTAssertTrue(error.localizedDescription == "")
//            }
//        }
//    }
//
//    func test_NetworkService_getDataByCoordinates_method_with_bad_coordinates() {
//        sut.getDataByCoordinates(lat: 564.334, lon: 564.334) { item in
//            sleep(1)
//            switch(item) {
//            case .success(let result): XCTAssertTrue(result == nil)
//            case .failure(let error): XCTAssertTrue(error.localizedDescription != "")
//            }
//        }
//    }
    
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
        //let error: Error? = nil
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, nil)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        service.getData(cityName: "") { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(item?.name, "Moscow")
                //expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.badURL)
                //expectation.fulfill()
            }
        }
        //wait(for: [expectation], timeout: 1)
        
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
        //let error = nil
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, nil)
        }
        
        let expectation = XCTestExpectation(description: "response")
        service.getDataByCoordinates(lat: 0, lon: 0) { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(item?.name, "Paris")
                //expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.badURL)
                //expectation.fulfill()
            }
        }
        //wait(for: [expectation], timeout: 1)
        
    }
    
    func test_get_city_by_name_with_failure() throws {
        let service = NetworkService(session: session)
        
        let sampleData = NetworkError.badURL
        let error = NetworkError.badURL
        let mockData = try JSONEncoder().encode(sampleData)
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData, error)
        }
        
        let expectation = XCTestExpectation(description: "response")
        service.getData(cityName: "") { result in
            switch result {
            case .success(let item):
                XCTAssertEqual(item?.name, "Moscow")
                //expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error.hashValue, NetworkError.badURL.hashValue)
                //expectation.fulfill()
            }
        }
        //wait(for: [expectation], timeout: 1)
    }
    
}
