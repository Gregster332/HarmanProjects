//
//  SettingsView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 06.10.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var model = SettingViewModel()
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @EnvironmentObject var realmService: RealMService
    @Binding var showSettingsView: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            HStack {
                Image(systemName: "backward.fill")
                    .accessibilityIdentifier("back")
                    .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                    .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSettingsView.toggle()
                        }
                    }
                Text(LocalizedStringKey("Settings"))
                    .accessibilityIdentifier("settings")
                    .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
            }
            
            HStack(alignment: .center, spacing: 60) {
                Text(LocalizedStringKey("Delete all data"))
                    .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 10 ))
                Button {
                    if !realmService.cities.isEmpty {
                    realmService.deleteAll()
                    realmService.fetchData()
                    } else {
                        showAlert.toggle()
                    }
                } label: {
                    Text(LocalizedStringKey("Delete"))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 10))
                        .foregroundColor(.black)
                }
                .accessibilityIdentifier("delete")
                .frame(width: model.calculateWidthForButton(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(LocalizedStringKey("Databese is empty")), message: Text(LocalizedStringKey("We can't delete deleted items one more time")), dismissButton: .some(.cancel(Text("OK"))))
                }
            }
            .frame(width: model.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: 80)
            .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
            .cornerRadius(20)
            
            
        }
        .frame(width: model.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: 200)
        .background(Color.gray)
        .cornerRadius(20)
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 8")
//        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 8 Plus")
//        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 12")
//        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 12 Pro Max")
//        SettingsView(showSettingsView: .constant(true)).previewDevice("iPad Pro (9.7-inch)")
//        SettingsView(showSettingsView: .constant(true)).previewDevice("iPad mini(6th generation)")
//    }
//}
