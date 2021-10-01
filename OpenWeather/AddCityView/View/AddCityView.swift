//
//  AddCityView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import SwiftUI

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
            
            Text(LocalizedStringKey("Enter city name"))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .font(.system(size: 30))
            
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: 25))
                TextField("Name...", text: $realmService.cityName, onCommit:  {
                    model.addNewData(realmService: realmService, showingAlert: &showingAlert, showThisView: &showThisView)
                    UIApplication.shared.endEditing()
                }).accessibilityIdentifier("AddCityTextFireld")
                    
            }
            .padding()
            .frame(width: heightClass == .regular ? 290 : 500, height: heightClass == .regular ? 100 : 100, alignment: .center)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(15)
            
            
            Button(action: {
                if Reachability.isConnectedToNetwork() {
                    model.addNewData(realmService: realmService, showingAlert: &showingAlert, showThisView: &showThisView)
                } else {
                    showingAlert.toggle()
                }
            }, label: {
                Text("Search")
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 140, height: 50, alignment: .center)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(15)
            })
            .accessibilityIdentifier("searchButton")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(LocalizedStringKey("Something wrong🤨")), message: Text(Reachability.isConnectedToNetwork() ? LocalizedStringKey("Please, enter the city name in English") : LocalizedStringKey("No internet")), dismissButton: .some(.cancel(Text("OK"), action: {
                    showingAlert = false
                })))
            }
            
            
            Button(action: {
                    showThisView.toggle()
                    realmService.cityName = ""
                    UIApplication.shared.endEditing()
            }, label: {
                Text("Cancel")
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
                    .foregroundColor(.red.opacity(0.5))
                    .padding()
                    .frame(width: 140, height: 50, alignment: .center)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(15)
            }).accessibilityIdentifier("cancelButton")
            
        }
        .frame(width: heightClass == .regular ? 300 : 500, height: heightClass == .regular ? 400 : 300)
        .padding()
        .background(Color.gray)
        .cornerRadius(15)
        
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView(showThisView: .constant(false))
    }
}
