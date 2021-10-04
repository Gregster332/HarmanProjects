//
//  TestDateExtension.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 04.10.2021.
//

import XCTest
@testable import OpenWeather

class TestDateExtension: XCTestCase {

    func test_Date_extension_returns() {
        let date = Date()
        let stringDate = date.timeIn24HourFormat()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        let StringDate2 = formatter.string(from: date)
        XCTAssertEqual(stringDate, StringDate2)
    }

}
