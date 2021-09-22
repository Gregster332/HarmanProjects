//
//  AddCityView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 23.09.2021.
//

import SwiftUI

struct AddCityView: View {
    
    @Binding var showThisView: Bool
    @State private var text: String = ""
    @EnvironmentObject var arrayCity: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Text("Введите название города")
                .multilineTextAlignment(.center)
                .font(.system(size: 30))
            
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.system(size: 25))
                TextField("Name...", text: $text)
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 1.3, height: UIScreen.main.bounds.height / 10, alignment: .center)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(15)
            
            Button(action: {
                DispatchQueue.main.async {
                    arrayCity.add(name: text)
                }
                showThisView.toggle()
                print(arrayCity.array)
            }, label: {
                Text("Search")
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
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
