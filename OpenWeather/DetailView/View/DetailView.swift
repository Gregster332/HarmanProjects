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
    //@Environment(\.presentationMode) var presentationMode
    var language = LocalizationService.shared.language
    
    
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
                        .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                        .onTapGesture {
                            hideSheet.toggle()
                            weatherDetails = nil
                        }
                    
                    Text("Current Info".localized(language))
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
                    Text("\(Int(weatherDetails!.temp) -  Constants.toCelsius)º")
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                        .fontWeight(.bold)
                        .accessibilityIdentifier("celsiusLabel")
                    Text(weatherDetails!.main.localized(language))
                        .accessibilityIdentifier("descriptionLabel")
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                        //.accessibilityIdentifier("descriptionLabel")
                    HStack {
                        Text("Max:".localized(language))
                        Text("\(Int(weatherDetails!.tempMax) - Constants.toCelsius)º")
                            .accessibilityIdentifier("celsiusMaxLabel")
                        Text(", ")
                        Text("Min:".localized(language))
                        Text("\(Int(weatherDetails!.tempMin) - Constants.toCelsius)º")
                            .accessibilityIdentifier("celsiusMinLabel")
                    }
                }
                .padding()
                
                VStack {
                    FragmentView(description: "Feels like".localized(language), index: "\(Int(weatherDetails!.feelsLike) - Constants.toCelsius)", imageName: "thermometer", metric: "º")
                    FragmentView(description: "Humidity".localized(language), index: "\(Int(weatherDetails!.humidity))", imageName: "drop.fill", metric: "%")
                    FragmentView(description: "Pressure".localized(language), index: "\(Int(weatherDetails!.pressure))", imageName: "dial.min", metric: "mm")
                    FragmentView(description: "Sunrise".localized(language), index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunrise)).timeIn24HourFormat())", imageName: "sunrise.fill", metric: "")
                    FragmentView(description: "Sunset".localized(language), index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunset)).timeIn24HourFormat())", imageName: "sunset.fill", metric: "")
                }
            }
            .padding()
        }
        .padding()
        
        .navigationBarTitle("Current Info".localized(language))
        } 
    }
    
   
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weatherDetails: nil, isNavigationLink: true, hideSheet: .constant(true))
        DetailView(weatherDetails: nil, isNavigationLink: true, hideSheet: .constant(true)).previewDevice("iPhone 12 Pro Max")
    }
}
