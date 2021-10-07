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
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @AppStorage("color")
    private var color = ColorChangeService.shared.color
    
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
                    Text("Settings".localized(language))
                        .accessibilityIdentifier("settings")
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                }
                
                HStack(alignment: .center, spacing: 60) {
                    Text("Delete all data".localized(language))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 10 ))
                    Button {
                        if !realmService.cities.isEmpty {
                        realmService.deleteAll()
                        realmService.fetchData()
                        } else {
                            showAlert.toggle()
                        }
                    } label: {
                        Text("Delete".localized(language))
                            .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 10))
                            .foregroundColor(.black)
                    }
                    .accessibilityIdentifier("delete")
                    .frame(width: model.calculateWidthForButton(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Databese is empty".localized(language)), message: Text("We can't delete deleted items one more time".localized(language)), dismissButton: .some(.cancel(Text("OK"))))
                    }
                }
                .frame(width: model.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: model.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                .cornerRadius(20)
                
                
                HStack(alignment: .center, spacing: 60) {
                    Text("settings_language".localized(language))
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
                            .cornerRadius(20)
                            .accessibilityIdentifier("changeLanguageMenu")
                    }
                    
                }
                .frame(width: model.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: model.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                .cornerRadius(20)
                
                HStack(alignment: .center, spacing: 50) {
                    Text("Color of views".localized(language))
                        .font(.system(size: model.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - 5))
                    Menu {
                        Button {
                            withAnimation(.easeInOut) {
                                ColorChangeService.shared.color = .green
                            }
                        } label: {
                            Text("Green".localized(language))
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                            ColorChangeService.shared.color = .pink
                            }
                        } label: {
                            Text("Pink".localized(language))
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                            ColorChangeService.shared.color = .purple
                            }
                        } label: {
                            Text("Purple".localized(language))
                        }
                        
                    } label: {
                        Image(systemName: "paintbrush")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(ColorChangeService.shared.changeColor(color: color.rawValue))
                            .frame(width: 50, height: 50)
                            
                    }
                }
                .frame(width: model.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: model.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                .cornerRadius(20)
                
            }
            .frame(width: model.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: heightClass == .some(.regular) ? 450 : 350)
            .background(ColorChangeService.shared.changeColor(color: color.rawValue))
            .cornerRadius(20)
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
