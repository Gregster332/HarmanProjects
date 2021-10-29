//
//  PressureView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 10.10.2021.
//

import SwiftUI

struct PressureView: View {
    
    //MARK: - Variables
    var description: String
    var index: Int
    var imageName: String
    var metric: String
    
    
    var rectangleWidth: CGFloat {
        get {
            if index >= Constants.MathContants.maxWidthOfPressureRectangle {
                return Constants.MathContants.rectangleFullWidth
            } else if index <= Constants.MathContants.minWidthOfPressureRectangle {
                return Constants.MathContants.zero
            } else {
                return CGFloat(abs(Constants.MathContants.minWidthOfPressureRectangle - index)) * Constants.MathContants.multiplyValueForRecatgle
            }
        }
    }
    
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @ObservedObject var viewModel = DetailViewModel()
    
    var body: some View {
        VStack(alignment: .center,
               spacing: Constants.Spacings.fragmentViewSpacing) {
            HStack {
                Image(systemName: imageName)
                Text(description)
                    .accessibilityIdentifier("DescText")
                    .font(.system(size: heightClass == .regular ? Constants.Fonts.detailViewFragmentFont1 : Constants.Fonts.detailViewFragmentFont2))
            }
            
            HStack {
                Text("950")
                ZStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(.gray)
                            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                            .frame(width: Constants.MathContants.rectangleFullWidth, height: Constants.Heights.settingsViewDeleteButtonHeight)
                        
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow, Color.red]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                            .frame(width: rectangleWidth, height: Constants.Heights.settingsViewDeleteButtonHeight)
                        
                    }
                    Text("\(index)hPa")
                }
                
                Text("1050")
            }
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: Constants.Heights.fragmentViewHeight)
        .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
        .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
    }
}

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        PressureView(description: "", index: 960, imageName: "", metric: "")
    }
}
