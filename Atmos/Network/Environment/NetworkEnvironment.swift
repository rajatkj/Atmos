//
//  NetworkEnvironment.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation
protocol NetworkEnvironment {
    var baseURL: String { get }
}

struct DefaultNetworkEnvironment: NetworkEnvironment {
    enum InfoDictKey: String {
        case serverAddress = "ServerAddress"
    }
    
    var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: InfoDictKey.serverAddress.rawValue) as? String ?? ""
    }
}

struct LocationEnvironment: NetworkEnvironment {
    var baseURL: String = "https://geocode.maps.co/search"
}

struct WeatherEnvironment: NetworkEnvironment {
    var baseURL: String = "https://api.open-meteo.com/v1/"
}
