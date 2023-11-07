//
//  LocationViewModel.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation
import Observation

@Observable
class LocationViewModel {
    static var preview = LocationViewModel(service: WeatherLocationService())

    var searchText = ""
    var isSearchActive: Bool = false
    
    private let locationService: LocationService
    
    private var locationTask: Task<Void, Error>?
    
    init(service: LocationService) {
        self.locationService = service
    }
    
    var locations: [Location] = []
    
    func getLocations() {
        cancelOngoingTask()
        self.locationTask = Task {
            do {
                try await Task.sleep(for: .seconds(0.5))
                self.locations = try await locationService.getLocationSerachResults(for: searchText)
            } catch let error {
                print(error)
            }
        }
    }
    
    func cancelOngoingTask() {
        locationTask?.cancel()
    }
}
