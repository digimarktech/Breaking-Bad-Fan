//
//  HomeView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/18/21.
//

import SwiftUI
import Kingfisher

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
                        CarouselCardView(imageName: "season1"),
                        CarouselCardView(imageName: "season2"),
                        CarouselCardView(imageName: "season4")
                    ])
                    .frame(height: 300)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Characters")
                                .font(.title)
                                .fontWeight(.medium)
                            Spacer()
                            Button("View All") {
                                print("View all was pressed")
                            }
                        }
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 24) {
                                ForEach(homeViewModel.characters) { character in
                                    VStack(alignment: .leading) {
                                        NavigationLink(destination: CharacterDetailView(character: character)) {
                                            KFImage(character.imageURL)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 200, height: 300)
                                                .clipped()
                                                .cornerRadius(10)
                                        }
                                        Text(character.name)
                                            .font(.subheadline)
                                    }
                                    .padding(.bottom, 16)
                                }
                            }
                        }
                    }.padding(.horizontal)
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
