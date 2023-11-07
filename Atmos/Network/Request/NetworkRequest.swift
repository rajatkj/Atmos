//
//  NetworkRequest.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

protocol NetworkRequest: Codable {
    
    associatedtype Response: Codable
    
    var networkResourceName: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var headers: [String: String] { get }
    var query: [String: String] { get }
}

extension NetworkRequest {
    var httpMethod: HTTPMethod {
        .get
    }
    
    var parameters: [String: String]? {
        nil
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var query: [String: String] {
        [:]
    }
}

extension NetworkRequest {
    
}

struct DebugData: Error {
    var response: String?
    var request: String?
    var headers: [String: String]?
    var error: NetworkError?
}
