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
    @State var flagForError: Bool = true
    @State var searchItem: String = ""

    //MARK: - Variables
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var language = LocalizationService.shared.language
    var color = ColorChangeService.shared.color
    
    var searchResults: [City] {
            if searchItem.isEmpty {
                return realmService.cities
            } else {
                return realmService.cities.filter { $0.name.contains(searchItem) }
            }
        }
   
    
    //MARK: - Init
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        
//        let timer1 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
//            self.t.toggle()
//        }
        
        return NavigationView {
            //MARK: - View
            List {
                if Reachability.isConnectedToNetwork() {
                NavigationLink(
                    destination: DetailView(weatherDetails: model.currentCity, isNavigationLink: true, hideSheet: $model.showSheet),
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
                    .disabled(model.showAddView || model.showAttentionLabel || model.showSetiingsView)
                } else {
                    Text("no_internet".localized(language))
                }
                
                
                ForEach(searchResults.indices, id: \.self) { index in
                    Button {
                        city = searchResults[index]
                        DispatchQueue.main.async {
                            //print(city)
                            if city != nil {
                                model.showSheet.toggle()
                            } else {
                                print("oops")
                            }
                        }
                    } label: {
                        if flagForError == false {
                        Cell(city: searchResults[index].name,
                             temp: Int(searchResults[index].temp) - Constants.toCelsius,
                             max: Int(searchResults[index].tempMax) - Constants.toCelsius,
                             min: Int(searchResults[index].tempMin) - Constants.toCelsius,
                             main: emojis[searchResults[index].main]!)
                            .contextMenu(ContextMenu(menuItems: {
                                Button(action: {
                                    withAnimation(.easeIn) {
                                        realmService.deleteData(object: searchResults[index])
                                        realmService.fetchData()
                                    }
                                }, label: {
                                    Text("Delete".localized(language))
                                })
                            }))
                            .disabled(model.showAddView || model.showAttentionLabel || model.showSetiingsView || flagForError)
                        } else {
                            ProgressView().progressViewStyle(CircularProgressViewStyle())
                        }
                    }
                    .accessibilityIdentifier("\(realmService.cities[index].name)")
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }
                
            }
            .accessibilityIdentifier("list")
            .searchable(text: $searchItem)
            .refreshable {
                if Reachability.isConnectedToNetwork() {
                    print("ghgh")
                    await model.getCurrnetWeather()
                    await realmService.getNewData()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut) {
                            model.showAttentionLabel.toggle()
                        }
                    }
                }
            }
            .listStyle(InsetListStyle())
            .sheet(isPresented: $model.showSheet) {
                if city != nil {
                    DetailView(weatherDetails: city, isNavigationLink: false, hideSheet: $model.showSheet)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .onReceive(timer) { _ in
                            model.showSheet.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                model.showAttentionLabel = true
                                model.isThisNoInternetAttentionView = false
                            }
                        }
                        .accessibilityIdentifier("progress")
                }
            }
            
            
            .navigationBarTitle("Cities".localized(language))
            .navigationBarItems(leading: Button(action: {
                withAnimation(.easeInOut) {
                    model.showSetiingsView.toggle()
                }
            }, label: {
                Image(systemName: "gear")
            }).accessibilityIdentifier("Gear"), trailing: Button(action: {
                withAnimation(.easeIn) {
                    model.showAddView.toggle()
                }
            }, label: {
                Image(systemName: "plus")
            }).accessibilityIdentifier("showCityButton"))
            .disabled(model.showAddView || model.showAttentionLabel || model.showSetiingsView)
        }
        .padding(1)
        .navigationViewStyle(StackNavigationViewStyle())
        .blur(radius: model.showAddView || model.showAttentionLabel || model.showSetiingsView ? 2 : 0)
        .overlay(AddCityView(showThisView: $model.showAddView)
                    .environmentObject(realmService)
                    .offset(y: model.showAddView ? 0 : Constants.viewOffset))
        .overlay(AttentionView(showAttentionLabel: $model.showAttentionLabel, isThisNoInternetAttentionView: $model.isThisNoInternetAttentionView)
                    .offset(y: model.showAttentionLabel ? 0 : Constants.viewOffset))
        .overlay(SettingsView(showSettingsView: $model.showSetiingsView)
                    .environmentObject(realmService)
                    .offset(y: model.showSetiingsView ? 0 : Constants.viewOffset)
        )
        //MARK: - Lifecycle
        .onAppear {
            if Reachability.isConnectedToNetwork() {
                realmService.fetchData()
                Task(priority: .background) {
                    await realmService.getNewData()
                    await model.getCurrnetWeather()
                }
               
            } else {
                realmService.fetchData()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.flagForError.toggle()
            }
            
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
