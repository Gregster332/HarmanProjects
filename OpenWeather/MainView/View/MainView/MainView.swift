//
//  ContentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI

struct MainView: View {
     let k = "c302a638f8f46f6a557e143a3a483647"
    
    @ObservedObject var vm = WeatherViewModel()
    @State var showAddView: Bool = false
    @State var cities: [Welcome] = []
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false){
                
                ForEach(vm.citiesWelcome.indices, id: \.self) { index in
                            NavigationLink(
                                destination: DetailView(weatherDetails: vm.citiesWelcome[index]),
                                label: {
                                    WeatherPreview(city: vm.citiesWelcome[index].name,
                                                   temp: Int(vm.citiesWelcome[index].main.temp) - 273,
                                                   max: Int(vm.citiesWelcome[index].main.tempMax) - 273,
                                                   min: Int(vm.citiesWelcome[index].main.tempMin) - 273)
                                })
                                .buttonStyle(PlainButtonStyle())
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(action: {
                                        withAnimation(.easeIn) {
                                            vm.citiesWelcome.remove(at: index)
                                            vm.deleteData(object: vm.cities[index])
                                        }
                                        print(vm.cities)
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
                    .environmentObject(vm)
                    .offset(y: showAddView ? 0 : -UIScreen.main.bounds.height))
        .onAppear {
            vm.fetchData()
            vm.addCurrentCityCityInArray(name: nil)
            print(vm.cities)
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
