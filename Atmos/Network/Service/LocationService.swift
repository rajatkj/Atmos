//
//  LocationService.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

protocol LocationService {
    func getLocationSerachResults(for searchText: String) async throws -> [Location]
}

class WeatherLocationService: LocationService {
//https://geocode.maps.co/search?q=
    
    let networkManager: NetworkManager
    init(networkManager: NetworkManager = DefaultNetworkManager(environment: LocationEnvironment())) {
        self.networkManager = networkManager
    }
    
    func getLocationSerachResults(for searchText: String) async throws -> [Location] {
        let request = LocationRequest(searchText: searchText)
        let (locations, _) = try await networkManager.perform(request)
        return locations
    }
}
