//
//  CustomListCell.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 29.09.2021.
//

import SwiftUI

struct Cell: View {

    //MARK: Variables
    var city: String
    var temp: Int
    var max: Int
    var min: Int
    var main: String
    
    //MARK: - Global Variables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
   
    var body: some View {
        //MARK: - View
        HStack(alignment: .center, spacing: 50) {
            Text(main)
                .font(.system(size: calculateFont() + 30))
            
            VStack(alignment: .leading) {
                Text(city)
                    .font(.system(size: calculateFont() - 3))
                    .fontWeight(.bold)
                HStack(alignment: .center, spacing: 0) {
                    Text(LocalizedStringKey("Temperature"))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Text(": \(temp)")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                HStack {
                    HStack(alignment: .center, spacing: 0) {
                        Text(LocalizedStringKey("Max:"))
                        Text(" \(max),")
                    }
                    HStack(alignment: .center, spacing: 0) {
                        Text(LocalizedStringKey("Min:"))
                        Text(" \(min)")
                    }
                }
            }
        }
        
    }
    
    //MARK: - Private functions
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
    
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(city: "Miami", temp: 30, max: 32, min: 27, main: "Mist")
    }
}

