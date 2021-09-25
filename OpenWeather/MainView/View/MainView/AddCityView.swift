//
//  AddCityView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import SwiftUI

struct AddCityView: View {
    
    @Binding var showThisView: Bool
    @ObservedObject var orientationInfo = OrientationInfo()
    @EnvironmentObject var arrayCity: WeatherViewModel
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Text("Введите название города")
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .font(.system(size: 30))
            
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: 25))
                TextField("Name...", text: $arrayCity.cityName)
            }
            .padding()
            .frame(width: heightClass == .regular ? 290 : 500, height: heightClass == .regular ? 100 : 100, alignment: .center)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(15)
            
            Button(action: {
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
//                    arrayCity.addData()
//                    arrayCity.addCurrentCityCityInArray()
                    //arrayCity.checkEmptyElements()
                    showThisView.toggle()
                    print(arrayCity.cities)
                    arrayCity.cityName = ""
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
            Button(action: {
                    showThisView.toggle()
                    arrayCity.cityName = ""
                    print(arrayCity.cities)
                    //print(arrayCity.citiesWelcome)
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
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView(showThisView: .constant(false))
    }
}
