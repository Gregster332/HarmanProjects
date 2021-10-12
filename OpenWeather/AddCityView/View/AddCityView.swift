//
//  AddCityView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import SwiftUI
import UIKit

struct AddCityView: View {
    
    //MARK: - Private observables
    @Binding var showThisView: Bool
    @State private var showingAlert: Bool = false
    
    //MARK: - Global observables
    @EnvironmentObject var realmService: RealMService
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @ObservedObject var model = AddCityViewModel()
    
    var body: some View {
        //MARK: - View
        VStack(alignment: .center, spacing: 20) {
            
            Text("enter_city_name".localized(model.language))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .font(.system(size: Constants.Fonts.addCityViewEnterCityFont))
            
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: Constants.Fonts.attentionFont))
                TextField("name".localized(model.language), text: $realmService.cityName, onCommit:  {
                    model.addNewData(realmService: realmService, showingAlert: &showingAlert, showThisView: &showThisView)
                    UIApplication.shared.endEditing()
                }).accessibilityIdentifier("AddCityTextFireld")
                    
            }
            .padding()
            .frame(width: heightClass == .regular ? 290 : 500, height: heightClass == .regular ? 100 : 100, alignment: .center)
            .background(Constants.Colors.addCityViewColor)
            .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            
            
            Button(action: {
                if Reachability.isConnectedToNetwork() {
                    model.addNewData(realmService: realmService, showingAlert: &showingAlert, showThisView: &showThisView)
                } else {
                    showingAlert.toggle()
                }
            }, label: {
                Text("search".localized(model.language))
                    .font(.system(size: Constants.Fonts.refreshFont))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 140, height: 50, alignment: .center)
                    .background(Constants.Colors.addCityViewColor)
                    .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            })
            .accessibilityIdentifier("searchButton")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("something_wrong".localized(model.language)), message: Text(Reachability.isConnectedToNetwork() ? "enter_in_english".localized(model.language) : "no_internet".localized(model.language)), dismissButton: .some(.cancel(Text("OK"), action: {
                    showingAlert = false
                })))
            }
            
            
            
            Button(action: {
                    showThisView.toggle()
                    realmService.cityName = ""
                    UIApplication.shared.endEditing()
            }, label: {
                Text("cancel".localized(model.language))
                    .font(.system(size: Constants.Fonts.refreshFont))
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding()
                    .frame(width: 140, height: 50, alignment: .center)
                    .background(Constants.Colors.addCityViewColor)
                    .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
            }).accessibilityIdentifier("cancelButton")
            
        }
        .frame(width: heightClass == .regular ? 300 : 500, height: heightClass == .regular ? 400 : 300)
        .padding()
        .background(ColorChangeService.shared.changeColor(color: model.color.rawValue))
        .cornerRadius(Constants.CornerRadiuses.addCityViewTextFieldCornerRaduis)
        
    }
}

