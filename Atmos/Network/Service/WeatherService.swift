//
//  WeatherService.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

protocol WeatherService {
    func getWeather(lat: String, long: String) async throws -> Weather
}

class WeatherServiceImpl: WeatherService {
    let networkManager: NetworkManager
    init(networkManager: NetworkManager = DefaultNetworkManager(environment: WeatherEnvironment(), modelMapper: NoStrategyModelMapper())) {
        self.networkManager = networkManager
    }
    
    func getWeather(lat: String, long: String) async throws -> Weather {
        let request = WeatherRequest(lat: lat, long: long)
        let (weather, debug) = try await networkManager.perform(request)
        return weather
    }
}
