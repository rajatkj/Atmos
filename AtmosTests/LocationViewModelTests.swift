//
//  LocationViewModelTests.swift
//  AtmosTests
//
//  Created by Rajat Jangra on 07/11/23.
//

import XCTest
@testable import Atmos

class LocationViewModelTests: XCTestCase {
    
    class MockLocationService: LocationService {
        func getLocationSerachResults(for query: String) async throws -> [Location] {
            // Provide a mock array of locations for testing
            try await Task.sleep(for: .seconds(0.5))
            return [Location(displayName: query), Location(displayName: query)]
        }
    }
    
    class FailingLocationService: LocationService {
        func getLocationSerachResults(for query: String) async throws -> [Location] {
            // Simulate a failing scenario for testing error handling
            throw NetworkError.init(message: "No Location")
        }
    }
    
    func testGetLocationsSuccess() async {
        let mockService = MockLocationService()
        let viewModel = LocationViewModel(service: mockService)
        
        // Set the search text
        viewModel.searchText = "Test"
        
        // Execute the method
        viewModel.getLocations()
        
        try? await Task.sleep(for: .seconds(1.25))
        // Assert that the locations array is not empty
        XCTAssertFalse(viewModel.locations.isEmpty)
        
        // Add more assertions based on the expected behavior
        XCTAssertEqual(viewModel.locations.count, 2)
        XCTAssertEqual(viewModel.locations[0].displayName, "Test")
        XCTAssertEqual(viewModel.locations[1].displayName, "Test")
    }
    
    func testGetLocationsFailure() async {
        let viewModel = LocationViewModel(service: FailingLocationService())
        
        // Set the search text
        viewModel.searchText = "Test"
        
        // Execute the method
        viewModel.getLocations()
        
        // Allow time for the asynchronous task to complete
        try? await Task.sleep(for: .seconds(1.25))
        
        // Assert that the locations array is empty due to failure
        XCTAssertTrue(viewModel.locations.isEmpty)
        
        // Add more assertions based on the expected behavior
    }
    
    func testCancelLocationTask() {
        let mockService = MockLocationService()
        let viewModel = LocationViewModel(service: mockService)
        
        // Set the search text
        viewModel.searchText = "Test"
        
        // Execute the method (simulating a task)
        viewModel.getLocations()
        
        // Cancel the task
        viewModel.cancelOngoingTask()
        
        // Assert that the locations array remains unchanged
        XCTAssertTrue(viewModel.locations.isEmpty)
        
    }

}
