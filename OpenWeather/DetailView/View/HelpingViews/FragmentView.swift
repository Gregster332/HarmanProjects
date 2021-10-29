//
//  FragmentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct FragmentView: View {
    
    //MARK: - Variables
    var description: String
    var index: String
    var imageName: String
    var metric: String
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        //MARK: - View
        VStack(alignment: .center,spacing: Constants.Spacings.fragmentViewSpacing) {
            HStack {
                Image(systemName: imageName)
                Text(description)
                    .accessibilityIdentifier("DescText")
                    .font(.system(size: heightClass == .regular ? Constants.Fonts.detailViewFragmentFont1 : Constants.Fonts.detailViewFragmentFont2))
            }
            Text("\(index)\(metric)")
                .font(.system(size: heightClass == .regular ? Constants.Fonts.detailViewFragmentFont1 : Constants.Fonts.detailViewFragmentFont2))
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: Constants.Heights.fragmentViewHeight)
        .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
        .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
        
    }
}

