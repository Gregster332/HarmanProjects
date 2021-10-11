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
    var language = LocalizationService.shared.language
    
    var rectangleWidth: CGFloat {
        get {
            if index >= 1050 {
                return 255
            } else if index <= 950 {
                return 0
            } else {
                return CGFloat(abs(950 - index)) * 2.55
            }
        }
    }
    
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @ObservedObject var model = DetailViewModel()
    var color = ColorChangeService.shared.color
    
    var body: some View {
        VStack(alignment: .center,spacing: 30) {
            HStack {
                Image(systemName: imageName)
                Text(description)
                    .accessibilityIdentifier("DescText")
                    .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
            }
            
           
            
            
            HStack {
                Text("950")
                ZStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(.gray)
                            .cornerRadius(20)
                        
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow, Color.red]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                            .frame(width: rectangleWidth)
                        
                    }
                    Text("\(index)")
                }
                
                Text("1050")
            }
        }
        .padding()
        .frame(width: model.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: 140)
        .background(ColorChangeService.shared.changeColor(color: color.rawValue))
        .cornerRadius(15)
    }
}

struct PressureView_Previews: PreviewProvider {
    static var previews: some View {
        PressureView(description: "Clear", index: 1010, imageName: "plus", metric: "")
.previewInterfaceOrientation(.portrait)
    }
}
