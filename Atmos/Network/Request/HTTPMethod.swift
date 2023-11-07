//
//  HTTPMethod.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct NetworkError: Codable, Error {
    let message: String?
}

