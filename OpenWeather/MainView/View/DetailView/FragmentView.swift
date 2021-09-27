//
//  FragmentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct FragmentView: View {
    
    var description: LocalizedStringKey
    var index: String
    var imageName: String
    var metric: String
    
    @State private var device = UIDevice.modelName
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    
    var body: some View {
        VStack(alignment: .center,spacing: 30) {
            HStack {
                Image(systemName: imageName)
                Text(description)
                    .font(.system(size: 22))
            }
            Text("\(index)\(metric)")
                .font(.system(size: 40))
        }
        .padding()
        .frame(width: calculateWidth(), height: 140)
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
        
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
                                        device == "Alexandr’s iPhone") {
            return 380
        } else if heightClass == .regular && (device == "iPhone 8" || device == "iPhone 7" || device == "iPhone SE (2nd generation)"){
            return 370
        } else if heightClass == .compact && device.contains("iPhone") {
            return 600
        } else if heightClass == .regular && device.contains("iPad") {
            return 300
        } else {
            return 300
        }
    }
    
}

struct FragmentView_Previews: PreviewProvider {
    static var previews: some View {
        FragmentView(description: "Ощущается как", index: "7", imageName: "thermometer", metric: "º")
            
    }
}
