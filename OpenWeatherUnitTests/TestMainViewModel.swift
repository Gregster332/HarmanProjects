//
//  TestMainViewModel.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather

class TestMainViewModel: XCTestCase {

    var sut: MainViewModel!
    let realm = RealMService()
    
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
    }
    

}
