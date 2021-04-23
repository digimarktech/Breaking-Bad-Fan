//
//  LocationViewModel.swift
//  Breaking Bad Fan
//
//  Created by Marc Aupont on 4/23/21.
//

import CoreLocation
import SwiftUI

/// An `ObservableObject` used to manage the user location.
final class LocationViewModel: NSObject, ObservableObject {
    
    // MARK: - Published Properties
    
    /// Provides the authorization status of the users location permissions.
    @Published var authorizationStatus: CLAuthorizationStatus
    
    /// The last location the device was at.
    @Published var lastLocation: CLLocation?
    
    /// The current placemark for the device.
    @Published var currentPlacemark: CLPlacemark?
    
    private let locationManager: CLLocationManager
    
    /// Creates a `LocationViewModel`.
    override init() {
        self.locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Private methods
    
    private func getPlacemark(for location: CLLocation?) -> CLPlacemark? {
        guard let location = location else {
            return nil
        }
        var placeMarkToReturn: CLPlacemark?
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                placeMarkToReturn = placemarks?.first
            }
        }
        return placeMarkToReturn
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationViewModel: CLLocationManagerDelegate {
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.first
        self.currentPlacemark = getPlacemark(for: locations.first)
    }
}
