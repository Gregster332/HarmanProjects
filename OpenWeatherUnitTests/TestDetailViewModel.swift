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
    let realm = RealMService()
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    
    override func setUp() {
        sut = DetailViewModel()
    }
    
    override func tearDown() {
        sut = nil
        realm.deleteAll()
    }
    
    func test_DetailViewModel_calculateWidth() {
        let number = sut?.calculateWidth(heightClass: heightClass)
        XCTAssertTrue(number! >= 350 && number! <= 600)
    }
}
