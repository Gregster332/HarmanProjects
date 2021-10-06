//
//  TestSettingsScreen.swift
//  OpenWeatherUITests
//
//  Created by Grigory Zenkov on 06.10.2021.
//

import XCTest

class TestSettingsScreen: XCTestCase {

    func test_tap_on_gear_should_open_settings() {
        let app = XCUIApplication()
        app.launch()
        
        let gear = app.buttons["Gear"]
        gear.tap()
        
        sleep(1)
        
        let settingsText = app.staticTexts["settings"]
        XCTAssertTrue(settingsText.exists)
        
        let backButton = app.images["back"]
        backButton.tap()
        
        sleep(3)
        let navButton = app.buttons["navlocation"]
        
        XCTAssertTrue(navButton.exists)
    }
    
    func test_tap_on_delete_button_in_settingsView_deleteDB() {
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
        
        let gear = app.buttons["Gear"]
        gear.tap()
        
        sleep(1)
        
        let deleteBtn = app.buttons["delete"]
        deleteBtn.tap()
        
        sleep(1)
        
        let backButton = app.images["back"]
        backButton.tap()
        
        XCTAssertTrue(!elementButton.exists)
        
        gear.tap()
        
        sleep(1)
        
        deleteBtn.tap()
        
        sleep(1)
        
        XCTAssertEqual(app.alerts.element.label, "Databese is empty")
    }

}
