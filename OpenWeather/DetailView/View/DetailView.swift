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
    @State var weatherDetails: City? = nil
    let isNavigationLink: Bool
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @ObservedObject var model = DetailViewModel()
    
    
    
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
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                        .onTapGesture {
                            hideSheet.toggle()
                            weatherDetails = nil
                        }
                    
                    Text("current_info".localized(model.language))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                        .fontWeight(.bold)
                        .accessibilityIdentifier("currentInfo")
                }
            }
            
            VStack {
                VStack(alignment: .center, spacing: 10) {
                    Text("\(weatherDetails!.name)")
                        .accessibilityIdentifier("cityLabel")
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                    TempView(temp: weatherDetails!.temp - CGFloat(Constants.MathContants.toCelsius))
                    Text(weatherDetails!.main.localized(model.language))
                        .accessibilityIdentifier("descriptionLabel")
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                    HStack {
                        Text("max:".localized(model.language))
                        Text("\(Int(weatherDetails!.tempMax) - Constants.MathContants.toCelsius)º")
                            .accessibilityIdentifier("celsiusMaxLabel")
                        Text(", ")
                        Text("min:".localized(model.language))
                        Text("\(Int(weatherDetails!.tempMin) - Constants.MathContants.toCelsius)º")
                            .accessibilityIdentifier("celsiusMinLabel")
                    }
                }
                .padding()
                
                VStack {
                    FragmentView(description: "feels_like".localized(model.language),
                                 index: "\(Int(weatherDetails!.feelsLike) - Constants.MathContants.toCelsius)",
                                 imageName: PicturesNames.thermometer.rawValue,
                                 metric: Metrics.celsius.rawValue)
                    FragmentView(description: "humidity".localized(model.language),
                                 index: "\(Int(weatherDetails!.humidity))",
                                 imageName: PicturesNames.dropFill.rawValue,
                                 metric: Metrics.percent.rawValue)
                    PressureView(description: "pressure".localized(model.language),
                                 index: Int(weatherDetails!.pressure),
                                 imageName: PicturesNames.dialMin.rawValue,
                                 metric: Metrics.millimeters.rawValue)
                    FragmentView(description: "sunrise".localized(model.language),
                                 index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunrise)).timeIn24HourFormat())",
                                 imageName: PicturesNames.sunriseFill.rawValue,
                                 metric: Metrics.empty.rawValue)
                    FragmentView(description: "sunset".localized(model.language),
                                 index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunset)).timeIn24HourFormat())",
                                 imageName: PicturesNames.sunsetFill.rawValue,
                                 metric: Metrics.empty.rawValue)
                }
            }
            .padding()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: model.changeBG(description: weatherDetails!.main)),
                           startPoint: UnitPoint(x: 4, y: 0),
                           endPoint: UnitPoint(x: 0, y: -2)).blur(radius: 10)
        )
        
        .navigationBarTitle("current_info".localized(model.language))
        } 
    }
   
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weatherDetails: nil, isNavigationLink: true, hideSheet: .constant(true))
        DetailView(weatherDetails: nil, isNavigationLink: true, hideSheet: .constant(true)).previewDevice("iPhone 12 Pro Max")
    }
}
