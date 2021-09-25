//
//  DetailView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct DetailView: View {
    
    let weatherDetails: City?
    @EnvironmentObject var arrayCity: WeatherViewModel

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 10) {
                Text("\(weatherDetails!.name)")
                    .font(.system(size: UIScreen.main.bounds.height / 27))
                Text("\(Int(weatherDetails!.temp) -  273)º")
                    .font(.system(size: UIScreen.main.bounds.height / 21))
                    .fontWeight(.bold)
                Text("\(weatherDetails!.main)")
                    .font(.system(size: UIScreen.main.bounds.height / 30))
                Text("Макс: \(Int(weatherDetails!.tempMax) - 273)º, мин: \(Int(weatherDetails!.tempMin) - 273)º")
            }
            .padding()
            
            VStack {
                FragmentView(description: "Ощущается как", index: "\(Int(weatherDetails!.feelsLike) - 273)", imageName: "thermometer", metric: "º")
                FragmentView(description: "Влажность", index: "\(Int(weatherDetails!.humidity))", imageName: "drop.fill", metric: "%")
                FragmentView(description: "Давление", index: "\(Int(weatherDetails!.pressure))", imageName: "dial.min", metric: " мм рт. ст.")
                FragmentView(description: "Рассвет", index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunrise)).timeIn24HourFormat())", imageName: "sunrise.fill", metric: "")
                FragmentView(description: "Закат", index: "\(Date(timeIntervalSince1970: TimeInterval(weatherDetails!.sunset)).timeIn24HourFormat())", imageName: "sunset.fill", metric: "")
            }
            .padding()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.1)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(weatherDetails: nil)
        DetailView(weatherDetails: nil).previewDevice("iPhone 12 Pro Max")
    }
}
