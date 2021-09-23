//
//  DetailView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct DetailView: View {
    
    let weatherDetails: Welcome?

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 10) {
                Text("\(weatherDetails!.name)")
                    .font(.system(size: UIScreen.main.bounds.height / 27))
                Text("\(Int(weatherDetails!.main.temp) -  273)º")
                    .font(.system(size: UIScreen.main.bounds.height / 21))
                    .fontWeight(.bold)
                Text("\(weatherDetails!.weather.first!.main)")
                    .font(.system(size: UIScreen.main.bounds.height / 30))
                Text("Макс: \(Int(weatherDetails!.main.tempMax) - 273)º, мин: \(Int(weatherDetails!.main.tempMin) - 273)º")
            }
            
            VStack {
                FragmentView(description: "Ощущается как", index: Int(weatherDetails!.main.feelsLike) - 273, imageName: "thermometer", metric: "º")
                FragmentView(description: "Влажность", index: Int(weatherDetails!.main.humidity), imageName: "drop.fill", metric: "%")
            }
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
