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
    }
}
