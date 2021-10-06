//
//  TestMainViewModel.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather
import CoreLocation

class TestMainViewModel: XCTestCase {

    var sut: MainViewModel!
    let realm = RealMService()
    let manager = LocationManager()
    
    override func setUp() {
        sut = MainViewModel()
    }
    
    override func tearDown() {
        sut = nil
        realm.deleteAll()
    }
    
    func test_MainViewModel_getCityFromWelcome_method() {
        let welcome = Welcome(weather: [Weather(main: "Clear")],
                              main: Main(temp: 12,
                                         feelsLike: 12,
                                         tempMin: 12,
                                         tempMax: 12,
                                         pressure: 12,
                                         humidity: 12),
                              sys: Sys(sunrise: 12,
                                       sunset: 12),
                              name: "Clear")
        
        sut.getCityFromWelcome(welcome: welcome)
        XCTAssertTrue(sut.currentCity != nil)
        XCTAssertEqual(sut.currentCity?.temp, 12)
        XCTAssertEqual(sut.currentCity?.tempMax, 12)
        XCTAssertEqual(sut.currentCity?.tempMin, 12)
        XCTAssertEqual(sut.currentCity?.feelsLike, 12)
        XCTAssertEqual(sut.currentCity?.pressure, 12)
        XCTAssertEqual(sut.currentCity?.humidity, 12)
        XCTAssertEqual(sut.currentCity?.sunset, 12)
        XCTAssertEqual(sut.currentCity?.sunrise, 12)
        XCTAssertEqual(sut.currentCity?.main, "Clear")
        XCTAssertEqual(sut.currentCity?.name, "Clear")
    }
    
    func test_MainViewModel_getCurrentWeather_method() async {
        XCTAssertTrue(sut.currentCity == nil)
        await sut.getCurrnetWeather()
        sleep(2)
        XCTAssertNotEqual(sut.currentCity?.name, nil)
    }
    
    func test_MainViewModel_getCurrentWeather_with_wrong_coordinates() async {
        manager.location = CLLocation(latitude: 0, longitude: 0)
        await sut.getCurrnetWeather()
        sleep(2)
        XCTAssertEqual(sut.currentCity?.name, "Globe")
    }
    
    func test_MainViewModel_calculateFont_method() {
        let font1 = sut.calculateFont(heightClass: .regular, screenHeight: 620)
        let font2 = sut.calculateFont(heightClass: .regular, screenHeight: 720)
        let font3 = sut.calculateFont(heightClass: .regular, screenHeight: 820)
        let font4 = sut.calculateFont(heightClass: .regular, screenHeight: 920)
        let font5 = sut.calculateFont(heightClass: .regular, screenHeight: 1100)
        let font6 = sut.calculateFont(heightClass: .regular, screenHeight: 500)
        let font7 = sut.calculateFont(heightClass: .compact, screenHeight: 500)
        let font8 = sut.calculateFont(heightClass: .compact, screenHeight: 1100)
        XCTAssertEqual(font1, 23)
        XCTAssertEqual(font2, 24)
        XCTAssertEqual(font3, 25)
        XCTAssertEqual(font4, 28)
        XCTAssertEqual(font5, 35)
        XCTAssertEqual(font6, 23)
        XCTAssertEqual(font7, 35)
        XCTAssertEqual(font8, 50)
    }
}
