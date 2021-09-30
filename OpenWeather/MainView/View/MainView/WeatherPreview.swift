//
//  WeatherPreview.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct WeatherPreview: View {
    
    var city: String
    var temp: Int
    var max: Int
    var min: Int
    
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @State private var device = UIDevice.current.name
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).opacity(0.8), Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)).opacity(0.8), Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).opacity(0.7)]), startPoint: .bottomLeading, endPoint: .topTrailing)
                .blur(radius: 1.1)
            
            HStack(alignment: .top){
                   
                ZStack {
                    Text("\(city)")
                        .font(.system(size: calculateFont()))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .offset(x: calculateOffset(), y: -20)
                        .padding(.trailing, -10)
                    
                    VStack(alignment: .trailing, spacing: 20) {
                        Text("\(temp)º")
                            .font(.system(size: 40))
                        Text("Max.: \(max)º, min.: \(min)º")
                            .font(.system(size: 18))
                    }
                    .padding(.trailing, 20)
                }
            }
            
        }
        .frame(width: calculateWidth(), height: 140)
        .cornerRadius(20)
        
    }
    
    private func calculateWidth() -> CGFloat {
        print("\(UIScreen.main.bounds.height) height")
        print("\(UIScreen.main.bounds.width) width")
        if heightClass == .regular {
            if (900..<1000).contains(UIScreen.main.bounds.height) {
                return 390
            } else if (800..<900).contains(UIScreen.main.bounds.height) {
                return 370
            } else if  (600..<700).contains(UIScreen.main.bounds.height) {
                return 350
            } else if (700..<800).contains(UIScreen.main.bounds.height) {
                return 370
            } else if (1000..<1400).contains(UIScreen.main.bounds.height) {
                return 500
            } else {
                return 300
            }
        } else {
            if (300..<1000).contains(UIScreen.main.bounds.height) {
                return 600
            } else {
                return 500
            }
        }
       
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
            if (300..<1000).contains(UIScreen.main.bounds.height) {
                return 35
            } else {
                return 50
            }
        }
    }
    
    private func calculateOffset() -> CGFloat {
        if heightClass == .regular {
            if (900..<1000).contains(UIScreen.main.bounds.height) {
                return -160
            } else if (800..<900).contains(UIScreen.main.bounds.height) {
                return -145
            } else if  (600..<700).contains(UIScreen.main.bounds.height) {
                return -110
            } else if (700..<800).contains(UIScreen.main.bounds.height) {
                return -135
            } else if (1000..<1400).contains(UIScreen.main.bounds.height) {
                return -202
            } else {
                return -100
            }
        } else {
            if (300..<1000).contains(UIScreen.main.bounds.height) {
                return -200
            } else {
                return -220
            }
        }
    }
    
}

struct WeatherPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherPreview(city: "Нижний Новгород", temp: 7, max: 11, min: 11)
            WeatherPreview(city: "Yb;ybq yjdujhjl", temp: 8, max: 11, min: 11).previewDevice("iPhone 8")
            WeatherPreview(city: "Yb;ybq yjdujhjl", temp: 8, max: 11, min: 11).previewDevice("iPhone 8")
                .previewLayout(.fixed(width: 667, height: 375))
            WeatherPreview(city: "Yb;ybq yjdujhjl", temp: 8, max: 11, min: 11).previewDevice("iPad Pro (9.7-inch)")
        }
    }
}
