//
//  TestLocalizationService.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 07.10.2021.
//

import XCTest
@testable import OpenWeather

class TestLocalizationService: XCTestCase {

    var service: LocalizationService!
    
    override func setUp() {
        service = LocalizationService.shared
    }

    override func tearDown() {
        service = nil
    }
    
    func test_LocalizationService_language_by_default() {
        let ud = UserDefaults.standard
        
        ud.removeObject(forKey: "language")
        
        sleep(1)
        
        let lang = service.language
        XCTAssertTrue(lang == .english_us)
        
    }
    
    func test_set_language() {
        service.language = .english_us
        XCTAssertEqual(service.language, .english_us)
        service.language = .russian
        XCTAssertEqual(service.language, .russian)
    }
}
