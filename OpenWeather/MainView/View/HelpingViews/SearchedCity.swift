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
            Text("do_you_want_to_add".localized(viewModel.language))
                .font(.system(size: heightClass == .regular ? Constants.Fonts.cityLabelSize1 : Constants.Fonts.cityLabelSize2))
            
            Spacer()
            
            Button {
                if viewModel.checkSymbols(str: viewModel.searchItem) && Reachability.isConnectedToNetwork() {
                    DispatchQueue.main.async {
                        viewModel.networkService.getData(cityName: viewModel.searchItem) { result in
                            switch(result) {
                            case .success(let item):
                                viewModel.addCityToDB(city: viewModel.getCityFromWelcome(welcome: item))
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        viewModel.searchItem = ""
                    }
                } else {
                    viewModel.showingAlert.toggle()
                }
                
            } label: {
                ZStack {
                    Circle()
                        .frame(width: Constants.Widths.searchedCityViewWidth,
                               height: Constants.Heights.searchedCityViewHeight)
                        .foregroundColor(.red)
                    Image(systemName: "plus")
                }
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("something_wrong".localized(viewModel.language)), message: Text(Reachability.isConnectedToNetwork() ? "enter_in_english".localized(viewModel.language) : "no_internet".localized(viewModel.language)), dismissButton: .some(.cancel(Text("OK"), action: {
                    viewModel.showingAlert = false
                })))
            }

        }
        .padding()
    }
}

struct SearchedCuty_Previews: PreviewProvider {
    static var previews: some View {
        SearchedCity(viewModel: MainViewModel())
    }
}
