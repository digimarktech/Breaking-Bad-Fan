//
//  HomeView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/18/21.
//

import SwiftUI

/// Represents the home screen of the app.
struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var locationViewModel = LocationViewModel()
    @State private var isPresented = false
    @State private var isPresentingAlert = false
    @State private var locationPersmissionsError: LocationPermissionError?
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    InfinitePageView(pages: [
                        CarouselImageCardView(imageName: "season1"),
                        CarouselImageCardView(imageName: "season2"),
                        CarouselImageCardView(imageName: "season4")
                    ])
                    .frame(height: 300)
                    CharactersView()
                        .environmentObject(homeViewModel)
                    .navigationBarTitle("Breaking Bad")
                    .navigationBarItems(trailing: Button(action: {
                        checkAuthorizationStatus()
                    }, label: {
                        Image(systemName: "location")
                    }))
                    
                }
                .edgesIgnoringSafeArea(.bottom)
                .alert(isPresented: homeViewModel.isPresentingAlert) {
                    Alert(title: Text(homeViewModel.apiError?.errorDescription ?? ""), message: Text(homeViewModel.apiError?.failureReason ?? ""), dismissButton: .default(Text("OK")))
                }
                
            }
            .onAppear {
                self.homeViewModel.getCharacters()
                locationViewModel.requestPermission()
            }
            .sheet(isPresented: $isPresented) {
                LocationView()
                    .environmentObject(locationViewModel)
            }
            .alert(isPresented: $isPresentingAlert) {
                Alert(title: Text(locationPersmissionsError?.errorDescription ?? ""), message: Text(locationPersmissionsError?.failureReason ?? ""), dismissButton: .default(Text("Ok")))
            }
            if homeViewModel.isLoading {
                SpinnerView()
            }
        }
        
    }
    
    private func checkAuthorizationStatus() {
        switch locationViewModel.authorizationStatus {
        case .notDetermined:
            locationViewModel.requestPermission()
        case .authorizedAlways, .authorizedWhenInUse:
            isPresented.toggle()
        case .denied:
            self.locationPersmissionsError = .denied
            self.isPresentingAlert.toggle()
        case .restricted:
            self.locationPersmissionsError = .restricted
            self.isPresentingAlert.toggle()
        @unknown default:
            self.locationPersmissionsError = .unknown
            self.isPresentingAlert.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
