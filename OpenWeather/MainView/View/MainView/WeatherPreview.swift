//
//  WeatherPreview.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct WeatherPreview: View, Hashable {
    
    var city: String
    var temp: Int
    var max: Int
    var min: Int
    
    var body: some View {
        ZStack(alignment: .trailing) {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).opacity(0.8), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).opacity(0.8), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).opacity(0.7)]), startPoint: .bottomLeading, endPoint: .topTrailing)
                .blur(radius: 1.1)
            
            HStack(alignment: .top, spacing: UIScreen.main.bounds.width / 6.5){
                   
                ZStack {
                    Text("\(city)")
                        .font(.system(size: (UIScreen.main.bounds.height / 45) + 2))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .offset(x: -(UIScreen.main.bounds.width / 2.4), y: -(UIScreen.main.bounds.height / 50))
                        .padding(.trailing, -10)
                    //.padding([.top, .leading], 6)
                    
                    VStack(alignment: .trailing, spacing: UIScreen.main.bounds.height / 30) {
                        Text("\(temp)º")
                            .font(.system(size: 40))
                        Text("Макс.: \(max)º, мин.: \(min)º")
                            .font(.system(size: 18))
                    }
                    .padding(.trailing, 10)
                }
            }
            
        }
        .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 6)
        .cornerRadius(20)
    }
        
    
}

struct WeatherPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherPreview(city: "", temp: 7, max: 11, min: 11)
            WeatherPreview(city: "", temp: 8, max: 11, min: 11).previewDevice("iPhone 12")
        }
    }
}
