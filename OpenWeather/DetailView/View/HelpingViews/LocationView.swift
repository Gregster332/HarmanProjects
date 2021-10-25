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
    @State private var bigMap: Bool = false
    @State var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    
    var body: some View {
        Map(coordinateRegion: $region)
            .padding()
            .frame(width: viewModel.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height),
                   height: 400)
            .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
            .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            .onTapGesture {
                bigMap.toggle()
            }
            .onAppear {
                region.center.latitude = lat
                region.center.longitude = lon
            }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(lat: 30, lon: 30)
    }
}
