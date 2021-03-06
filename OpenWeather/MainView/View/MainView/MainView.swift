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
    @StateObject var viewModel = MainViewModel()
    @State private var animationScale: Bool = false
    @State var remove = false
    
    var searchResults: [City] {
        if viewModel.searchItem.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter { $0.name.contains(viewModel.searchItem) }
        }
    }    
    //MARK: - Init
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        ZStack {
            
            NavigationView {
                //MARK: - View
                if remove {
                List {
                    if Reachability.isConnectedToNetwork() {
                        NavigationLink(
                            destination: DetailView(weatherDetails: viewModel.city, isNavigationLink: true, hideSheet: $viewModel.showSheet),
                            label: {
                                if viewModel.city != nil  {
                                    TemperatureDescriptionCell(viewModel.city)
                                } else {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                                }
                            })
                            .accessibilityIdentifier("navlocation")
                            .buttonStyle(PlainButtonStyle())
                            .disabled(viewModel.showAddView || viewModel.showAttentionLabel || viewModel.showSetiingsView)
                    } else {
                        Text("no_internet".localized(viewModel.language))
                    }
                    
                    if searchResults.count != 0 || viewModel.searchItem.isEmpty {
                        ForEach(searchResults.indices, id: \.self) { index in
                            Button {
                                viewModel.currentCity = searchResults[index]
                                DispatchQueue.main.async {
                                    if viewModel.currentCity != nil {
                                        viewModel.showSheet.toggle()
                                    } else {
                                        print("oops")
                                    }
                                }
                            } label: {
                                if viewModel.flagForError == false {
                                    TemperatureDescriptionCell(searchResults[index])
                                        .contextMenu(ContextMenu(menuItems: {
                                            Button(action: {
                                                withAnimation(.easeIn) {
                                                    viewModel.deleteCityFromDB(city: searchResults[index])
                                                    viewModel.fetchAllFromDB()
                                                }
                                            }, label: {
                                                Text("delete".localized(viewModel.language))
                                            })
                                        }))
                                        .disabled(viewModel.showAddView || viewModel.showAttentionLabel || viewModel.showSetiingsView || viewModel.flagForError)
                                } else {
                                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                                }
                            }
                            .accessibilityIdentifier("\(searchResults[index].name)")
                            .buttonStyle(PlainButtonStyle())
                            .swipeActions {
                                Button {
                                    withAnimation(.easeIn) {
                                        viewModel.deleteCityFromDB(city: searchResults[index])
                                        viewModel.fetchAllFromDB()
                                    }
                                } label: {
                                    Text("delete".localized(viewModel.language))
                                }
                            }
                        }
                    } else {
                        SearchedCity(viewModel: viewModel)
                    }
                    
                }
                .onAppear {
                    if Reachability.isConnectedToNetwork() {
                        viewModel.fetchAllFromDB()
                        viewModel.getNewWeatherForAllCities()
                        Task(priority: .background) {
                            await viewModel.getCurrnetWeather()
                        }
                    } else {
                        viewModel.fetchAllFromDB()
                    }
                }
                .accessibilityIdentifier("list")
                .searchable(text: $viewModel.searchItem)
                .refreshable {
                    if Reachability.isConnectedToNetwork() {
                        viewModel.getNewWeatherForAllCities()
                        Task {
                            await viewModel.getCurrnetWeather()
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.AsyncSeconds.asyncHalfSecond) {
                            withAnimation(.easeInOut) {
                                viewModel.showAttentionLabel.toggle()
                            }
                        }
                    }
                }
                .listStyle(InsetListStyle())
                .fullScreenCover(isPresented: $viewModel.showSheet) {
                    if viewModel.currentCity != nil {
                        DetailView(weatherDetails: viewModel.currentCity, isNavigationLink: false, hideSheet: $viewModel.showSheet)
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .onReceive(viewModel.timer) { _ in
                                viewModel.showSheet.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.AsyncSeconds.asyncSecond) {
                                    viewModel.showAttentionLabel = true
                                    viewModel.isThisNoInternetAttentionView = false
                                }
                            }
                            .accessibilityIdentifier("progress")
                    }
                }
                    
                .navigationBarTitle("cities".localized(viewModel.language))
                .navigationBarItems(leading:
                                        HStack {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            viewModel.showSetiingsView.toggle()
                        }
                    }, label: {
                        Image(systemName: "gear")
                    }).accessibilityIdentifier("Gear")
                    
                    
                },
                                    trailing: Button(action: {
                    withAnimation(.easeInOut) {
                        viewModel.showAddView.toggle()
                    }
                }, label: {
                    Image(systemName: "plus")
                })
                .accessibilityIdentifier("showCityButton"))
                .disabled(viewModel.showAddView || viewModel.showAttentionLabel || viewModel.showSetiingsView)
                }
                
                
                    
            }
            .padding(1)
            .navigationViewStyle(StackNavigationViewStyle())
            .blur(radius: viewModel.showAddView || viewModel.showAttentionLabel || viewModel.showSetiingsView ? Constants.Blurs.mainViewBlur : Constants.Blurs.zeroBlur)
            .overlay(AddCityView(viewModel: viewModel)
                        .offset(y: viewModel.showAddView ? Constants.Offsets.zeroOffset : Constants.Offsets.viewOffset))
            .overlay(AttentionView(showAttentionLabel: $viewModel.showAttentionLabel, isThisNoInternetAttentionView: $viewModel.isThisNoInternetAttentionView)
                        .offset(y: viewModel.showAttentionLabel ? Constants.Offsets.zeroOffset : Constants.Offsets.viewOffset)
            )
            .overlay(SettingsView(viewModel: viewModel, showSettingsView: $viewModel.showSetiingsView)
                        .offset(y: viewModel.showSetiingsView ? Constants.Offsets.zeroOffset : Constants.Offsets.viewOffset)
            )
            
            if !remove {
                Color.yellow
                    .ignoresSafeArea()
                    .mask {
                        Rectangle()
                            .ignoresSafeArea()
                            .overlay(
                                Image("sun1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: Constants.Heights.settingsViewMaxHeight1, height: Constants.Heights.settingsViewMaxHeight1)
                                    .scaleEffect(animationScale ? Constants.ScaleEffects.successScale : Constants.ScaleEffects.defaultScale)
                                    .blendMode(.destinationOut)
                                    
                            )
                    }
            }
            
            if viewModel.result == .OK {
                ResultView(viewModel: viewModel)
            } else if viewModel.result == .ERROR {
                ResultView(viewModel: viewModel)
            }
            
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: Constants.AsyncSeconds.successSeconds).delay(Constants.AsyncSeconds.successSeconds)) {
                animationScale.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.AsyncSeconds.successSecond2) {
                remove = true
            }
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
