//
//  FragmentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct FragmentView: View {
    
    //MARK: - Variables
    var description: LocalizedStringKey
    var index: String
    var imageName: String
    var metric: String
    
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
                    .font(.system(size: 22))
            }
            Text("\(index)\(metric)")
                .font(.system(size: 40))
        }
        .padding()
        .frame(width: model.calculateWidth(heightClass: heightClass), height: 140)
        .background(Color.gray)
        .cornerRadius(15)
        
    }
}

struct FragmentView_Previews: PreviewProvider {
    static var previews: some View {
        FragmentView(description: "Ощущается как", index: "7", imageName: "thermometer", metric: "º")
            
    }
}
