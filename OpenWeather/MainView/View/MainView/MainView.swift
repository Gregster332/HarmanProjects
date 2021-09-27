//
//  ContentView.swift
//  OpenWeather
//
//  Created by Grigory Zenkov on 22.09.2021.
//

import SwiftUI
import RealmSwift
import MapKit

struct MainView: View {
     let k = "c302a638f8f46f6a557e143a3a483647"
    
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @ObservedObject var vm = WeatherViewModel()
    @ObservedObject var locationManager = LocationManager()
    
    @State private var userFromLocation: Welcome? = Welcome(weather: [Weather(main: "")], main: Main(temp: 3, feelsLike: 3, tempMin: 3, tempMax: 3, pressure: 3, humidity: 3), sys: Sys(sunrise: 22, sunset: 22), name: "")
    @State var showAddView: Bool = false
    @State var cities: [Welcome] = []
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
      let coordinate = self.locationManager.location != nil ? self.locationManager.location?.coordinate : CLLocationCoordinate2D()
        
      return NavigationView {

            ScrollView(.vertical, showsIndicators: false){
                
                        NavigationLink(
                            destination: DetailView(weatherDetails: getCityFromWelcome(welcome: userFromLocation!)?.name == nil ? vm.cities.first : getCityFromWelcome(welcome: userFromLocation!)),
                            label: {
                                WeatherPreview(city: userFromLocation!.name, temp: Int((userFromLocation?.main.temp)!) - 273, max: Int((userFromLocation?.main.tempMax)!) - 273, min: Int((userFromLocation?.main.tempMin)!) - 273)
                            })
                            .buttonStyle(PlainButtonStyle())
                            .disabled(showAddView)
                
                
                ForEach(vm.cities.indices, id: \.self) { index in
                            NavigationLink(
                                destination: DetailView(weatherDetails: vm.cities[index]),
                                label: {
                                    WeatherPreview(city: vm.cities[index].name, temp: Int(vm.cities[index].temp) - 273, max: Int(vm.cities[index].tempMax) - 273, min: Int(vm.cities[index].tempMin) - 273)
                                })
                                .buttonStyle(PlainButtonStyle())
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(action: {
                                        withAnimation(.easeIn) {
                                            vm.deleteData(object: vm.cities[index])
                                            vm.fetchData()
                                            //vm.cities.remove(at: index)
                                        }
                                        //print(vm.cities)
                                        //print(vm.citiesWelcome)
                                    }, label: {
                                        Text("Delete")
                                    })
                                }))
                                .disabled(showAddView)
                    }
            }
            .navigationBarTitle(LocalizedStringKey("Cities"))
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.easeIn) {
                    showAddView.toggle()
                }
            }, label: {
                Image(systemName: "plus")
            }))
            .disabled(showAddView)
        }
        .padding(1)
        .navigationViewStyle(StackNavigationViewStyle())
        .blur(radius: showAddView ? 2 : 0)
        .overlay(AddCityView(showThisView: $showAddView)
                    .environmentObject(vm)
                    .offset(y: showAddView ? 0 : -1000))
        .onAppear {
            let service = NetworkService()
            vm.fetchData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                service.getDataByCoordinates(lat: coordinate?.latitude ?? 0, lon: coordinate?.longitude ?? 0) { item in
                    self.userFromLocation = item
                }
            }
            
        }
      .onReceive(timer, perform: { _ in
        getCurrnetWeather()
        //print("hello")
      })
        //TODO: - onReceive
    }
    
    private func getCurrnetWeather() {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location?.coordinate : CLLocationCoordinate2D()
        let service = NetworkService()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            service.getDataByCoordinates(lat: coordinate?.latitude ?? 0, lon: coordinate?.longitude ?? 0) { item in
                self.userFromLocation = item
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            vm.getNewData()
            print("gg")
        }
    }
    
    private func getCityFromWelcome(welcome: Welcome?) -> City? {
        guard let welcome = welcome else { return nil }
        let city = City()
        city.feelsLike = welcome.main.feelsLike
        city.humidity = welcome.main.humidity
        city.main = welcome.weather.first!.main
        city.name = welcome.name
        city.pressure = welcome.main.pressure
        city.sunrise = welcome.sys.sunrise
        city.sunset = welcome.sys.sunset
        city.temp = welcome.main.temp
        city.tempMax = welcome.main.tempMax
        city.tempMin = welcome.main.tempMin
        return city
    }
    
    }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView().previewDevice("iPhone 8").previewLayout(.fixed(width: 667 , height: 375))
        MainView().previewDevice("iPhone 12").previewLayout(.fixed(width: 844, height: 390))
//        MainView().previewDevice("iPhone 12 Pro Max")
    }
}
