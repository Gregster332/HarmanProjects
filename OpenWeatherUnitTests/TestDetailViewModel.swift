//
//  TestDetailViewModel.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather
import SwiftUI

class TestDetailViewModel: XCTestCase {

    var sut: DetailViewModel?
    
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    
    override func setUp() {
        sut = DetailViewModel()
    }
    
    override func tearDown() {
        sut = nil
        //RealmServiceSecond.shared.deleteAllDatabase()
    }
    
    func test_DetailViewModel_calculateWidth() {
        let iPhone8Width = sut?.calculateWidth(heightClass: .regular, screenHeight: 650)
        let iPhone8PlusWidth = sut?.calculateWidth(heightClass: .regular, screenHeight: 730)
        let iPhone11Width = sut?.calculateWidth(heightClass: .regular, screenHeight: 830)
        let iPhone11ProMaxWidth = sut?.calculateWidth(heightClass: .regular, screenHeight: 930)
        let iPad = sut?.calculateWidth(heightClass: .regular, screenHeight: 1100)
        let iPhone5SE = sut?.calculateWidth(heightClass: .regular, screenHeight: 510)
        let compactIPhone = sut?.calculateWidth(heightClass: .compact, screenHeight: 500)
        let compactIPad = sut?.calculateWidth(heightClass: .compact, screenHeight: 1100)
        XCTAssertEqual(iPhone8Width, 350)
        XCTAssertEqual(iPhone8PlusWidth, 370)
        XCTAssertEqual(iPhone11Width, 370)
        XCTAssertEqual(iPhone11ProMaxWidth, 390)
        XCTAssertEqual(iPad, 500)
        XCTAssertEqual(iPhone5SE, 300)
        XCTAssertEqual(compactIPhone, 600)
        XCTAssertEqual(compactIPad, 500)
    }
    
    func test_DetailViewModel_calculateFont() {
        let iPhone8Font = sut?.calculateFont(heightClass: .regular, screenHeight: 640)
        let iPhone8PlusFont = sut?.calculateFont(heightClass: .regular, screenHeight: 710)
        let iPhone11Font = sut?.calculateFont(heightClass: .regular, screenHeight: 820)
        let iPhone11ProMaxFont = sut?.calculateFont(heightClass: .regular, screenHeight: 910)
        let iPadFont = sut?.calculateFont(heightClass: .regular, screenHeight: 1100)
        let iPhone5SEFont = sut?.calculateFont(heightClass: .regular, screenHeight: 550)
        let compactIphone = sut?.calculateFont(heightClass: .compact, screenHeight: 400)
        let compactIpad = sut?.calculateFont(heightClass: .compact, screenHeight: 700)
        XCTAssertEqual(iPhone8Font, 28)
        XCTAssertEqual(iPhone8PlusFont, 29)
        XCTAssertEqual(iPhone11Font, 30)
        XCTAssertEqual(iPhone11ProMaxFont, 32)
        XCTAssertEqual(iPadFont, 40)
        XCTAssertEqual(iPhone5SEFont, 28)
        XCTAssertEqual(compactIphone, 32)
        XCTAssertEqual(compactIpad, 45)
    }
}
