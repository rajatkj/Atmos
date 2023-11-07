//
//  Location.swift
//  Atmos
//
//  Created by Rajat Jangra on 07/11/23.
//

import Foundation

struct Location: Codable, Identifiable {
    var id: Int {
        placeId
    }
    
    let placeId: Int
    let licence: String
    let osmId: Int
    let boundingbox: [String]
    let lat, lon, displayName: String
    let `class`: String
    let type: String
    let importance: Double
    
    static var preview = Location(displayName: "Delhi")
    
//    init(displayName: String) {
//        
//    }
    
    init(displayName: String) {
        self.placeId = 0
        self.licence = "licence"
        self.osmId = 34
        self.boundingbox = ["bouding box"]
        self.lat = "54"
        self.lon = "55"
        self.displayName = displayName
        self.type = ""
        self.importance = 7
        self.class = "class"
    }
    
//    enum CodingKeys: String, CodingKey {
//        case placeID = "place_id"
//        case licence
//        case osmType = "osm_type"
//        case osmID = "osm_id"
//        case boundingbox, lat, lon
//        case displayName = "display_name"
//        case locationClass = "class"
//        case type, importance
//    }
    
}


enum OsmType: String, Codable {
    case node = "node"
    case relation = "relation"
}
