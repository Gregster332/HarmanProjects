//
//  TestMainViewModel.swift
//  OpenWeatherUnitTests
//
//  Created by Grigory Zenkov on 18.10.2021.
//

import XCTest
import Cuckoo
@testable import OpenWeather
import CoreLocation

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
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_get_current_weather() async {
        var isGetCurrentWeatherVisited = false
        let mockData = Welcome(coord: Coord(lon: 0, lat: 0), weather: [Weather(main: "Clouds")],
                               main: Main(temp: 2000,
                                          feelsLike: 1,
                                          tempMin: 1,
                                          tempMax: 1,
                                          pressure: 1,
                                          humidity: 1),
                               sys: Sys(sunrise: 1,
                                        sunset: 1),
                         name: "A")
        
        let sMock = MockNetworkService()
        
        stub(sMock) { stub in
            stub.getDataByCoordinates(lat: any(), lon: any(), completion: anyClosure()).then { (_, _, completions) in
                isGetCurrentWeatherVisited = true
                completions(.success(mockData))
                isGetCurrentWeatherVisited.toggle()
                completions(.failure(NetworkError.badURL))
                verify(sMock, times(1)).getDataByCoordinates(lat: any(), lon: any(), completion: anyClosure())
                XCTAssertTrue(!isGetCurrentWeatherVisited)
            }
        }

        sut = MainViewModel(service: sMock)
        Task(priority: .high) {
        await sut.getCurrnetWeather()
        }
        
    }
    
    func test_add_city_to_db() {
        var flag = false
        let rMock = MockRealmServiceSecond()
        rMock.enableDefaultImplementation(RealmServiceSecond())
        
        stub(rMock) { stub in
            stub.addCityToDatabase(city: any()).then { (_) in
                flag = true
                XCTAssertTrue(flag)
            }
        }
        
        sut = MainViewModel(realm: rMock)
        sut.addCityToDB(city: addCity(name: "NONE"))
    }
    
    func test_delete_city_from_db() {
        var flag = false
        let rMock = MockRealmServiceSecond()
        rMock.enableDefaultImplementation(RealmServiceSecond())
        
        stub(rMock) { stub in
            stub.deleteCityFromDataBase(city: any()).then { (_) in
                flag = true
                XCTAssertTrue(flag)
            }
        }
        
        sut = MainViewModel(realm: rMock)
        sut.deleteCityFromDB(city: City())
    }
    
    func test_delete_all_db() {
        var flag = false
        let rMock = MockRealmServiceSecond()
        rMock.enableDefaultImplementation(RealmServiceSecond())
        
        stub(rMock) { stub in
            stub.deleteAllDatabase().then { () in
                flag = true
                XCTAssertTrue(flag)
            }
        }
        
        sut = MainViewModel(realm: rMock)
        sut.deleteAllFromDB()
    }
    
    func test_get_new_weather_for_all_cities() throws {
        
        var isGetDataVisited = false
        let mockData = Welcome(coord: Coord(lon: 0, lat: 0), weather: [Weather(main: "Clouds")],
                               main: Main(temp: 2000,
                                          feelsLike: 1,
                                          tempMin: 1,
                                          tempMax: 1,
                                          pressure: 1,
                                          humidity: 1),
                               sys: Sys(sunrise: 1,
                                        sunset: 1),
                         name: "Moscow")
        
        let rMock = MockRealmServiceSecond()
        let sMock = MockNetworkService()
        
        sMock.enableDefaultImplementation(NetworkService())
        rMock.enableDefaultImplementation(RealmServiceSecond())
        
        stub(sMock) { stub in
            stub.getData(cityName: anyString(), completion: anyClosure()).then { (_, completions) in
                isGetDataVisited.toggle()
                completions(.success(mockData))
                isGetDataVisited.toggle()
                completions(.failure(NetworkError.badURL))
            }
        }
        sut = MainViewModel(realm: rMock, service: sMock)
        sut.getNewWeatherForAllCities()
        
        XCTAssertTrue(!isGetDataVisited)
    }
    
    
    
    
    func test_add_new_city_to_db_by_name() {
        var flag = false
        let mockData = Welcome(coord: Coord(lon: 0, lat: 0), weather: [Weather(main: "Clouds")],
                               main: Main(temp: 2000,
                                          feelsLike: 1,
                                          tempMin: 1,
                                          tempMax: 1,
                                          pressure: 1,
                                          humidity: 1),
                               sys: Sys(sunrise: 1,
                                        sunset: 1),
                         name: "Moscow")
        
        let sMock = MockNetworkService()
        let rMock = MockRealmServiceSecond()
        
        sMock.enableDefaultImplementation(NetworkService())
        rMock.enableDefaultImplementation(RealmServiceSecond())
        
        
        
        stub(sMock) { stub in
            stub.getData(cityName: anyString(), completion: anyClosure()).then { (_, completions) in
                flag.toggle()
                completions(.success(mockData))
                flag.toggle()
                completions(.failure(NetworkError.badURL))
            }
        }
        
        sut = MainViewModel(realm: rMock, service: sMock)
        sut.searcedCurrentCity = "Moscow"
        sut.addNewCityToDBBYName()
        
        XCTAssertTrue(!flag)
        
    }
    
    func test_get_city_from_welcome() {
        let welcome = Welcome(coord: Coord(lon: 0, lat: 0), weather: [Weather(main: "Clouds")],
                              main: Main(temp: 1,
                                         feelsLike: 1,
                                         tempMin: 1,
                                         tempMax: 1,
                                         pressure: 1,
                                         humidity: 1),
                              sys: Sys(sunrise: 1,
                                       sunset: 1),
                              name: "Paris")
        let city = sut.getCityFromWelcome(welcome: welcome)
        XCTAssertTrue(city != nil)
        XCTAssertEqual(city?.name, "Paris")
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
}
