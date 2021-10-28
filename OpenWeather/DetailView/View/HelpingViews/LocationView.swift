//
//  LocationView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 25.10.2021.
//

import SwiftUI
import RealmSwift
import MapKit

struct LocationView: View {
    
    let lat: Double
    let lon: Double
    
    @ObservedObject var viewModel = DetailViewModel()
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    
    @State var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: Constants.CoordinateSpans.latDelta,           longitudeDelta: Constants.CoordinateSpans.lonDelta)
        )
    
    @State var loc = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    
    var body: some View {
        MapView(center: $loc)
            .padding()
            .frame(width: viewModel.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height),
                   height: Constants.Heights.settingsViewHeight3)
            .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
            .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            .onAppear {
                region.center.latitude = lat
                region.center.longitude = lon
                loc.latitude = lat
                loc.longitude = lon
            }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(lat: 30, lon: 30)
    }
}
