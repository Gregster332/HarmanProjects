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
    var language = LocalizationService.shared.language
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @ObservedObject var model = DetailViewModel()
    
    var body: some View {
        //MARK: - View
        VStack(alignment: .center,spacing: 30) {
            HStack {
                Image(systemName: imageName)
                Text(description)
                    .accessibilityIdentifier("DescText")
                    .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
            }
            Text("\(index)\(metric)")
                .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
        }
        .padding()
        .frame(width: model.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: 140)
        .background(Color.gray)
        .cornerRadius(15)
        
    }
}

//struct FragmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        FragmentView(description: "Ощущается как", index: "7", imageName: "thermometer", metric: "º")
//            
//    }
//}
