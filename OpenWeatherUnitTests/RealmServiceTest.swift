//
//  RealmServiceTest.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 18.10.2021.
//

import XCTest
@testable import OpenWeather

class RealmServiceTest: XCTestCase {

    var sut: RealmServiceSecond!
    
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
        sut = RealmServiceSecond()
        sut.addCityToDatabase(city: addCity(name: "Paris"))
        sut.addCityToDatabase(city: addCity(name: "Moscow"))
    }
    
    override func tearDown() {
        sut.deleteAllDatabase()
        sut = nil
    }
    
    func test_fetchAll_from_db() {
        var array = [City]()
        sut.fetchAllFromDatabase { res in
            array = res
        }
        XCTAssertTrue(array.isEmpty == false)
        XCTAssertTrue(array.first?.name == "Moscow")
        XCTAssertTrue(array.first?.main == "Clear")
        XCTAssertTrue(array.first?.temp == 12)
        XCTAssertTrue(array.first?.tempMin == 12)
        XCTAssertTrue(array.first?.tempMax == 12)
        XCTAssertTrue(array.first?.pressure == 12)
        XCTAssertTrue(array.first?.humidity == 12)
        XCTAssertTrue(array.first?.feelsLike == 12)
        XCTAssertTrue(array.first?.sunset == 12)
        XCTAssertTrue(array.first?.sunrise == 12)
        XCTAssertTrue(array[1].name == "Paris")
        
    }

    func test_delete_city_drom_db() {
        var array = [City]()
        sut.fetchAllFromDatabase { res in
            array = res
        }
        sut.deleteCityFromDataBase(city: array[0])
        array.removeAll()
        sut.fetchAllFromDatabase { res in
            array = res
        }
        XCTAssertTrue(array.count > 0)
    }
    
    func test_deleteAll_from_db() {
        var array = [City]()
        sut.fetchAllFromDatabase { res in
            array = res
        }
        sut.deleteAllDatabase()
        array.removeAll()
        sut.fetchAllFromDatabase { res in
            array = res
        }
        XCTAssertTrue(array.isEmpty)
    }
    
    func test_update_item() {
        var array = [City]()
        sut.fetchAllFromDatabase { res in
            array = res
        }
        sut.updateItem(cityForDelete: array.first!, cityToAdd: addCity(name: "Ufa"))
        array.removeAll()
        sut.fetchAllFromDatabase { res in
            array = res
        }
        XCTAssertTrue(array.count == 2)
        XCTAssertEqual(array[1].name, "Ufa")
    }
}

