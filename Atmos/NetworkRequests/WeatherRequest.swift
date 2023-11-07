//
//  WeatherRequest.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

struct WeatherRequest: NetworkRequest {
    typealias Response = Weather
    
    var networkResourceName: String = "forecast"
    
    var lat, long: String
    
    init(lat: String, long: String) {
        self.lat = lat
        self.long = long
    }
    
    var query: [String : String] {
        [
            "latitude": lat,
            "longitude": long,
            "current": "temperature_2m,apparent_temperature,rain,cloud_cover,wind_direction_10m,wind_gusts_10m,wind_speed_10m"
        ]
    }
    
}
