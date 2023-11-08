//
//  WeatherViewModel.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

@Observable
class WeatherViewModel {
    static var preview = WeatherViewModel(service: WeatherServiceImpl())
    
    private let service: WeatherService
    var locationManager: LocationManager = LocationManager()
    var weather: Weather?
    var selectedLocation: Location?
    
    var isLoading: Bool = false

    var placeName: String {
        if selectedLocation == nil {
            return self.locationManager.placeName ?? ""
        } else {
            return selectedLocation?.displayName.components(separatedBy: ",").first ?? ""
        }
    }
    
    init(service: WeatherService) {
        self.service = service
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.locationManager.update()
        }
    }
    
    
    @MainActor
    func getWeather() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let location = getCurrentCoordinates()
            weather = try await service.getWeather(lat: location.lat, long: location.long)
            
        } catch let error {
            print(error)
        }
    }
    
    private func getCurrentCoordinates() -> (lat: String,long: String) {
        if let location = selectedLocation {
            return (location.lat, location.lon)
        } else if let gpsLocation = locationManager.gpsLocation {
            return (String(gpsLocation.latitude), String(gpsLocation.longitude))
        } else {
            return ("52.52", "13.41")
        }
    }
    
    
}

