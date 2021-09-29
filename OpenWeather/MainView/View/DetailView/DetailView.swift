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
        if heightClass == .regular {
            if (900..<1000).contains(UIScreen.main.bounds.height) {
                return 28
            } else if (800..<900).contains(UIScreen.main.bounds.height) {
                return 25
            } else if  (600..<700).contains(UIScreen.main.bounds.height) {
                return 23
            } else if (700..<800).contains(UIScreen.main.bounds.height) {
                return 24
            } else if (1000..<1400).contains(UIScreen.main.bounds.height) {
                return 35
            } else {
                return 23
            }
        } else {
            if (300..<650).contains(UIScreen.main.bounds.height) {
                return 35
            } else {
                return 50
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weatherDetails: nil, isNavigationLink: true)
        DetailView(weatherDetails: nil, isNavigationLink: true).previewDevice("iPhone 12 Pro Max")
    }
}
