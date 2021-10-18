//
//  SettingsView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 06.10.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel = MainViewModel()
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Binding var showSettingsView: Bool
    @State private var showAlert: Bool = false
   
    
    var body: some View {
        
            
        VStack(alignment: .center, spacing: Constants.Spacings.settingsViewMainVStackSpacing) {
                HStack {
                    Image(systemName: "backward.fill")
                        .accessibilityIdentifier("back")
                        .font(.system(size: viewModel.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                        .foregroundColor(Constants.Colors.settingsViewColor)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showSettingsView.toggle()
                            }
                        }
                    Text("settings".localized(viewModel.language))
                        .accessibilityIdentifier("settings")
                        .font(.system(size: viewModel.calculateFontSettings(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height)))
                }
                
            HStack(alignment: .center, spacing: Constants.Spacings.settingsViewMainHStackSpacing) {
                    Text("delete_all_data".localized(viewModel.language))
                    .font(.system(size: viewModel.calculateFontSettings(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - Constants.Fonts.plusForSettingsViewDeleteButtonFont))
                    Button {
                        viewModel.deleteAllFromDB()
                    } label: {
                        Text("delete".localized(viewModel.language))
                            .font(.system(size: viewModel.calculateFontSettings(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - Constants.Fonts.plusForSettingsViewDeleteButtonFont))
                            .foregroundColor(.black)
                    }
                    .accessibilityIdentifier("delete")
                    .frame(width: viewModel.calculateWidthForButton(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: Constants.Heights.settingsViewDeleteButtonHeight)
                    .background(Color.blue)
                    .cornerRadius(Constants.CornerRadiuses.settingsViewDeleteAllCornerRaduis)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("database_is_empty".localized(viewModel.language)), message: Text("one_more_time".localized(viewModel.language)), dismissButton: .some(.cancel(Text("OK"))))
                    }
                }
                .frame(width: viewModel.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: viewModel.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Constants.Colors.settingsViewColor)
                .cornerRadius(Constants.CornerRadiuses.settingsViewDeleteAllCornerRaduis)
                
                
            HStack(alignment: .center, spacing: Constants.Spacings.settingsViewMainHStackSpacing) {
                    Text("settings_language".localized(viewModel.language))
                    .font(.system(size: viewModel.calculateFontSettings(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - Constants.Fonts.plusForSettingsViewLanguageChangeButtonFont))
                    
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
                            .frame(width: Constants.Widths.settingsViewLanguageButtonWidth,
                                   height: Constants.Heights.settingsViewLanguageButtonHeight)
                            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                            .accessibilityIdentifier("changeLanguageMenu")
                    }
                    
                }
                .frame(width: viewModel.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: viewModel.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Constants.Colors.settingsViewColor)
                .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                
            HStack(alignment: .center, spacing: Constants.Spacings.temperatureDescriptionViewMainHstackSpacing) {
                    Text("color_of_views".localized(viewModel.language))
                    .font(.system(size: viewModel.calculateFont(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height) - Constants.Fonts.plusForSettingsViewLanguageChangeButtonFont))
                    Menu {
                        Button {
                            withAnimation(.easeInOut) {
                                ColorChangeService.shared.color = .green
                            }
                        } label: {
                            Text("green".localized(viewModel.language))
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                            ColorChangeService.shared.color = .pink
                            }
                        } label: {
                            Text("pink".localized(viewModel.language))
                        }
                        
                        Button {
                            withAnimation(.easeInOut) {
                            ColorChangeService.shared.color = .purple
                            }
                        } label: {
                            Text("purple".localized(viewModel.language))
                        }
                        
                    } label: {
                        Image(systemName: "paintbrush")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
                            .frame(width: Constants.Widths.settingsViewBrushButtonWidth,
                                   height: Constants.Heights.settingsViewDeleteButtonHeight)
                            
                    }
                }
                .frame(width: viewModel.calculateWidthForFramgment(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: viewModel.calculateHeight(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height))
                .background(Constants.Colors.settingsViewColor)
                .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                
            }
        .frame(width: viewModel.calculateWidth(heightClass: heightClass, screenHeight: UIScreen.main.bounds.height), height: heightClass == .some(.regular) ? Constants.Heights.settingsViewHeight1 : Constants.Heights.settingsViewHeight2)
            .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
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
