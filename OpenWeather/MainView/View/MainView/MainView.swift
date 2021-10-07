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
    @State private var city: City? = nil
    @State private var showAddView: Bool = false
    @State private var showSetiingsView: Bool = false
    @State private var showSheet: Bool = false
    @State private var showAttentionLabel: Bool = false
    @State private var isThisNoInternetAttentionView: Bool = true

    //MARK: - Variables
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var language = LocalizationService.shared.language
    var color = ColorChangeService.shared.color
   
    
    //MARK: - Init
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        
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
                    .accessibilityIdentifier("navlocation")
                    .buttonStyle(PlainButtonStyle())
                    .disabled(showAddView || showAttentionLabel || showSetiingsView)
                } else {
                    Text("no_internet".localized(language))
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
                                    Text("Delete".localized(language))
                                })
                            }))
                            .disabled(showAddView || showAttentionLabel || showSetiingsView)
                    }
                    .accessibilityIdentifier("\(realmService.cities[index].name)")
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }
                
            }
            .accessibilityIdentifier("list")
            .refreshable {
                if Reachability.isConnectedToNetwork() {
                    print("ghgh")
                    await model.getCurrnetWeather()
                    realmService.getNewData()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut) {
                            showAttentionLabel.toggle()
                        }
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showAttentionLabel = true
                                isThisNoInternetAttentionView = false
                            }
                        }
                        .accessibilityIdentifier("progress")
                }
            }
            
            
            .navigationBarTitle("Cities".localized(language))
            .navigationBarItems(leading: Button(action: {
                withAnimation(.easeInOut) {
                    showSetiingsView.toggle()
                }
            }, label: {
                Image(systemName: "gear")
            }).accessibilityIdentifier("Gear"), trailing: Button(action: {
                withAnimation(.easeIn) {
                    showAddView.toggle()
                }
            }, label: {
                Image(systemName: "plus")
            }).accessibilityIdentifier("showCityButton"))
            .disabled(showAddView || showAttentionLabel || showSetiingsView)
        }
        .background(ColorChangeService.shared.changeColor(color: color.rawValue))
        .padding(1)
        .navigationViewStyle(StackNavigationViewStyle())
        .blur(radius: showAddView || showAttentionLabel || showSetiingsView ? 2 : 0)
        .overlay(AddCityView(showThisView: $showAddView)
                    .environmentObject(realmService)
                    .offset(y: showAddView ? 0 : Constants.viewOffset))
        .overlay(AttentionView(showAttentionLabel: $showAttentionLabel, isThisNoInternetAttentionView: $isThisNoInternetAttentionView)
                    .offset(y: showAttentionLabel ? 0 : Constants.viewOffset))
        .overlay(SettingsView(showSettingsView: $showSetiingsView)
                    .environmentObject(realmService)
                    .offset(y: showSetiingsView ? 0 : Constants.viewOffset)
        )
        //MARK: - Lifecycle
        .onAppear {
            print("gg")
            //let service = NetworkService()
            realmService.fetchData()
            Task(priority: .background) {
                await model.getCurrnetWeather()
            }
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
