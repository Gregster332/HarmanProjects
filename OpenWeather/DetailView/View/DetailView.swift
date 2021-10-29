//
//  DetailView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI
import RealmSwift

struct DetailView: View {
    
    //MARK: - Variables
    var weatherDetails: City? = nil
    let isNavigationLink: Bool
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @StateObject var viewModel = DetailViewModel()
    
    //MARK: - Private observables
    @Binding var hideSheet: Bool
    
    
    var body: some View {
        //MARK: - View
        if weatherDetails != nil {
        ScrollView(.vertical, showsIndicators: false) {
            if isNavigationLink == false {
                HStack {
                    Image(systemName: "backward.fill")
                        .accessibilityIdentifier("backImage")
                        .foregroundColor(Constants.Colors.settingsViewColor)
                        .font(.system(size: heightClass == .regular ? Constants.Fonts.detailViewFragmentFont1 : Constants.Fonts.detailViewFragmentFont2))
                        .onTapGesture {
                            hideSheet.toggle()
                        }
                    
                    Text("current_info".localized(viewModel.language))
                        .font(.system(size: heightClass == .regular ? Constants.Fonts.detailViewFragmentFont1 : Constants.Fonts.detailViewFragmentFont2))
                        .fontWeight(.bold)
                        .accessibilityIdentifier("currentInfo")
                }
            }
            
            VStack {
                VStack(alignment: .center, spacing: Constants.Spacings.detailViewCurrentCityInfoSpacing) {
                    Text("\(weatherDetails!.name)")
                        .accessibilityIdentifier("cityLabel")
                        .font(.system(size: heightClass == .regular ? Constants.Fonts.detailViewFragmentFont1 : Constants.Fonts.detailViewFragmentFont2))
                    TempView(temp: weatherDetails!.temp - CGFloat(Constants.MathContants.toCelsius))
                    Text(weatherDetails!.main.lowercased().localized(viewModel.language))
                        .accessibilityIdentifier("descriptionLabel")
                        .font(.system(size: heightClass == .regular ? Constants.Fonts.detailViewFragmentFont1 : Constants.Fonts.detailViewFragmentFont2))
                    HStack {
                        Text("max:".localized(viewModel.language))
                        Text("\(Int(weatherDetails!.tempMax) - Constants.MathContants.toCelsius)º")
                            .accessibilityIdentifier("celsiusMaxLabel")
                        Text(", ")
                        Text("min:".localized(viewModel.language))
                        Text("\(Int(weatherDetails!.tempMin) - Constants.MathContants.toCelsius)º")
                            .accessibilityIdentifier("celsiusMinLabel")
                    }
                }
                .padding()
                
                VStack {
                    FragmentView(description: "feels_like".localized(viewModel.language),
                                 index: "\(Int(weatherDetails!.feelsLike) - Constants.MathContants.toCelsius)",
                                 imageName: PicturesNames.thermometer.rawValue,
                                 metric: Metrics.celsius.rawValue, viewModel: viewModel)
                    FragmentView(description: "humidity".localized(viewModel.language),
                                 index: "\(Int(weatherDetails!.humidity))",
                                 imageName: PicturesNames.dropFill.rawValue,
                                 metric: Metrics.percent.rawValue, viewModel: viewModel)
                    PressureView(description: "pressure".localized(viewModel.language),
                                 index: Int(weatherDetails!.pressure),
                                 imageName: PicturesNames.dialMin.rawValue,
                                 metric: Metrics.millimeters.rawValue)
                    FragmentView(description: "sunrise".localized(viewModel.language),
                                 index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunrise)).timeIn24HourFormat())",
                                 imageName: PicturesNames.sunriseFill.rawValue,
                                 metric: Metrics.empty.rawValue, viewModel: viewModel)
                    FragmentView(description: "sunset".localized(viewModel.language),
                                 index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunset)).timeIn24HourFormat())",
                                 imageName: PicturesNames.sunsetFill.rawValue,
                                 metric: Metrics.empty.rawValue, viewModel: viewModel)
                    LocationView(lat: weatherDetails!.lat, lon: weatherDetails!.lon, viewModel: viewModel)
                }
            }
            .padding()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: viewModel.changeBG(description: weatherDetails!.main)),
                           startPoint: UnitPoint(x: Constants.UnitPoints.x1,
                                                 y: Constants.UnitPoints.y1),
                           endPoint: UnitPoint(x: Constants.UnitPoints.x2,
                                               y: Constants.UnitPoints.y2))
                .edgesIgnoringSafeArea(.all)
                .blur(radius: Constants.Blurs.detailViewBlur)
        )
        .navigationBarTitle("current_info".localized(viewModel.language))
        } 
    }
   
}


