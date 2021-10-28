//
//  OpenWeatherUITests.swift
//  OpenWeatherUITests
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import XCTest
import SwiftUI
@testable import OpenWeather

class a_when_add_new_city_screen_is_presented: XCTestCase {
    
    
    func test_should_add_screen_displayed() {
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.buttons["showCityButton"]
        addButton.tap()
        
        let textField = app.textFields["AddCityTextFireld"]
        XCTAssertTrue(textField.exists, "Text field doesn't exist")
        textField.tap()
        textField.typeText("VALUE")
        XCTAssertEqual(textField.value as! String, "VALUE", "Text field value is not correct")
    }
    
    func test_should_add_screen_displayed_with_two_buttons() {
        
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.buttons["showCityButton"]
        addButton.tap()
        
        let buttonsSearch = app.buttons["searchButton"]
        let buttonCancel = app.buttons["cancelButton"]
        XCTAssertTrue(buttonsSearch.exists)
        XCTAssertTrue(buttonCancel.exists)
    }
    

        func test_should_add_screen_returns_to_parent() {
        let app = XCUIApplication()
        app.launch()

        let addButton = app.buttons["showCityButton"]
        addButton.tap()

        let textField = app.textFields["AddCityTextFireld"]
        textField.tap()
        textField.typeText("Moscow")

        let buttonsSearch = app.buttons["searchButton"]
        buttonsSearch.tap()

        let list = app.tables["list"]
        XCTAssertTrue(list.exists)
        sleep(3)
        let elementButton = app.buttons["Moscow"]
        XCTAssertTrue(elementButton.exists)
    }
    
    func test_should_add_screen_returns_to_parent_when_tap_cancel() {
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.buttons["showCityButton"]
        addButton.tap()
        
        let textField = app.textFields["AddCityTextFireld"]
        textField.tap()
        textField.typeText("Moscow")
        
        let pointBelowPassword = textField.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 2))
        pointBelowPassword.press(forDuration: 0.1)
        
        sleep(3)
        
        let elementButton = app.buttons["Moscow"]
        XCTAssertTrue(elementButton.exists)
    }
    
    func test_should_alert_when_enter_city_name_with_numbers() {
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.buttons["showCityButton"]
        addButton.tap()
        
        let textField = app.textFields["AddCityTextFireld"]
        textField.tap()
        textField.typeText("M@sc@w")
        let buttonsSearch = app.buttons["searchButton"]
        buttonsSearch.tap()
        sleep(2)
        
        if buttonsSearch.label == "Search" {
            XCTAssertEqual(app.alerts.element.label, "Something wrong🤨")
        } else {
            XCTAssertEqual(app.alerts.element.label, "Что-то не так🤨")
        }
        
        let okButton = app.alerts.element.buttons.firstMatch
        okButton.tap()
        
        XCTAssertTrue(!app.alerts.firstMatch.exists)
    }
}
