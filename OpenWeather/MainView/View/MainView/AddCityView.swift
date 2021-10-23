//
//  AddCityView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import SwiftUI
import UIKit
import RealmSwift

struct AddCityView: View {
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @ObservedObject var viewModel: MainViewModel
   
    
    var body: some View {
        //MARK: - View
        VStack(alignment: .center, spacing: Constants.Spacings.addCityViewMainVSatckSpacing) {
            
            Text("enter_city_name".localized(viewModel.language))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .font(.system(size: Constants.Fonts.addCityViewEnterCityFont))
            
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: Constants.Fonts.attentionFont))
                TextField("name".localized(viewModel.language), text: $viewModel.searcedCurrentCity, onEditingChanged: { _ in
                    print("")
                }, onCommit:  {
                    viewModel.addNewCityToDBBYName()
                    UIApplication.shared.endEditing()
                }).accessibilityIdentifier("AddCityTextFireld")
                    
            }
            .padding()
            .frame(width: heightClass == .regular ? Constants.Widths.addCityViewTextFieldViewWidth1 : Constants.Widths.addCityViewTextFieldViewWidth2,
                   height: heightClass == .regular ? Constants.Heights.addCityViewTextFieldViewHeigh : Constants.Heights.addCityViewTextFieldViewHeigh, alignment: .center)
            .background(Constants.Colors.addCityViewColor)
            .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            
            
            Button(action: {
                withAnimation(.easeInOut) {
                    if Reachability.isConnectedToNetwork(){
                        viewModel.addNewCityToDBBYName()
                    } else {
                        viewModel.showingAlert.toggle()
                    }
                }
            }, label: {
                Text("search".localized(viewModel.language))
                    .font(.system(size: Constants.Fonts.refreshFont))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: Constants.Widths.addCityViewSearchButtonWidth,
                           height: Constants.Heights.settingsViewDeleteButtonHeight,
                           alignment: .center)
                    .background(Constants.Colors.addCityViewColor)
                    .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            })
                .accessibilityIdentifier("searchButton")
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("something_wrong".localized(viewModel.language)), message: Text(Reachability.isConnectedToNetwork() ? "enter_in_english".localized(viewModel.language) : "no_internet".localized(viewModel.language)), dismissButton: .some(.cancel(Text("OK"), action: {
                        viewModel.showingAlert = false
                    })))
                }
            
            
            
            Button(action: {
                withAnimation(.easeInOut) {
                    //print("llolooko")
                    // presentationMode.wrappedValue.dismiss()
                    viewModel.showAddView.toggle()
                    viewModel.searcedCurrentCity = ""
                    UIApplication.shared.endEditing()
                }
            }, label: {
                Text("cancel".localized(viewModel.language))
                    .font(.system(size: Constants.Fonts.refreshFont))
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding()
                    .frame(width: Constants.Widths.addCityViewSearchButtonWidth,
                           height: Constants.Heights.settingsViewDeleteButtonHeight,
                           alignment: .center)
                    .background(Constants.Colors.addCityViewColor)
                    .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            }).accessibilityIdentifier("cancelButton")
            
        }
        .navigationBarBackButtonHidden(true)
        .frame(width: heightClass == .regular ? Constants.Widths.addCityViewWidth : Constants.Widths.addCityViewTextFieldViewWidth2,
               height: heightClass == .regular ? Constants.Heights.settingsViewHeight3 : Constants.Heights.settingsViewHeight4)
        .padding()
        .background(ColorChangeService.shared.changeColor(color: viewModel.color.rawValue))
        .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
        
    }
}

