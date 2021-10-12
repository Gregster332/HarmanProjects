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
                        .foregroundColor(Constants.Colors.settingsViewColor)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showSettingsView.toggle()
                            }
                        }
                    Text("settings".localized(model.language))
                        .accessibilityIdentifier("settings")
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                }
                
                HStack(alignment: .center, spacing: 60) {
                    Text("delete_all_data".localized(model.language))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 10 ))
                    Button {
                        if !realmService.cities.isEmpty {
                        realmService.deleteAll()
                        realmService.fetchData()
                        } else {
                            showAlert.toggle()
                        }
                    } label: {
                        Text("delete".localized(model.language))
                            .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 10))
                            .foregroundColor(.black)
                    }
                    .accessibilityIdentifier("delete")
                    .frame(width: model.calculateWidthForButton(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: 50)
                    .background(Color.blue)
                    .cornerRadius(Constants.CornerRadiuses.settingsViewDeleteAllCornerRaduis)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("database_is_empty".localized(model.language)), message: Text("one_more_time".localized(model.language)), dismissButton: .some(.cancel(Text("OK"))))
                    }
                }
                .frame(width: model.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: model.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Constants.Colors.settingsViewColor)
                .cornerRadius(Constants.CornerRadiuses.settingsViewDeleteAllCornerRaduis)
                
                
                HStack(alignment: .center, spacing: 60) {
                    Text("settings_language".localized(model.language))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 5))
                    
                    Menu {
                        Button {
                            LocalizationService.shared.language = .russian
                        } label: {
                            Text("Русский")
                        }
                        .accessibilityIdentifier("rus")
                        Button {
                            LocalizationService.shared.language = .english_us
                        } label: {
                            Text("English (US)")
                        }
                        .accessibilityIdentifier("eng")
                    } label: {
                        Image("lang")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                            .accessibilityIdentifier("changeLanguageMenu")
                    }
                    
                }
                .frame(width: model.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: model.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Constants.Colors.settingsViewColor)
                .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                
                HStack(alignment: .center, spacing: 50) {
                    Text("color_of_views".localized(model.language))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 5))
                    Menu {
                        Button {
                            withAnimation(.easeInOut) {
                                ColorChangeService.shared.color = .green
                            }
                        } label: {
                            Text("green".localized(model.language))
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                            ColorChangeService.shared.color = .pink
                            }
                        } label: {
                            Text("pink".localized(model.language))
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                            ColorChangeService.shared.color = .purple
                            }
                        } label: {
                            Text("purple".localized(model.language))
                        }
                        
                    } label: {
                        Image(systemName: "paintbrush")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(ColorChangeService.shared.changeColor(color: model.color.rawValue))
                            .frame(width: 50, height: 50)
                            
                    }
                }
                .frame(width: model.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: model.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Constants.Colors.settingsViewColor)
                .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                
            }
            .frame(width: model.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: heightClass == .some(.regular) ? 450 : 350)
            .background(ColorChangeService.shared.changeColor(color: model.color.rawValue))
            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
            }
        }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 8").previewInterfaceOrientation(.landscapeLeft)
        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 8 Plus").previewInterfaceOrientation(.landscapeLeft)
        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 12").previewInterfaceOrientation(.landscapeLeft)
        SettingsView(showSettingsView: .constant(true)).previewDevice("iPhone 12 Pro Max").previewInterfaceOrientation(.landscapeRight)
        SettingsView(showSettingsView: .constant(true)).previewDevice("iPad Pro (9.7-inch)").previewInterfaceOrientation(.portrait)
        SettingsView(showSettingsView: .constant(true)).previewDevice("iPad mini(6th generation)").previewInterfaceOrientation(.landscapeLeft)
    }
}
