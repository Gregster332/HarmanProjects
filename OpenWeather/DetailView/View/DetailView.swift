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
    var weatherDetails: City?
    let isNavigationLink: Bool
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @ObservedObject var model = DetailViewModel()
    //@Environment(\.presentationMode) var presentationMode
    
    
    //MARK: - Private observables
    @State private var device = UIDevice.current.name
    @Binding var hideSheet: Bool
    

    var body: some View {
        //MARK: - View
        if weatherDetails != nil {
        ScrollView(.vertical, showsIndicators: false) {
            
            if isNavigationLink == false {
                HStack {
                    Image(systemName: "backward.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                        .font(.system(size: model.calculateFont(heightClass: heightClass)))
                        .onTapGesture {
                            hideSheet.toggle()
                        }
                    
                    Text(LocalizedStringKey("Current Info"))
                        .font(.system(size: model.calculateFont(heightClass: heightClass)))
                        .fontWeight(.bold)
                }
            }
            
            VStack {
                VStack(alignment: .center, spacing: 10) {
                    Text("\(weatherDetails!.name)")
                        .font(.system(size: model.calculateFont(heightClass: heightClass)))
                    Text("\(Int(weatherDetails!.temp) -  Constants.toCelsius)º")
                        .font(.system(size: model.calculateFont(heightClass: heightClass)))
                        .fontWeight(.bold)
                    Text(LocalizedStringKey(weatherDetails!.main))
                        .font(.system(size: model.calculateFont(heightClass: heightClass)))
                    HStack {
                        Text(LocalizedStringKey("Max:"))
                        Text("\(Int(weatherDetails!.tempMax) - Constants.toCelsius)º")
                        Text(", ")
                        Text(LocalizedStringKey("Min:"))
                        Text("\(Int(weatherDetails!.tempMin) - Constants.toCelsius)º")
                    }
                }
                .padding()
                
                VStack {
                    FragmentView(description: LocalizedStringKey("Feels like"), index: "\(Int(weatherDetails!.feelsLike) - Constants.toCelsius)", imageName: "thermometer", metric: "º")
                    FragmentView(description: LocalizedStringKey("Humidity"), index: "\(Int(weatherDetails!.humidity))", imageName: "drop.fill", metric: "%")
                    FragmentView(description: LocalizedStringKey("Pressure"), index: "\(Int(weatherDetails!.pressure))", imageName: "dial.min", metric: "mm")
                    FragmentView(description: LocalizedStringKey("Sunrise"), index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunrise)).timeIn24HourFormat())", imageName: "sunrise.fill", metric: "")
                    FragmentView(description: LocalizedStringKey("Sunset"), index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunset)).timeIn24HourFormat())", imageName: "sunset.fill", metric: "")
                }
            }
            .padding()
        }
        .padding()
        
        .navigationBarTitle(LocalizedStringKey("Current Info"))
        } else {
            ProgressView().progressViewStyle(CircularProgressViewStyle())
        }
    }
    
   
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weatherDetails: nil, isNavigationLink: true, hideSheet: .constant(true))
        DetailView(weatherDetails: nil, isNavigationLink: true, hideSheet: .constant(true)).previewDevice("iPhone 12 Pro Max")
    }
}
