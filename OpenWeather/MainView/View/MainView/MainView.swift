//
//  ContentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct MainView: View {
     let k = "c302a638f8f46f6a557e143a3a483647"
    
    @ObservedObject var arrayCity = WeatherViewModel()
    @State var showAddView: Bool = false
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false){
                
                ForEach(arrayCity.array.indices, id: \.self) { index in
                            NavigationLink(
                                destination: DetailView(weatherDetails: arrayCity.array[index]),
                                label: {
                                    WeatherPreview(city: arrayCity.array[index].name,
                                                   temp: Int(arrayCity.array[index].main.temp) - 273,
                                                   max: Int(arrayCity.array[index].main.tempMax) - 273,
                                                   min: Int(arrayCity.array[index].main.tempMin) - 273)
                                })
                                .buttonStyle(PlainButtonStyle())
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(action: {
                                        arrayCity.array.remove(at: index)
                                    }, label: {
                                        Text("Delete")
                                    })
                                }))
                    }
            }
            .navigationBarTitle("Список городов")
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.easeIn) {
                    showAddView.toggle()
                }
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .blur(radius: showAddView ? 2 : 0)
        .overlay(AddCityView(showThisView: $showAddView)
                    .environmentObject(arrayCity)
                    .offset(y: showAddView ? 0 : -UIScreen.main.bounds.height))
        .onAppear {
            DispatchQueue.main.async {
                arrayCity.add(name: "Sochi")
                arrayCity.add(name: "Chili")
            }
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
//        MainView().previewDevice("iPhone 12 Pro")
//        MainView().previewDevice("iPhone 12 Pro Max")
    }
}
