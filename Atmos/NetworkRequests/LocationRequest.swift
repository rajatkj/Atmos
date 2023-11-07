//
//  LocationRequest.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

struct LocationRequest: NetworkRequest {
    typealias Response = [Location]
    
    var networkResourceName: String = ""
    
    var searchText: String
    
    var query: [String: String] {
        ["q": searchText]
    }
    
}
