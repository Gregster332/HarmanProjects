//
//  TestDetailScreen.swift
//  OpenWeatherUITests
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import XCTest
import SwiftUI

class TestDetailScreen: XCTestCase {

    func test_should_tap_on_userLocation_label_displayed_detail() {
        let app = XCUIApplication()
        app.launch()
        
        sleep(3)
        
        let locationCell = app.buttons["navlocation"]
        locationCell.tap()
        
        let cityLabel = app.staticTexts["cityLabel"]
        let celsiusLabel = app.staticTexts["celsiusLabel"]
        let descriptionLabel = app.staticTexts["descriptionLabel"]
        let celsiusMaxLabel = app.staticTexts["celsiusMaxLabel"]
        let celsiusMinLabel = app.staticTexts["celsiusMinLabel"]
        let backImage = app.staticTexts["backImage"]
        let currentInfo = app.staticTexts["currentInfo"]
        
        XCTAssertTrue(cityLabel.exists)
        XCTAssertTrue(celsiusLabel.exists)
        XCTAssertTrue(descriptionLabel.exists)
        XCTAssertTrue(celsiusMaxLabel.exists)
        XCTAssertTrue(celsiusMinLabel.exists)
        XCTAssertFalse(backImage.exists)
        XCTAssertFalse(currentInfo.exists)
    }
    
    func test_should_displayed_fragmentView() {
        let app = XCUIApplication()
        app.launch()
        
        sleep(3)
        
        let locationCell = app.buttons["navlocation"]
        locationCell.tap()
        
        let feelsLikeLabel = app.staticTexts["DescText"]
        XCTAssertTrue(feelsLikeLabel.exists)
    }
    
}
