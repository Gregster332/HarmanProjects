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
                    //.padding([.top, .leading], 6)
                    
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
            return 380
        } else if heightClass == .regular && (device == "iPhone 8" || device == "iPhone 7" || device == "iPhone SE (2nd generation)"){
            return 350
        } else if heightClass == .compact && device.contains("iPhone") {
            return 600
        } else if heightClass == .regular && device.contains("iPad") {
            return 500
        } else if heightClass == .compact && device.contains("iPad") {
            return 500
        } else {
            return 300
        }
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
    
    private func calculateOffset() -> CGFloat {
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
            return -110
        } else if heightClass == .regular && (device == "iPhone 8" || device == "iPhone 7" || device == "iPhone SE (2nd generation)"){
            return -110
        } else if heightClass == .compact && device.contains("iPhone") {
            return -220
        } else if heightClass == .regular && device.contains("iPad") {
            return -220
        } else if heightClass == .compact && device.contains("iPad") {
            return -220
        } else {
            return -110
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
