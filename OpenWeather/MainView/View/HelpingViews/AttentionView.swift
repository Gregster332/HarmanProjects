//
//  AttentionView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 01.10.2021.
//

import SwiftUI

struct AttentionView: View {
    @Binding var showAttentionLabel: Bool
    @Binding var isThisNoInternetAttentionView: Bool
    var language = LocalizationService.shared.language
    var color = ColorChangeService.shared.color
    
    var body: some View {
        
         VStack {
            Text(isThisNoInternetAttentionView ? "attention".localized(language) : "oops".localized(language))
                 .font(.system(size: Constants.Fonts.attentionFont))
                .fontWeight(.bold)
                .foregroundColor(Constants.Colors.attentionForeground)
            Text(isThisNoInternetAttentionView ? "refresh_not_possible".localized(language) : "failed_to_load".localized(language))
                .multilineTextAlignment(.center)
                .font(.system(size: Constants.Fonts.refreshFont))
                .lineLimit(nil)
            
            Button {
                showAttentionLabel.toggle()
                isThisNoInternetAttentionView = true
            } label: {
                Text("OK")
                    .font(.system(size: Constants.Fonts.refreshFont))
                    .foregroundColor(Constants.Colors.attentionForeground)
                    .frame(width: Constants.Widths.attentionViewOkButtonWidth, height: Constants.Heights.attentionViewOkButtonHeight)
            }
            
        }
         .frame(width: Constants.Widths.attentionViewWidth, height: Constants.Heights.attentionViewHeight)
        .background(ColorChangeService.shared.changeColor(color: color.rawValue))
        .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
        
    }
}

//struct AttentionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttentionView(showAttentionLabel: .constant(true), isThisNoInternetAttentionView: .constant(true))
//    }
//}
