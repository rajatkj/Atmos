//
//  LocationManager.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation
import CoreLocation
import Observation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let notificationCenter = NotificationCenter.default
    
    var authStatus: CLAuthorizationStatus?
    var gpsLocation: CLLocationCoordinate2D?
    var placeName: String?
    
    override init() {
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        
    }

    func update() {
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        self.authStatus = self.manager.authorizationStatus
        fetchCurrentCoordinates()
        fetchPlaceName()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            fetchCurrentCoordinates()
            notificationCenter.post(name: Notification.Name("ChangedLocation"), object: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if (location.distance(from: CLLocation(latitude: (gpsLocation?.latitude ?? 52.01), longitude: (gpsLocation?.longitude ?? 10.77))) > 2500) { // if distance change > 2.5 km
                self.gpsLocation = location.coordinate
                notificationCenter.post(name: Notification.Name("ChangedLocation"), object: nil) // notify view
            }
        }
    }
    
    private func fetchCurrentCoordinates() {
        self.authStatus = self.manager.authorizationStatus
        
        if (self.manager.authorizationStatus == CLAuthorizationStatus.authorizedAlways || self.manager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse) {
            self.gpsLocation = self.manager.location?.coordinate
        }
    }
    
    private func fetchPlaceName() {
        guard let gpsLocation = gpsLocation else { return }
        let location = CLLocation(latitude: gpsLocation.latitude, longitude: gpsLocation.longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                return
            }

            if let placemark = placemarks?.first {
                if let name = placemark.locality {
                    self.placeName = name
                } else {
                    print("No location name found.")
                }
            } else {
                print("No placemarks found.")
            }
        }
    }
}
