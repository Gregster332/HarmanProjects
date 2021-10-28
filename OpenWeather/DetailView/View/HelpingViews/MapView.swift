//
//  MapView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 27.10.2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    @Binding var center: CLLocationCoordinate2D

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .hybridFlyover
        mapView.showsBuildings = true
        
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = center
        mapCamera.pitch = 45
        mapCamera.altitude = 500
        mapCamera.heading = 45
        mapView.camera = mapCamera
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        uiView.setCenter(center, animated: true)
    }
}
