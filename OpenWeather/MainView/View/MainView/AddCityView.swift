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
    @EnvironmentObject var arrayCity: WeatherViewModel
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    
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
                TextField("Name...", text: $arrayCity.cityName, onCommit:  {
                    addNewData()
                    UIApplication.shared.endEditing()
                })
                    
            }
            .padding()
            .frame(width: heightClass == .regular ? 290 : 500, height: heightClass == .regular ? 100 : 100, alignment: .center)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(15)
            
            
            Button(action: {
                addNewData()
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
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Вводите название на английском"), message: nil, dismissButton: .some(.cancel(Text("OK"), action: {
                    showingAlert = false
                })))
            }
            
            
            Button(action: {
                    showThisView.toggle()
                    arrayCity.cityName = ""
            }, label: {
                Text("Cancel")
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
                    .foregroundColor(.red.opacity(0.5))
                    .padding()
                    .frame(width: 140, height: 50, alignment: .center)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(15)
            })
            
        }
        .frame(width: heightClass == .regular ? 300 : 500, height: heightClass == .regular ? 400 : 300)
        .padding()
        .background(Color.gray)
        .cornerRadius(15)
        
    }
    
    //MARK: - Private functions
    private func addNewData() {
        if checkSymbols(str: arrayCity.cityName) {
            let service = NetworkService()
            
            service.getData(cityName: arrayCity.cityName) { item in
                //print(item)
                guard let item = item else { return }
                arrayCity.addData(name: item.name,
                                  feelsLike: item.main.feelsLike,
                                  sunrise: item.sys.sunrise,
                                  sunset: item.sys.sunset,
                                  temp: item.main.temp,
                                  tempMin: item.main.tempMin,
                                  tempMax: item.main.tempMax,
                                  pressure: item.main.pressure,
                                  humidity: item.main.humidity,
                                  main: item.weather.first!.main)
            }
            showThisView.toggle()
            arrayCity.cityName = ""
            UIApplication.shared.endEditing()
        } else {
            showingAlert = true
        }
    }
    
    private func checkSymbols(str: String) -> Bool {
           for chr in str {
              if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && chr != " " && chr != "-") {
                 return false
              }
           }
           return true
        }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView(showThisView: .constant(false))
    }
}
