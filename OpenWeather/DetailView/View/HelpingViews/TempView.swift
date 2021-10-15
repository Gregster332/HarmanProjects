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
            return abs(Constants.MathContants.lowerLimit + temperature) / Constants.MathContants.percentage
        }
    }
    
    init(temp: CGFloat) {
        self.temperature = temp
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(Color.gray)
                .frame(width: Constants.Widths.tempViewWidth,
                       height: Constants.Heights.tempViewHeight,
                       alignment: .center)
                .rotationEffect(.degrees(Constants.Deegrees.TempViewDegrees))
            Circle()
                .trim(from: Constants.Trimms.zeroTrim,
                      to: toNumber)
                .stroke(temperature >= 0 ? .orange : .blue, style: StrokeStyle(lineWidth: Constants.LineWidths.tempViewLineWidth,
                                                                               lineCap: .butt,
                                                                               lineJoin: .miter,
                                                                               dash: [Constants.Dashes.tempViewDash]))
                .animation(.easeInOut, value: temperature)
                .rotationEffect(.degrees(Constants.Deegrees.TempViewDegrees))
                .frame(width: Constants.Widths.tempViewWidth2,
                       height: Constants.Widths.tempViewWidth2,
                       alignment: .center)
            
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
