//
//  DetailView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct DetailView: View {
    
    var weatherDetails: City?
    let isNavigationLink: Bool
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @Environment(\.presentationMode) var presentationMode
    @State private var device = UIDevice.current.name
    

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            if isNavigationLink == false {
                HStack {
                    Image(systemName: "backward.fill")
                        .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                        .font(.system(size: calculateFont()))
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                    Text(LocalizedStringKey("Current Info"))
                        .font(.system(size: calculateFont()))
                        .fontWeight(.bold)
                }
            }
            
            VStack {
                VStack(alignment: .center, spacing: 10) {
                    Text("\(weatherDetails!.name)")
                        .font(.system(size: calculateFont()))
                    Text("\(Int(weatherDetails!.temp) -  273)º")
                        .font(.system(size: calculateFont()))
                        .fontWeight(.bold)
                    Text(LocalizedStringKey(weatherDetails!.main))
                        .font(.system(size: calculateFont()))
                    HStack {
                        Text(LocalizedStringKey("Max:"))
                        Text("\(Int(weatherDetails!.tempMax) - 273)º")
                        Text(", ")
                        Text(LocalizedStringKey("Min:"))
                        Text("\(Int(weatherDetails!.tempMin) - 273)º")
                    }
                }
                .padding()
                
                VStack {
                    FragmentView(description: LocalizedStringKey("Feels like"), index: "\(Int(weatherDetails!.feelsLike) - 273)", imageName: "thermometer", metric: "º")
                    FragmentView(description: LocalizedStringKey("Humidity"), index: "\(Int(weatherDetails!.humidity))", imageName: "drop.fill", metric: "%")
                    FragmentView(description: LocalizedStringKey("Pressure"), index: "\(Int(weatherDetails!.pressure))", imageName: "dial.min", metric: "mm")
                    FragmentView(description: LocalizedStringKey("Sunrise"), index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunrise)).timeIn24HourFormat())", imageName: "sunrise.fill", metric: "")
                    FragmentView(description: LocalizedStringKey("Sunset"), index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunset)).timeIn24HourFormat())", imageName: "sunset.fill", metric: "")
                }
            }
                .padding()
        }
        .padding()
        //.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.1)
        .navigationBarTitle(LocalizedStringKey("Current Info"))
    }
    
    private func calculateFont() -> CGFloat {
        //print(device)
        if heightClass == .regular && (device == "iPhone 12" ||
                                        device == "iPhone 12 Pro" ||
                                        device == "iPhone 12 Pro Max" ||
                                        device == "iPhone 11" ||
                                        device == "iPhone 11 Pro" ||
                                        device == "iPhone 11 Pro Max" ||
                                        device == "iPhone XS" ||
                                        device == "iPhone XS Max" ||
                                        device == "iPhone Xr" ||
                                        device == "iPhone X" ||
                                        device == "iPhone 8 Plus" ||
                                        device == "iPhone 7 Plus"){
            return 25
        } else if heightClass == .regular && (device == "iPhone 8" || device == "iPhone 7" || device == "iPhone SE (2nd generation)"){
            return 23
        } else if heightClass == .compact && device.contains("iPhone") {
            return 35
        } else if heightClass == .regular && device.contains("iPad") {
            return 40
        } else if heightClass == .compact && device.contains("iPad") {
            return 50
        } else {
            return 25
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weatherDetails: nil, isNavigationLink: true)
        DetailView(weatherDetails: nil, isNavigationLink: true).previewDevice("iPhone 12 Pro Max")
    }
}
