//
//  MapData.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/23/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import Foundation

// MapDataResponse - This is a pared-down version of the possible returns from the open cage api.
struct MapDataResponse: Codable {
    
    var results: [MapResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct MapResult: Codable, Hashable {
    
    var annotations: MapAnnotation
    var shortDesc: String
    var components: MapComponents
    
    enum CodingKeys: String, CodingKey {
        case annotations = "annotations"
        case shortDesc = "formatted"
        case components = "components"
    }
    
    static func == (lhs: MapResult, rhs: MapResult) -> Bool {
        return lhs.shortDesc == rhs.shortDesc && lhs.annotations == rhs.annotations
    }
}

struct MapAnnotation: Codable, Hashable {
    
    var osm: OSM
    var flag: String
    
    enum CodingKeys: String, CodingKey {
        case osm = "OSM"
        case flag = "flag"
    }
    
    static func == (lhs: MapAnnotation, rhs: MapAnnotation) -> Bool {
        return lhs.osm == rhs.osm && lhs.flag == rhs.flag
    }
}

// The results returned are sometimes not obvious as to what they are. Type will tell you if the result is an airport or a city or a country, etc.
struct MapComponents: Codable, Hashable {
    var type: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
    }
}

struct OSM: Codable, Hashable {
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
