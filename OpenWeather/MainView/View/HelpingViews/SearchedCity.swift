//
//  SearchedCuty.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.10.2021.
//

import SwiftUI

struct SearchedCity: View {
    
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    
    var body: some View {
        HStack {
            Text("Do you want to add \(viewModel.searchItem) at database?")
                .font(.system(size: viewModel.calculateFont(heightClass: heightClass,
                                                            screenHeight: UIScreen.main.bounds.height)))
            
            Button {
                viewModel.networkService.getData(cityName: viewModel.searchItem) { result in
                    switch(result) {
                    case .success(let item):
                        viewModel.addCityToDB(city: viewModel.getCityFromWelcome(welcome: item))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Add")
                    .font(.system(size: viewModel.calculateFont(heightClass: heightClass,
                                                                screenHeight: UIScreen.main.bounds.height)))
                    .frame(width: 60, height: 30)
                    .background(Color.red)
                    .cornerRadius(20)
            }

        }
    }
}

struct SearchedCuty_Previews: PreviewProvider {
    static var previews: some View {
        SearchedCity(viewModel: MainViewModel())
    }
}
