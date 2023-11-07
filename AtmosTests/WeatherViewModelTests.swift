//
//  WeatherViewModelTests.swift
//  AtmosTests
//
//  Created by Rajat Jangra on 07/11/23.
//

import XCTest
@testable import Atmos

final class WeatherViewModelTests: XCTestCase {
    
    class MockWeatherService: WeatherService {
        func getWeather(lat: String, long: String) async throws -> Weather {
            // Provide a mock Weather object for testing success case
            return Weather.preview
        }
    }
    
    class FailingWeatherService: WeatherService {
        func getWeather(lat: String, long: String) async throws -> Weather {
            // Simulate a failing scenario for testing error handling
            throw NetworkError.init(message: "Error: invalid response")
        }
    }
    
    func testGetWeatherWithSelectedLocationSuccess() async throws {
        let mockService = MockWeatherService()
        let viewModel = WeatherViewModel(service: mockService)
        
        // Simulate a selected location
        viewModel.selectedLocation = Location.preview
        
        // Execute the method
        await viewModel.getWeather()
        
        // Assert that the weather data is not nil
        XCTAssertNotNil(viewModel.weather)
        
        // Add more assertions based on the expected behavior
        XCTAssertEqual(viewModel.weather?.current.temperature2M, 50.0)
        XCTAssertEqual(viewModel.weather?.currentUnits.temperature2M, "c")
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    func testGetWeatherWithSelectedLocationFailure() async throws {
        let viewModel = WeatherViewModel(service: FailingWeatherService())
        
        // Simulate a selected location
        viewModel.selectedLocation = Location.preview
        
        // Execute the method
        await viewModel.getWeather()
        
        // Assert that the weather data is nil
        XCTAssertNil(viewModel.weather)
        
        // Add more assertions based on the expected behavior
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    func testGetWeatherWithoutSelectedLocationSuccess() async throws {
        let mockService = MockWeatherService()
        let viewModel = WeatherViewModel(service: mockService)
        
        // Execute the method without a selected location
        await viewModel.getWeather()
        
        // Assert that the weather data is not nil
        XCTAssertNotNil(viewModel.weather)
        
        // Add more assertions based on the expected behavior
        XCTAssertEqual(viewModel.weather?.current.temperature2M, 50.0)
        XCTAssertEqual(viewModel.weather?.currentUnits.temperature2M, "c")
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    func testGetWeatherWithoutSelectedLocationFailure() async throws {
        let viewModel = WeatherViewModel(service: FailingWeatherService())
        
        // Execute the method without a selected location
        await viewModel.getWeather()
        
        // Assert that the weather data is nil
        XCTAssertNil(viewModel.weather)
        
        // Add more assertions based on the expected behavior
        XCTAssertEqual(viewModel.isLoading, false)
    }

}
