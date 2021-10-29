//
//  SettingsView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 06.10.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Binding var showSettingsView: Bool
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: heightClass == .regular ? Constants.Spacings.settingsViewMainVStackSpacing : 25) {
            HStack {
                Image(systemName: "backward.fill")
                    .accessibilityIdentifier("back")
                    .font(.system(size: heightClass == .regular ? Constants.Fonts.attentionFont : Constants.Fonts.attentionFont))
                    .foregroundColor(Constants.Colors.settingsViewColor)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSettingsView.toggle()
                        }
                    }
                Text("settings".localized(viewModel.language))
                    .accessibilityIdentifier("settings")
                    .font(.system(size: heightClass == .regular ? Constants.Fonts.attentionFont : Constants.Fonts.attentionFont))
            }
            
            HStack(alignment: .center, spacing: Constants.Spacings.settingsViewMainHStackSpacing) {
                Text("delete_all_data".localized(viewModel.language))
                    .font(.system(size: heightClass == .regular ? Constants.Fonts.settingsViewDeleteButtonRegularFont : Constants.Fonts.attentionFont))
                
                Spacer()
                
                Button {
                    if viewModel.cities.isEmpty {
                        showAlert.toggle()
                    } else {
                        viewModel.deleteAllFromDB()
                    }
                } label: {
                    Text("delete".localized(viewModel.language))
                        .font(.system(size: heightClass == .regular ? Constants.Fonts.settingsViewDeleteButtonRegularFont : Constants.Fonts.attentionFont))
                        .foregroundColor(.black)
                }
                .accessibilityIdentifier("delete")
                .frame(width: heightClass == .regular ? Constants.Widths.settingsViewMaxWidth1 : Constants.Widths.settingsViewMaxWidth2,
                       height: Constants.Heights.settingsViewDeleteButtonHeight)
                .background(Color.blue)
                .cornerRadius(Constants.CornerRadiuses.settingsViewDeleteAllCornerRaduis)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("database_is_empty".localized(viewModel.language)), message: Text("one_more_time".localized(viewModel.language)), dismissButton: .some(.cancel(Text("OK"))))
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity,
                   maxHeight: heightClass == .regular ? Constants.Heights.settingsViewMaxHeight1 : Constants.Heights.settingsViewMaxHeight2)
            .background(Constants.Colors.settingsViewColor)
            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
            .padding(.horizontal)
            
            
            HStack(alignment: .center, spacing: Constants.Spacings.settingsViewMainHStackSpacing) {
                Text("settings_language".localized(viewModel.language))
                    .font(.system(size: heightClass == .regular ? Constants.Fonts.temperatureDescriptionCellFont : Constants.Fonts.attentionFont))
                
                Spacer()
                
                Menu {
                    Button {
                        withAnimation(.easeInOut(duration: Constants.AsyncSeconds.asyncHalfSecond)) {
                            viewModel.changeLanguage(to: .russian)
                        }
                    } label: {
                        Text("Русский")
                    }
                    .accessibilityIdentifier("rus")
                    Button {
                        withAnimation(.easeInOut(duration: Constants.AsyncSeconds.asyncHalfSecond)) {
                            viewModel.changeLanguage(to: .english_us)
                        }
                    } label: {
                        Text("English (US)")
                    }
                    .accessibilityIdentifier("eng")
                } label: {
                    Image("lang")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: heightClass == .regular ? Constants.Widths.settingsViewMaxWidth1 : Constants.Widths.settingsViewMaxWidth2,
                               height: Constants.Heights.settingsViewDeleteButtonHeight)
                        .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
                        .accessibilityIdentifier("changeLanguageMenu")
                }
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity,
                   maxHeight: heightClass == .regular ? Constants.Heights.settingsViewMaxHeight1 : Constants.Heights.settingsViewMaxHeight2)
            .background(Constants.Colors.settingsViewColor)
            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
            .padding(.horizontal)
            
            HStack(alignment: .center, spacing: Constants.Spacings.temperatureDescriptionViewMainHstackSpacing) {
                Text("color_of_views".localized(viewModel.language))
                    .font(.system(size: heightClass == .regular ? Constants.Fonts.settingsViewDeleteButtonRegularFont : Constants.Fonts.attentionFont))
                
                Spacer()
                
                Menu {
                    Button {
                        withAnimation(.easeInOut(duration: Constants.AsyncSeconds.asyncHalfSecond)) {
                            viewModel.changeColor(to: .green)
                        }
                    } label: {
                        Text("green".localized(viewModel.language))
                    }
                    
                    Button {
                        withAnimation(.easeInOut(duration: Constants.AsyncSeconds.asyncHalfSecond)) {
                            viewModel.changeColor(to: .pink)
                        }
                    } label: {
                        Text("pink".localized(viewModel.language))
                    }
                    
                    Button {
                        withAnimation(.easeInOut(duration: Constants.AsyncSeconds.asyncHalfSecond)) {
                            viewModel.changeColor(to: .purple)
                        }
                    } label: {
                        Text("purple".localized(viewModel.language))
                    }
                    
                } label: {
                    Image(systemName: "paintbrush")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
                        .frame(width: heightClass == .regular ? Constants.Widths.settingsViewMaxWidth1 : Constants.Widths.settingsViewMaxWidth2,
                               height: Constants.Heights.settingsViewDeleteButtonHeight)
                    
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity,
                   maxHeight: heightClass == .regular ? Constants.Heights.settingsViewMaxHeight1 : Constants.Heights.settingsViewMaxHeight2)
            .background(Constants.Colors.settingsViewColor)
            .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
            .padding(.horizontal)
            
        }
        .frame(width: heightClass == .regular ? Constants.Widths.settingsViewRegularWidth : Constants.Widths.addCityViewTextFieldViewWidth2,
               height: heightClass == .regular ? Constants.Heights.settingsViewHeight1 : Constants.Heights.settingsViewHeight2)
        .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
        .cornerRadius(Constants.CornerRadiuses.attentionViewCornerRadius)
    }
}

