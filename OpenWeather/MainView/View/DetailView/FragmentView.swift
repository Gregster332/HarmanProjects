//
//  FragmentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct FragmentView: View {
    
    var description: String
    var index: String
    var imageName: String
    var metric: String
    
    @State private var device = UIDevice.current.name
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
            if heightClass == .regular && device.contains("iPhone") {
                return 300
            } else if heightClass == .compact && device.contains("iPhone") {
                return 500
            } else if heightClass == .regular && device.contains("iPad") {
                return 400
            } else {
                return 400
            }
        }
}

struct FragmentView_Previews: PreviewProvider {
    static var previews: some View {
        FragmentView(description: "Ощущается как", index: "7", imageName: "thermometer", metric: "º")
            
    }
}
