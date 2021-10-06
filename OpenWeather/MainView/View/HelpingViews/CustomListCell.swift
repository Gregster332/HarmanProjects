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
    @ObservedObject var model = MainViewModel()
   
    var body: some View {
        //MARK: - View
        HStack(alignment: .center, spacing: 50) {
            Text(main)
                .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) + 20))
            
            VStack(alignment: .leading) {
                Text(city)
                    .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 3))
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
}

//struct Cell_Previews: PreviewProvider {
//    static var previews: some View {
//        Cell(city: "Miami", temp: 30, max: 32, min: 27, main: "Mist")
//    }
//}

