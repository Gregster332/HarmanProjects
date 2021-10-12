//
//  TempView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 09.10.2021.
//

import SwiftUI

struct TempView: View {
    
    var temperature: CGFloat
    
    var toNumber: CGFloat {
        get {
            return abs(50 + temperature) / 100
        }
    }
    
    init(temp: CGFloat) {
        self.temperature = temp
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.gray)
                .frame(width: 150, height: 150, alignment: .center)
                .rotationEffect(.degrees(Constants.Deegrees.TempViewDegrees))
            Circle()
                .trim(from: 0.0, to: toNumber)
                .stroke(temperature >= 0 ? .orange : .blue, style: StrokeStyle(lineWidth: 15, lineCap: .butt, lineJoin: .miter, dash: [3]))
                .animation(.easeInOut, value: temperature)
                .rotationEffect(.degrees(Constants.Deegrees.TempViewDegrees))
                .frame(width: 165, height: 165, alignment: .center)
            
            Text("\(Int(temperature))º")
                .font(.largeTitle)
                .foregroundColor(Color.white)
                .fontWeight(.semibold)
                .accessibilityIdentifier("celsiusLabel")
        }
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView(temp: -40)
    }
}
