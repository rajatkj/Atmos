//
//  NetworkManager.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

protocol NetworkManager {
    var session: URLSession { get }
    var environment: NetworkEnvironment { get }
    func perform<T>(_ request: T) async throws -> (T.Response, DebugData?) where T: NetworkRequest
}

protocol NetworkURLSession {
    
}

struct DefaultNetworkManager: NetworkManager {
    
    var session: URLSession
    var environment: NetworkEnvironment
    var modelMapper: ModelMapper
    
    init(environment: NetworkEnvironment = DefaultNetworkEnvironment(), config: URLSessionConfiguration = .default, modelMapper: ModelMapper = DefaultModelMapper()) {
        self.session = URLSession(configuration: config)
        self.environment = environment
        self.modelMapper = modelMapper
    }
    
    func perform<T>(_ request: T) async throws -> (T.Response, DebugData?) where T : NetworkRequest {
        let urlRequest = try urlRequest(from: request, headers: request.headers)
        
        let (rawData, urlResponse) = try await session.data(for: urlRequest)
        
        let model = try modelMapper.mapModel(T.Response.self, from: rawData)
        
        let debugData = DebugData(response: String(data: rawData, encoding: .utf8), request: urlRequest.url?.path(), headers: request.headers)
        
        if let httpResponse = urlResponse as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw debugData
        }
        
        return (model, debugData)
    }
    
    private func urlRequest<T>(from request: T, headers: [String: String]) throws -> URLRequest where T: NetworkRequest {
        guard let url = URL(string: environment.baseURL + request.networkResourceName) else { throw NetworkError(message: "Invalid URL: \(environment.baseURL + request.networkResourceName)") }
        
        var queryItems: [URLQueryItem] = []
        for (key, value) in request.query {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        var urlRequest = URLRequest(url: url.appending(queryItems: queryItems))
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        try populateBody(request: &urlRequest, parameters: request.parameters)
        populateHeaders(request.headers, for: &urlRequest)
        
        return urlRequest
    }
    
    private func populateBody(request: inout URLRequest, parameters: [String: String]?) throws {
        guard let parameters = parameters, request.httpMethod != HTTPMethod.get.rawValue else { return }
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        
    }
    
    private func populateHeaders(_ headers: [String: String], for request: inout URLRequest) {
        request.setValue("application/JSON", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
