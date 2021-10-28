//
//  OpenWeatherUITestsLaunchTests.swift
//  OpenWeatherUITests
//
//  Created by Grigory Zenkov on 30.09.2021.
//

import XCTest
@testable import OpenWeather

class OpenWeatherUITestsLaunchTests: XCTestCase {

    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
