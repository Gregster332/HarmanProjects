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
    @ObservedObject var viewModel = MainViewModel()
    
    
    init(_ city: City?) {
        self.city = city!.name
        self.temp = Int(city!.temp) - Constants.MathContants.toCelsius
        self.max = Int(city!.tempMax) - Constants.MathContants.toCelsius
        self.min = Int(city!.tempMin) - Constants.MathContants.toCelsius
        self.main = emojis[city!.main]!
    }
   
    var body: some View {
        //MARK: - View
        HStack(alignment: .center, spacing: Constants.Spacings.temperatureDescriptionViewMainHstackSpacing) {
            Text(main)
                .font(.system(size: viewModel.calculateFont(heightClass: heightClass,
                                                            screenHeight: UIScreen.main.bounds.height) + Constants.Fonts.plusForTemperatureDescriptionCellMainTextFont))
            
            VStack(alignment: .leading) {
                Text(city)
                    .font(.system(size: viewModel.calculateFont(heightClass: heightClass,
                                                                screenHeight: UIScreen.main.bounds.height) - Constants.Fonts.plusForTemperatureDescriptionCellCityTextFont))
                    .fontWeight(.bold)
                HStack(alignment: .center, spacing: Constants.Spacings.zeroSpacing) {
                    Text("temp".localized(viewModel.language))
                        .font(.system(size: Constants.Fonts.temperatureDescriptionCellFont))
                        .fontWeight(.semibold)
                    Text(": \(temp)")
                        .font(.system(size: Constants.Fonts.temperatureDescriptionCellFont))
                        .fontWeight(.semibold)
                }
                HStack {
                    HStack(alignment: .center, spacing: Constants.Spacings.zeroSpacing) {
                        Text("max:".localized(viewModel.language))
                        Text(" \(max),")
                    }
                    HStack(alignment: .center, spacing: Constants.Spacings.zeroSpacing) {
                        Text("min:".localized(viewModel.language))
                        Text(" \(min)")
                    }
                }
            }
        }
        
    }
}


