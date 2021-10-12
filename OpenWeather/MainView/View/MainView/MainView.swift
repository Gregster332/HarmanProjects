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
    @ObservedObject var realmService = RealMService()
    @ObservedObject var model = MainViewModel()
    
    var searchResults: [City] {
        if model.searchItem.isEmpty {
            return realmService.cities
        } else {
            return realmService.cities.filter { $0.name.contains(model.searchItem) }
        }
    }
    
    
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
                    destination: DetailView(weatherDetails: model.currentCity, isNavigationLink: true, hideSheet: $model.showSheet),
                    label: {
                        if model.currentCity != nil  {
                            TemperatureDescriptionCell(model.currentCity)
                        } else {
                                ProgressView().progressViewStyle(CircularProgressViewStyle())
                        }
                    })
                    .accessibilityIdentifier("navlocation")
                    .buttonStyle(PlainButtonStyle())
                    .disabled(model.showAddView || model.showAttentionLabel || model.showSetiingsView)
                } else {
                    Text("no_internet".localized(model.language))
                }
                
                
                ForEach(searchResults.indices, id: \.self) { index in
                    Button {
                        model.city = searchResults[index]
                        DispatchQueue.main.async {
                            //print(city)
                            if model.city != nil {
                                model.showSheet.toggle()
                            } else {
                                print("oops")
                            }
                        }
                    } label: {
                        if model.flagForError == false {
                        TemperatureDescriptionCell(searchResults[index])
                            .contextMenu(ContextMenu(menuItems: {
                                Button(action: {
                                    withAnimation(.easeIn) {
                                        realmService.deleteData(object: searchResults[index])
                                        realmService.fetchData()
                                    }
                                }, label: {
                                    Text("delete".localized(model.language))
                                })
                            }))
                            .disabled(model.showAddView || model.showAttentionLabel || model.showSetiingsView || model.flagForError)
                        } else {
                            ProgressView().progressViewStyle(CircularProgressViewStyle())
                        }
                    }
                    .accessibilityIdentifier("\(realmService.cities[index].name)")
                    .buttonStyle(PlainButtonStyle())
                    
                    
                }
                
            }
            .accessibilityIdentifier("list")
            .searchable(text: $model.searchItem)
            .refreshable {
                if Reachability.isConnectedToNetwork() {
                    Task {
                        await model.getCurrnetWeather()
                        await realmService.getNewData()
                    }
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
                if model.city != nil {
                    DetailView(weatherDetails: model.city, isNavigationLink: false, hideSheet: $model.showSheet)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .onReceive(model.timer) { _ in
                            model.showSheet.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                model.showAttentionLabel = true
                                model.isThisNoInternetAttentionView = false
                            }
                        }
                        .accessibilityIdentifier("progress")
                }
            }
            
            
            .navigationBarTitle("cities".localized(model.language))
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
                    .offset(y: model.showAddView ? 0 : Constants.Offsets.viewOffset))
        .overlay(AttentionView(showAttentionLabel: $model.showAttentionLabel, isThisNoInternetAttentionView: $model.isThisNoInternetAttentionView)
                    .offset(y: model.showAttentionLabel ? 0 : Constants.Offsets.viewOffset)
                 )
        .overlay(SettingsView(showSettingsView: $model.showSetiingsView)
                    .environmentObject(realmService)
                    .offset(y: model.showSetiingsView ? 0 : Constants.Offsets.viewOffset)
        )
        //MARK: - Lifecycle
        .onAppear {
            if Reachability.isConnectedToNetwork() {
                realmService.fetchData()
                Task(priority: .background) {
                    await realmService.getNewData()
                    await model.getCurrnetWeather()
                }
                model.flagForError.toggle()
            } else {
                realmService.fetchData()
            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                model.flagForError.toggle()
//            }
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView().previewDevice("iPhone 8").previewLayout(.fixed(width: 667 , height: 375))
        MainView().previewDevice("iPhone 12").previewLayout(.fixed(width: 844, height: 390))
    
    }
}
