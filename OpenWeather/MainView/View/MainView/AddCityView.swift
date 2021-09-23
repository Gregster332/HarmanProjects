//
//  AddCityView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import SwiftUI

struct AddCityView: View {
    
    @Binding var showThisView: Bool
    
    @EnvironmentObject var arrayCity: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Text("Введите название города")
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
            
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: 25))
                TextField("Name...", text: $arrayCity.cityName)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 10, alignment: .center)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(15)
            
            Button(action: {
               
                    arrayCity.addData()
                    arrayCity.addCurrentCityCityInArray(name: arrayCity.cityName)
                    showThisView.toggle()
                    arrayCity.cityName = ""
                
            }, label: {
                Text("Search")
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 15, alignment: .center)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(15)
            })
            
        }
        .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 2.5)
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
