//
//  TestColorChangeService.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 07.10.2021.
//

import XCTest
import SwiftUI
@testable import OpenWeather

class TestColorChangeService: XCTestCase {

    var sut: ColorChangeService!
    
    override func setUp() {
        sut = ColorChangeService()
    }

    override func tearDown() {
        sut = nil
    }
    
    func test_ColorChangeService_color_getters_and_setters() {
        
        UserDefaults.standard.removeObject(forKey: "color")
        
        let color1 = sut.color
        XCTAssertEqual(color1, .green)
        
        sleep(2)
        
        sut.color = .purple
        XCTAssertEqual(sut.color, .purple)
        let color2 = sut.color
        XCTAssertEqual(color2, .purple)
        
        sut.color = .pink
        let color3 = sut.color
        XCTAssertEqual(color3, .pink)
    }
    
    func test_ColorChangeService_changeColor_method() {
        let color1 = sut.changeColor(color: "green")
        let color2 = sut.changeColor(color: "pink")
        let color3 = sut.changeColor(color: "purple")
        XCTAssertEqual(color1, Color.green)
        XCTAssertEqual(color2, Color.pink)
        XCTAssertEqual(color3, Color.purple)
    }
    
}
