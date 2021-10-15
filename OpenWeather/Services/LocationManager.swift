//
//  LocationManager.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 25.09.2021.
//

import Foundation
import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
}
