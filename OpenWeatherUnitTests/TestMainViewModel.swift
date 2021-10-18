//
//  TestMainViewModel.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 18.10.2021.
//

import XCTest
@testable import OpenWeather

class TestMainViewModel: XCTestCase {

    var sut: MainViewModel!
    
    private func addCity(name: String) -> City {
        let city = City()
        city.name = name
        city.main = "Clear"
        city.feelsLike = 12
        city.humidity = 12
        city.pressure = 12
        city.sunrise = 12
        city.sunset = 12
        city.temp = 12
        city.tempMax = 12
        city.tempMin = 12
        return city
    }
    
    override func setUp() {
        sut = MainViewModel()
        sut.addCityToDB(city: addCity(name: "Moscow"))
        sut.addCityToDB(city: addCity(name: "Paris"))
        sut.addCityToDB(city: addCity(name: "Yalolofo"))
    }
    
    override func tearDown() {
        //sut.deleteAllFromDB()
        sut = nil
    }
    
    func test_add_city_to_db() {
        XCTAssertTrue(sut.cities.isEmpty == false)
    }
    
    func test_delete_city_from_db() {
        sut.deleteCityFromDB(city: sut.cities[0])
        sleep(2)
        XCTAssertTrue(sut.cities.isEmpty == false)
        XCTAssertTrue(sut.cities.first?.name == "Paris")
    }
    
    func test_get_new_weather_for_all_cities() {
        sut.getNewWeatherForAllCities()
        sleep(3)
        XCTAssertTrue(sut.cities.count == 3)
    }
    
//    func test_get_current_weather() {
////        sut.locationManager.location?.coordinate.latitude = 56.888
////        sut.locationManager.location?.coordinate.longitude = 48.200
//        sleep(5)
//        Task {
//            await sut.getCurrnetWeather()
//        }
//        sleep(3)
//        print(sut.city?.name)
//        XCTAssertTrue(sut.city?.name == nil)
//    }
    
    func test_calculateFont() {
        let font1 = sut.calculateFont(heightClass: .regular, screenHeight: 650)
        let font2 = sut.calculateFont(heightClass: .regular, screenHeight: 750)
        let font3 = sut.calculateFont(heightClass: .regular, screenHeight: 850)
        let font4 = sut.calculateFont(heightClass: .regular, screenHeight: 950)
        let font5 = sut.calculateFont(heightClass: .regular, screenHeight: 1050)
        let font6 = sut.calculateFont(heightClass: .compact, screenHeight: 650)
        let font7 = sut.calculateFont(heightClass: .compact, screenHeight: 1100)
        let font8 = sut.calculateFont(heightClass: .regular, screenHeight: 550)
        XCTAssertTrue(font1 == 23)
        XCTAssertTrue(font2 == 24)
        XCTAssertTrue(font3 == 25)
        XCTAssertTrue(font4 == 28)
        XCTAssertTrue(font5 == 35)
        XCTAssertTrue(font6 == 35)
        XCTAssertTrue(font7 == 50)
        XCTAssertTrue(font8 == 23)
    }
    
    func test_claculate_width() {
        let w1 = sut.calculateWidth(heightClass: .regular, screenHeight: 650)
        let w2 = sut.calculateWidth(heightClass: .regular, screenHeight: 750)
        let w3 = sut.calculateWidth(heightClass: .regular, screenHeight: 850)
        let w4 = sut.calculateWidth(heightClass: .regular, screenHeight: 950)
        let w5 = sut.calculateWidth(heightClass: .regular, screenHeight: 1050)
        let w6 = sut.calculateWidth(heightClass: .compact, screenHeight: 650)
        let w7 = sut.calculateWidth(heightClass: .compact, screenHeight: 1100)
        let w8 = sut.calculateWidth(heightClass: .regular, screenHeight: 550)
        XCTAssertTrue(w1 == 330)
        XCTAssertTrue(w2 == 350)
        XCTAssertTrue(w3 == 370)
        XCTAssertTrue(w4 == 390)
        XCTAssertTrue(w5 == 500)
        XCTAssertTrue(w6 == 600)
        XCTAssertTrue(w7 == 600)
        XCTAssertTrue(w8 == 300)
    }
    
    func test_claculate_height() {
        let h = sut.calculateHeight(heightClass: .regular, screenHeight: 550)
        let h1 = sut.calculateHeight(heightClass: .regular, screenHeight: 650)
        let h2 = sut.calculateHeight(heightClass: .regular, screenHeight: 750)
        let h3 = sut.calculateHeight(heightClass: .regular, screenHeight: 850)
        let h4 = sut.calculateHeight(heightClass: .regular, screenHeight: 950)
        let h5 = sut.calculateHeight(heightClass: .regular, screenHeight: 1050)
        let h6 = sut.calculateHeight(heightClass: .compact, screenHeight: 650)
        let h7 = sut.calculateHeight(heightClass: .compact, screenHeight: 1100)
        XCTAssertTrue(h == 80)
        XCTAssertTrue(h1 == 80)
        XCTAssertTrue(h2 == 80)
        XCTAssertTrue(h3 == 80)
        XCTAssertTrue(h4 == 80)
        XCTAssertTrue(h5 == 80)
        XCTAssertTrue(h6 == 60)
        XCTAssertTrue(h7 == 80)
    }
    
