//
//  TestNetworkService.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather

class TestNetworkService: XCTestCase {

    var sut: NetworkService!
    
    override func setUp() {
        sut = NetworkService()
    }
    
    override func tearDown() {
        sut = nil
        //RealmServiceSecond.shared.deleteAllDatabase()
    }
    
    func test_NetworkService_getData_method() {
        sut.getData(cityName: "Moscow") { item in
            sleep(1)
            switch(item) {
            case .success(let result): XCTAssertTrue(result != nil)
            case .failure(let error): XCTAssertTrue(error.localizedDescription == "")
            }
        }
    }
    
    func test_NetworkService_getData_method_with_wrong_city() {
        sut.getData(cityName: "Moscow") { item in
            sleep(1)
            switch(item) {
            case .success(let result): XCTAssertTrue(result == nil)
            case .failure(let error): XCTAssertTrue(error.localizedDescription != "")
            }
        }
    }
    
    func test_NetworkService_getDataByCoordinates_method() {
        sut.getDataByCoordinates(lat: 56.987667, lon: 48.007890) { item in
            sleep(1)
            switch(item) {
            case .success(let result): XCTAssertTrue(result != nil)
            case .failure(let error): XCTAssertTrue(error.localizedDescription == "")
            }
        }
    }
    
    func test_NetworkService_getDataByCoordinates_method_with_bad_coordinates() {
        sut.getDataByCoordinates(lat: 564.334, lon: 564.334) { item in
            sleep(1)
            switch(item) {
            case .success(let result): XCTAssertTrue(result == nil)
            case .failure(let error): XCTAssertTrue(error.localizedDescription != "")
            }
        }
    }
}
