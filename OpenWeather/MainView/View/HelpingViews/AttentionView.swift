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
    var body: some View {
        VStack {
            Text(isThisNoInternetAttentionView ? LocalizedStringKey("Attention!") : LocalizedStringKey("Ooops..."))
                .font(.system(size: 25))
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 0.832, green: 0.8, blue: 0.1, alpha: 1)))
            Text(isThisNoInternetAttentionView ? LocalizedStringKey("Refresh is not possible without network connection") : LocalizedStringKey("Failed to load data. Try again, please."))
                .multilineTextAlignment(.center)
                .font(.system(size: 23))
                .lineLimit(nil)
            
            Button {
                showAttentionLabel.toggle()
                isThisNoInternetAttentionView = true
            } label: {
                Text("OK")
                    .font(.system(size: 23))
                    .foregroundColor(Color(#colorLiteral(red: 0.832, green: 0.8, blue: 0.1, alpha: 1)))
                    .frame(width: 40, height: 30)
            }
            
        }
        .frame(width: 300, height: 180)
        .background(Color.teal)
        .cornerRadius(20)
        
    }
}

//struct AttentionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttentionView(showAttentionLabel: .constant(true), isThisNoInternetAttentionView: .constant(true))
//    }
//}
