//
//  OpenWeatherUnitTests.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather

class TestAddCityViewModel: XCTestCase {

    var sut: AddCityViewModel!
    let realm = RealMService()
    
    override func setUp() {
        sut = AddCityViewModel()
    }
    
    override func tearDown() {
        sut = nil
        realm.deleteAll()
    }
    
    
    func test_AddCityViewModel_checkSymbols_method() {
        let correctString = sut.checkSymbols(str: "Rostov-on-Don")
        let incorrectString = sut.checkSymbols(str: "112")
        let incorrectString2 = sut.checkSymbols(str: "")
        let incorrectString3 = sut.checkSymbols(str: " ")
        XCTAssertTrue(correctString)
        XCTAssertFalse(incorrectString)
        XCTAssertFalse(incorrectString2)
        XCTAssertFalse(incorrectString3)
    }
    
    func test_AddCityViewModel_addData_method() {
        
        var showThisView: Bool = false
        var showingAlert: Bool = false
        
        let realm = RealMService()
        realm.cityName = "Samara"
        
        sut.addNewData(realmService: realm, showingAlert: &showingAlert, showThisView: &showThisView)
        
        XCTAssertEqual(showThisView, true)
        XCTAssertEqual(showingAlert, false)
        XCTAssertEqual(realm.cityName, "")
    }
    
    func test_AddCityViewModel_addData_method_with_incorrect_cityName() {
        var showThisView: Bool = false
        var showingAlert: Bool = false
        
        let realm = RealMService()
        realm.cityName = "S1m@ra"
        
        sut.addNewData(realmService: realm, showingAlert: &showingAlert, showThisView: &showThisView)
        
        XCTAssertEqual(showThisView, false)
        XCTAssertEqual(showingAlert, true)
        XCTAssertEqual(realm.cityName, "")
    }
    
}