    func test_calculate_width_for_framgment() {
        let w1 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 650)
        let w2 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 750)
        let w3 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 850)
        let w4 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 950)
        let w5 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 1050)
        let w6 = sut.calculateWidthForFramgment(heightClass: .compact, screenHeight: 650)
        let w7 = sut.calculateWidthForFramgment(heightClass: .compact, screenHeight: 1100)
        let w8 = sut.calculateWidthForFramgment(heightClass: .regular, screenHeight: 550)
        XCTAssertTrue(w1 == 290)
        XCTAssertTrue(w2 == 310)
        XCTAssertTrue(w3 == 330)
        XCTAssertTrue(w4 == 350)
        XCTAssertTrue(w5 == 440)
        XCTAssertTrue(w6 == 500)
        XCTAssertTrue(w7 == 500)
        XCTAssertTrue(w8 == 270)
    }
    
    func test_calculate_width_for_button() {
        let w1 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 650)
        let w2 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 750)
        let w3 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 850)
        let w4 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 950)
        let w5 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 1050)
        let w6 = sut.calculateWidthForButton(heightClass: .compact, screenHeight: 650)
        let w7 = sut.calculateWidthForButton(heightClass: .compact, screenHeight: 1100)
        let w8 = sut.calculateWidthForButton(heightClass: .regular, screenHeight: 550)
        XCTAssertTrue(w1 == 80)
        XCTAssertTrue(w2 == 100)
        XCTAssertTrue(w3 == 120)
        XCTAssertTrue(w4 == 140)
        XCTAssertTrue(w5 == 160)
        XCTAssertTrue(w6 == 190)
        XCTAssertTrue(w7 == 190)
        XCTAssertTrue(w8 == 80)
    }
    
    func test_calculate_font_settings() {
        let font1 = sut.calculateFontSettings(heightClass: .regular, screenHeight: 650)
        let font2 = sut.calculateFontSettings(heightClass: .regular, screenHeight: 750)
        let font3 = sut.calculateFontSettings(heightClass: .regular, screenHeight: 850)
        let font4 = sut.calculateFontSettings(heightClass: .regular, screenHeight: 950)
        let font5 = sut.calculateFontSettings(heightClass: .regular, screenHeight: 1050)
        let font6 = sut.calculateFontSettings(heightClass: .compact, screenHeight: 640)
        let font7 = sut.calculateFontSettings(heightClass: .compact, screenHeight: 1100)
        let font8 = sut.calculateFontSettings(heightClass: .regular, screenHeight: 550)
        XCTAssertTrue(font1 == 28)
        XCTAssertTrue(font2 == 29)
        XCTAssertTrue(font3 == 30)
        XCTAssertTrue(font4 == 32)
        XCTAssertTrue(font5 == 40)
        XCTAssertTrue(font6 == 25)
        XCTAssertTrue(font7 == 40)
        XCTAssertTrue(font8 == 27)
    }
    
    func test_change_language() {
        let lang1 = sut.language
        if lang1 == .english_us {
            sut.changeLanguage(to: .russian)
        } else {
            sut.changeLanguage(to: .english_us)
        }
        XCTAssertTrue(lang1 != sut.language)
    }
    
    func test_change_color() {
        let color = sut.color
        if color == .green {
            sut.changeColor(to: .purple)
        } else if color == .purple {
            sut.changeColor(to: .pink)
        } else {
            sut.changeColor(to: .green)
        }
        XCTAssertTrue(color != sut.color)
    }
    
    func test_add_new_city_to_db_by_name() {
        sut.searcedCurrentCity = "Atlanta"
        sut.addNewCityToDBBYName()
        sleep(3)
        XCTAssertTrue(sut.cities.count > 0)
        XCTAssertTrue(sut.cities.first?.name != nil)
        XCTAssertTrue(sut.searcedCurrentCity == "")
        XCTAssertTrue(sut.showAddView == true)
    }
    
    func test_add_new_city_to_db_by_name_with_failure() {
        sut.searcedCurrentCity = "Atlantatata"
        sut.addNewCityToDBBYName()
        sleep(3)
        XCTAssertTrue(sut.cities.count > 0)
        XCTAssertTrue(sut.cities.first?.name != nil)
        XCTAssertTrue(sut.searcedCurrentCity == "")
        XCTAssertTrue(sut.showAddView == true)
    }
    
    func test_add_new_city_to_db_by_name_with_wrong_name() {
        sut.searcedCurrentCity = "Atl@nt@"
        sut.addNewCityToDBBYName()
        sleep(3)
        XCTAssertTrue(sut.showingAlert == true)
        XCTAssertTrue(sut.searcedCurrentCity == "")
    }
}
