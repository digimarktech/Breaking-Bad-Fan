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
    @State private var locationError: LocationError?
    
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
                
            }
            .onAppear {
                self.homeViewModel.getCharacters()
                locationViewModel.requestPermission()
            }
            .sheet(isPresented: $isPresented) {
                LocationView()
                    .environmentObject(locationViewModel)
            }
            .alert(item: $locationError) { locationError in
                Alert(title: Text(locationError.title), message: Text(locationError.message), dismissButton: .default(Text("Ok")))
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
            self.locationError = LocationError(title: "Permissions Denied", message: "Please allow location permissions in settings.")
        case .restricted:
            self.locationError = LocationError(title: "Permissions Restricted", message: "Location permissions are restricted")
        @unknown default:
            self.locationError = LocationError(title: "Unknown Error", message: "Unable to process location at this time.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
