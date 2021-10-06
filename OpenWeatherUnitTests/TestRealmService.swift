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
        sut.deleteAll()
    }

    override func tearDown() {
        sut.deleteAll()
        sleep(2)
        sut = nil
    }
    
    func test_A_RealMService_addData_method() {
       // XCTAssertTrue(sut.cities.isEmpty)
        print("11")
        sut.addData(name: "Moscow",
                    feelsLike: 100,
                    sunrise: 100,
                    sunset: 100,
                    temp: 100,
                    tempMin: 100,
                    tempMax: 100,
                    pressure: 100,
                    humidity: 100,
                    main: "Clear")
        sut.addData(name: "Samara",
                    feelsLike: 100,
                    sunrise: 100,
                    sunset: 100,
                    temp: 100,
                    tempMin: 100,
                    tempMax: 100,
                    pressure: 100,
                    humidity: 100,
                    main: "Clear")
        XCTAssertTrue(!sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.count, 2)
    }
    
    func test_RealMService_deleteObject_method() {
        print("22")
        sut.addData(name: "Moscow",
                    feelsLike: 100,
                    sunrise: 100,
                    sunset: 100,
                    temp: 100,
                    tempMin: 100,
                    tempMax: 100,
                    pressure: 100,
                    humidity: 100,
                    main: "Clear")
        sut.addData(name: "Samara",
                    feelsLike: 100,
                    sunrise: 100,
                    sunset: 100,
                    temp: 100,
                    tempMin: 100,
                    tempMax: 100,
                    pressure: 100,
                    humidity: 100,
                    main: "Clear")
        print(sut.cities)
        sut.deleteData(object: sut.cities.last!)
        XCTAssertTrue(!sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.count, 1)
    }
    
    
    //    func test_RealMService_getNewData_method() {
//        print("33")
//        sut.addData(name: "Moscow",
//                    feelsLike: 100,
//                    sunrise: 100,
//                    sunset: 100,
//                    temp: 100,
//                    tempMin: 100,
//                    tempMax: 100,
//                    pressure: 100,
//                    humidity: 100,
//                    main: "Clear")
//        sut.addData(name: "Samara",
//                    feelsLike: 100,
//                    sunrise: 100,
//                    sunset: 100,
//                    temp: 100,
//                    tempMin: 100,
//                    tempMax: 100,
//                    pressure: 100,
//                    humidity: 100,
//                    main: "Clear")
//        print(sut.cities)
//        sut.getNewData()
//        //print(sut.cities)
//        sleep(5)
//        sut.cities.forEach { city in
//            XCTAssertNotEqual(city.temp, 100)
//        }
//    }
}
