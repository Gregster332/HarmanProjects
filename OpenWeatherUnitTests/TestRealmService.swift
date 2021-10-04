//
//  TestRealmService.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather

class TestRealmService: XCTestCase {

    var sut: RealMService!
    
    private func getNewCity() -> City {
        let city = City()
        city.name = "Samara"
        city.main = "Clear"
        city.feelsLike = 12
        city.temp = 12
        city.tempMax = 12
        city.tempMin = 12
        city.humidity = 12
        city.pressure = 12
        city.sunset = 8787
        city.sunrise = 8787
        return city
    }
    
    override func setUp() {
        sut = RealMService()
    }

    override func tearDown() {
        sut = nil
        sut.deleteAll()
    }
    
    func test_RealMService_addData_method() {
        sut.deleteAll()
        
        sut.addData(name: "Samara",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        
        sleep(2)
        
        XCTAssertTrue(!sut.cities.isEmpty)
    }
    
    func test_RealMService_deleteData_method() {
        sut.cities.forEach { city in
            sut.deleteData(object: city)
        }
        XCTAssertTrue(sut.cities.isEmpty)
    }
    
    func test_RealMService_fetchData_method() {
        sut.deleteAll()
        sut.addData(name: "Samara",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.addData(name: "Atlanta",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.addData(name: "Moscow",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.fetchData()
        sleep(3)
        XCTAssertEqual(sut.cities.count, 3)
        XCTAssertTrue(sut.cities[0].name == "Atlanta")
        XCTAssertTrue(sut.cities[1].name == "Moscow")
        XCTAssertTrue(sut.cities[2].name == "Samara")
    }
    
    func test_RealMService_getNewData_method() {
        sut.deleteAll()
        sut.addData(name: "Samara",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.addData(name: "Atlanta",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.addData(name: "Moscow",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.fetchData()
        sut.getNewData()
        sleep(3)
        XCTAssertEqual(sut.cities.count, 3)
        XCTAssertTrue(sut.cities[0].feelsLike > -20 && sut.cities[0].feelsLike < 40)
        XCTAssertTrue(sut.cities[1].feelsLike > -20 && sut.cities[1].feelsLike < 40)
        XCTAssertTrue(sut.cities[2].feelsLike > -20 && sut.cities[2].feelsLike < 40)
    }
    
    func test_RealMService_getNewData_method_with_bad_cities() {
        sut.deleteAll()
        sut.addData(name: "S@m1ra",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.addData(name: "@tl&n+a",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.addData(name: "M0sc0w",
                    feelsLike: 12,
                    sunrise: 8787,
                    sunset: 8787,
                    temp: 12,
                    tempMin: 12,
                    tempMax: 12,
                    pressure: 12,
                    humidity: 12,
                    main: "Clear")
        sut.fetchData()
        sut.getNewData()
        sleep(3)
        XCTAssertEqual(sut.cities.count, 3)
        
    }
    
}
