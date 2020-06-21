//
//  CityBoundModel.swift
//  korydallos
//
//  Created by user172589 on 12/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import Foundation

// MARK: - CityBound
struct CityBound: Codable {
    let placeID: Int
    let licence, osmType: String
    let osmID: Int
    let boundingbox: [String]
    let lat, lon, displayName, cityBoundClass: String
    let type: String
    let importance: Double
    let icon: String
    let geojson: Geojson
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case osmType = "osm_type"
        case osmID = "osm_id"
        case boundingbox, lat, lon
        case displayName = "display_name"
        case cityBoundClass = "class"
        case type, importance, icon, geojson
    }
}

// MARK: - Geojson
struct Geojson: Codable {
    let type: String
    let coordinates: [[[Double]]]
}
