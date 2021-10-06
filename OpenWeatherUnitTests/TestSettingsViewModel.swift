//
//  TestSettingsViewModel.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 06.10.2021.
//

import XCTest
@testable import OpenWeather

class TestSettingsViewModel: XCTestCase {

    var sut: SettingViewModel!
    
    override func setUp() {
        sut = SettingViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_SettingsViewModel_calculateWidth_method() {
        let width1 = sut.calculateWidth(heightClass: .regular, screenHeight: 950)
        let width2 = sut.calculateWidth(heightClass: .regular, screenHeight: 820)
        let width3 = sut.calculateWidth(heightClass: .regular, screenHeight: 750)
        let width4 = sut.calculateWidth(heightClass: .regular, screenHeight: 650)
        let width5 = sut.calculateWidth(heightClass: .regular, screenHeight: 1100)
        let width6 = sut.calculateWidth(heightClass: .regular, screenHeight: 500)
        let width7 = sut.calculateWidth(heightClass: .compact, screenHeight: 500)
        let width8 = sut.calculateWidth(heightClass: .compact, screenHeight: 1100)
        XCTAssertEqual(width1, 390)
        XCTAssertEqual(width2, 370)
        XCTAssertEqual(width3, 350)
        XCTAssertEqual(width4, 330)
        XCTAssertEqual(width5, 500)
        XCTAssertEqual(width6, 300)
        XCTAssertEqual(width7, 600)
        XCTAssertEqual(width8, 500)
    }
    
    func test_SettingsViewModel_calculateWidthForFragment_method() {
        let width1 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 950)
        let width2 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 820)
        let width3 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 750)
        let width4 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 650)
        let width5 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 1100)
        let width6 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 500)
        let width7 = sut.calculateWidthForFramgment(heightClass: .compact, screenHeight: 500)
        let width8 = sut.calculateWidthForFramgment(heightClass: .compact, screenHeight: 1100)
        XCTAssertEqual(width1, 350)
        XCTAssertEqual(width2, 330)
        XCTAssertEqual(width3, 310)
        XCTAssertEqual(width4, 290)
        XCTAssertEqual(width5, 440)
        XCTAssertEqual(width6, 270)
        XCTAssertEqual(width7, 400)
        XCTAssertEqual(width8, 400)
    }
    
    func test_SettingViewModel_calculateWidthForButton_method() {
        let width1 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 950)
        let width2 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 820)
        let width3 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 750)
        let width4 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 650)
        let width5 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 1100)
        let width6 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 500)
        let width7 = sut.calculateWidthForButton(heightClass: .compact, screenHeight: 500)
        let width8 = sut.calculateWidthForButton(heightClass: .compact, screenHeight: 1100)
        XCTAssertEqual(width1, 140)
        XCTAssertEqual(width2, 120)
        XCTAssertEqual(width3, 100)
        XCTAssertEqual(width4, 80)
        XCTAssertEqual(width5, 160)
        XCTAssertEqual(width6, 80)
        XCTAssertEqual(width7, 150)
        XCTAssertEqual(width8, 150)
    }
    
    func test_SettingViewModel_calculateFontMethod() {
        let font1 = sut.calculateFont(heightClass: .regular, screenHeight: 950)
        let font2 = sut.calculateFont(heightClass: .regular, screenHeight: 820)
        let font3 = sut.calculateFont(heightClass: .regular, screenHeight: 750)
        let font4 = sut.calculateFont(heightClass: .regular, screenHeight: 650)
        let font5 = sut.calculateFont(heightClass: .regular, screenHeight: 1100)
        let font6 = sut.calculateFont(heightClass: .regular, screenHeight: 500)
        let font7 = sut.calculateFont(heightClass: .compact, screenHeight: 500)
        let font8 = sut.calculateFont(heightClass: .compact, screenHeight: 1100)
        XCTAssertEqual(font1, 32)
        XCTAssertEqual(font2, 30)
        XCTAssertEqual(font3, 29)
        XCTAssertEqual(font4, 28)
        XCTAssertEqual(font5, 40)
        XCTAssertEqual(font6, 27)
        XCTAssertEqual(font7, 32)
        XCTAssertEqual(font8, 45)
    }

}
