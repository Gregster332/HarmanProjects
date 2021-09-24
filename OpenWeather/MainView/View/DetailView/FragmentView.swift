//
//  FragmentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct FragmentView: View {
    
    var description: String
    var index: String
    var imageName: String
    var metric: String
    
    var body: some View {
        VStack(alignment: .center,spacing: UIScreen.main.bounds.height / 40) {
            HStack {
                Image(systemName: imageName)
                Text(description)
                    .font(.system(size: UIScreen.main.bounds.width / 20))
            }
            Text("\(index)\(metric)")
                .font(.system(size: 40))
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.height / 5)
        .background(Color.black.opacity(0.2))
        .cornerRadius(15)
        
    }
}

struct FragmentView_Previews: PreviewProvider {
    static var previews: some View {
        FragmentView(description: "Ощущается как", index: "7", imageName: "thermometer", metric: "º")
            .previewLayout(.sizeThatFits)
    }
}
