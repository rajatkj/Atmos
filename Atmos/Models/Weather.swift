//
//  Weather.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

struct Weather: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
    }
    
    static var preview = Weather(latitude: 50, longitude: 20, generationtimeMS: 0, utcOffsetSeconds: 0, timezone: "GMT", timezoneAbbreviation: "gmt", elevation: 50, currentUnits: .preview, current: .preview)
    
    var apparentTemperature: String {
        "\(current.apparentTemperature.description)\(currentUnits.apparentTemperature)"
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M, apparentTemperature: Double
    let rain, cloudCover, windDirection10M: Int
    let windGusts10M: Double
    let windSpeed10M: Double

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case rain
        case cloudCover = "cloud_cover"
        case windDirection10M = "wind_direction_10m"
        case windGusts10M = "wind_gusts_10m"
        case windSpeed10M = "wind_speed_10m"
    }
    
    static var preview = Current(time: "20", interval: 50, temperature2M: 50, apparentTemperature: 50, rain: 50, cloudCover: 55, windDirection10M: 90, windGusts10M: 45, windSpeed10M: 50)

}

// MARK: - CurrentUnits
struct CurrentUnits: Codable {
    let time, interval, temperature2M, apparentTemperature: String
    let rain, cloudCover, windDirection10M, windGusts10M, windSpeed10M: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case rain
        case cloudCover = "cloud_cover"
        case windDirection10M = "wind_direction_10m"
        case windGusts10M = "wind_gusts_10m"
        case windSpeed10M = "wind_speed_10m"
    }
    
    static var preview = CurrentUnits(time: "m", interval: "m", temperature2M: "c", apparentTemperature: "c", rain: "m", cloudCover: "mm", windDirection10M: "m/s", windGusts10M: "m/s", windSpeed10M: "m/s")
}
