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
    
    var body: some View {
        MapView(center: $viewModel.location)
            .padding()
            .frame(width: viewModel.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height),
                   height: Constants.Heights.settingsViewHeight3)
            .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
            .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            .onAppear {
                viewModel.location.longitude = lon
                viewModel.location.latitude = lat
            }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(lat: 30, lon: 30)
    }
}
