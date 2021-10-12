//
//  CustomListCell.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 29.09.2021.
//

import SwiftUI

struct TemperatureDescriptionCell: View {

    //MARK: Variables
    var city: String
    var temp: Int
    var max: Int
    var min: Int
    var main: String
    
    //MARK: - Global Variables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    
    @ObservedObject var model = MainViewModel()
    
    var language = LocalizationService.shared.language
    
    init(_ city: City?) {
        self.city = city!.name
        self.temp = Int(city!.temp) - Constants.MathContants.toCelsius
        self.max = Int(city!.tempMax) - Constants.MathContants.toCelsius
        self.min = Int(city!.tempMin) - Constants.MathContants.toCelsius
        self.main = emojis[city!.main]!
    }
   
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
                    Text("temp".localized(language))
                        .font(.system(size: Constants.Fonts.temperatureDescriptionCellFont))
                        .fontWeight(.semibold)
                    Text(": \(temp)")
                        .font(.system(size: Constants.Fonts.temperatureDescriptionCellFont))
                        .fontWeight(.semibold)
                }
                HStack {
                    HStack(alignment: .center, spacing: 0) {
                        Text("max:".localized(language))
                        Text(" \(max),")
                    }
                    HStack(alignment: .center, spacing: 0) {
                        Text("min:".localized(language))
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

