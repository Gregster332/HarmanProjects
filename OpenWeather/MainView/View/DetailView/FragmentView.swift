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
    
    //MARK: - Private observables
    @State private var device = UIDevice.modelName
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    
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
        .frame(width: calculateWidth(), height: 140)
        .background(Color.gray)
        .cornerRadius(15)
        
    }
    
    //MARK: - Private functions
    private func calculateWidth() -> CGFloat {
        print("\(UIScreen.main.bounds.height) height")
        print("\(UIScreen.main.bounds.width) width")
        if heightClass == .regular {
            if (900..<1000).contains(UIScreen.main.bounds.height) {
                return 390
            } else if (800..<900).contains(UIScreen.main.bounds.height) {
                return 370
            } else if  (600..<700).contains(UIScreen.main.bounds.height) {
                return 350
            } else if (700..<800).contains(UIScreen.main.bounds.height) {
                return 370
            } else if (1000..<1400).contains(UIScreen.main.bounds.height) {
                return 500
            } else {
                return 300
            }
        } else {
            if (300..<1000).contains(UIScreen.main.bounds.height) {
                return 600
            } else {
                return 500
            }
        }
       
    }
    
}

struct FragmentView_Previews: PreviewProvider {
    static var previews: some View {
        FragmentView(description: "Ощущается как", index: "7", imageName: "thermometer", metric: "º")
            
    }
}
