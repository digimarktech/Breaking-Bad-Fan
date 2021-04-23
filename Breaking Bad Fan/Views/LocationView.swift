//
//  LocationView.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import SwiftUI
import CoreLocation

/// A `View` subclass that displays the users location information
struct LocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    /// Returns the last known coordinate of this device.
    private var coordinate: CLLocationCoordinate2D? {
        return locationViewModel.lastLocation?.coordinate
    }
    
    /// Returns the city name or abbreviated city name if available.
    private var cityName: String? {
        return locationViewModel.currentPlacemark?.administrativeArea
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Latitude: \(coordinate?.latitude ?? 0)")
                Text("Longitude: \(coordinate?.longitude ?? 0)")
                if let cityName = cityName {
                    Text("City: \(cityName)")
                }
            }
            .font(.title)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            }))
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
