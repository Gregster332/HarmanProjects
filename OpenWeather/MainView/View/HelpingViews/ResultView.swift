//
//  ResultView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 01.11.2021.
//

import SwiftUI

struct ResultView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .background(Color.white)
                .blur(radius: Constants.Blurs.mainViewBlur)
            
            VStack {
                Text("☑️")
                Text("Aded")
                    .foregroundColor(.black)
            }
        }
        .frame(width: Constants.Widths.settingsViewMaxWidth1, height: Constants.Widths.settingsViewMaxWidth1)
        .cornerRadius(Constants.CornerRadiuses.settingsViewDeleteAllCornerRaduis)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.AsyncSeconds.asyncSecond) {
                viewModel.result = .NOTHING
                }
            }
        }
    }


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(viewModel: MainViewModel())
    }
}
