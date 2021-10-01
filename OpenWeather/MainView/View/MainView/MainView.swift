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
    
    //MARK: - Global observables
    @Environment(\.verticalSizeClass) var heightClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthClass: UserInterfaceSizeClass?
    @ObservedObject var realmService = RealMService()
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var model = MainViewModel()
    
    //MARK: - Private observables
    @State private var userFromLocation: Welcome? = Welcome(weather: [Weather(main: "")], main: Main(temp: 333, feelsLike: 3, tempMin: 3, tempMax: 3, pressure: 3, humidity: 3), sys: Sys(sunrise: 22, sunset: 22), name: "")
    @State private var city: City? = nil
    @State private var showAddView: Bool = false
    @State private var showSheet: Bool = false
    @State private var showAttentionLabel: Bool = false

    //MARK: - Variables
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    //MARK: - Init
    init() {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }
    
    var body: some View {
        
        let coordinate = self.locationManager.location != nil ? self.locationManager.location?.coordinate : CLLocationCoordinate2D()
        
        return NavigationView {
            //MARK: - View
            List {
                if Reachability.isConnectedToNetwork() {
                NavigationLink(
                    destination: DetailView(weatherDetails: model.currentCity, isNavigationLink: true, hideSheet: $showSheet),
                    label: {
                        if model.currentCity != nil  {
                            Cell(city: model.currentCity!.name,
                                 temp: Int(model.currentCity!.temp) - Constants.toCelsius,
                                 max: Int(model.currentCity!.tempMax) - Constants.toCelsius,
                                 min: Int(model.currentCity!.tempMin) - Constants.toCelsius,
                                 main: emojis[model.currentCity?.main ?? "Rain"] ?? "")
                        } else {
                                ProgressView().progressViewStyle(CircularProgressViewStyle())
                        }
                    })
                    .buttonStyle(PlainButtonStyle())
                    .disabled(showAddView || showAttentionLabel)
                } else {
                    Text(LocalizedStringKey("No internet"))
                }
                
                
                ForEach(realmService.cities.indices, id: \.self) { index in
                    Button {
                        city = realmService.cities[index]
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            //print(city)
                            if city != nil {
                                showSheet.toggle()
                            } else {
                                print("oops")
                            }
                        }
                    } label: {
                        Cell(city: realmService.cities[index].name,
                             temp: Int(realmService.cities[index].temp) - Constants.toCelsius,
                             max: Int(realmService.cities[index].tempMax) - Constants.toCelsius,
                             min: Int(realmService.cities[index].tempMin) - Constants.toCelsius,
                             main: emojis[realmService.cities[index].main]!)
                            .contextMenu(ContextMenu(menuItems: {
                                Button(action: {
                                    withAnimation(.easeIn) {
                                        realmService.deleteData(object: realmService.cities[index])
                                        realmService.fetchData()
                                    }
                                }, label: {
                                    Text(LocalizedStringKey("Delete"))
                                })
                            }))
                            .disabled(showAddView || showAttentionLabel)
                    }
                    .accessibilityIdentifier("\(realmService.cities[index].name)")
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }
                
            }
            .accessibilityIdentifier("list")
            .refreshable {
                if Reachability.isConnectedToNetwork() {
                    getCurrnetWeather()
                } else {
                    withAnimation(.easeInOut) {
                        showAttentionLabel.toggle()
                    }
                }
            }
            .listStyle(InsetListStyle())
            .sheet(isPresented: $showSheet) {
                if city != nil {
                    DetailView(weatherDetails: city, isNavigationLink: false, hideSheet: $showSheet)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .onReceive(timer) { _ in
                            showSheet.toggle()
                        }
                }
            }
            
            
            .navigationBarTitle(LocalizedStringKey("Cities"))
            .navigationBarItems(trailing: Button(action: {
                withAnimation(.easeIn) {
                    showAddView.toggle()
                }
            }, label: {
                Image(systemName: "plus")
            }).accessibilityIdentifier("showCityButton"))
            .disabled(showAddView || showAttentionLabel)
        }
        .padding(1)
        .navigationViewStyle(StackNavigationViewStyle())
        .blur(radius: showAddView || showAttentionLabel ? 2 : 0)
        .overlay(AddCityView(showThisView: $showAddView)
                    .environmentObject(realmService)
                    .offset(y: showAddView ? 0 : -1000))
        .overlay(AttentionView(showAttentionLabel: $showAttentionLabel)
                    .offset(y: showAttentionLabel ? 0 : -1000))
        //MARK: - Lifecycle
        .onAppear {
            print("gg")
            let service = NetworkService()
            realmService.fetchData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                service.getDataByCoordinates(lat: coordinate?.latitude ?? 0, lon: coordinate?.longitude ?? 0) { item in
                    switch(item) {
                    case .success(let result):
                        model.getCityFromWelcome(welcome: result)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
            
        }
    }
    
    //MARK: - Private functions
    private func getCurrnetWeather() {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location?.coordinate : CLLocationCoordinate2D()
        let service = NetworkService()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            service.getDataByCoordinates(lat: coordinate?.latitude ?? 0, lon: coordinate?.longitude ?? 0) { item in
                switch(item) {
                case .success(let result):
                    model.getCityFromWelcome(welcome: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            realmService.getNewData()
        }
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
